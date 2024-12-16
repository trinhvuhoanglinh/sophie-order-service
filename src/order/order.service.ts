import { Injectable } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class OrderService {
  constructor(private readonly prisma: PrismaService) {}

  // Get list of sales orders with filters, sorting, and pagination
  async getSalesOrders(
    years: string = '',
    email?: string,
    status?: string,
    grandTotalMax?: string,
    grandTotalMin?: string,
    sort?: string,
    page: number = 1,
    pageSize: number = 10,
  ) {
    const filters: any = {};
    if (email) filters.email = email;
    if (status) filters.status = status;
    if (grandTotalMax) filters.grandTotal = { lte: parseFloat(grandTotalMax) };
    if (grandTotalMin) filters.grandTotal = { gte: parseFloat(grandTotalMin) };

    const targetYears = years
      ? years.split(',').map((year) => parseInt(year.trim(), 10))
      : [2024, 2023, 2022];

    const skip = (page - 1) * pageSize;

    if (!sort || !sort.includes('createdAt')) {
      sort = sort ? `${sort},createdAt:desc` : 'createdAt:desc';
    }
    const sortFields = sort.split(',').map((s) => {
      const [field, order] = s.split(':');
      return { [field]: order === 'asc' ? 'asc' : 'desc' };
    });

    console.log('Sorting fields:', sortFields);

    const results: any[] = [];
    let remainingSkip = skip;
    let remainingTake = pageSize;
    let totalRecords = 0;

    const createdAtSort = sortFields.find((s) => s?.createdAt);
    if (createdAtSort?.createdAt === 'asc') {
      targetYears.sort((a, b) => a - b);
    } else {
      targetYears.sort((a, b) => b - a);
    }

    for (const targetYear of targetYears) {
      const tableName = `salesOrder${targetYear}`;

      console.log(`Querying table ${tableName}...`);

      const count = await this.prisma[tableName].count({
        where: filters,
      });
      totalRecords += count;

      if (count > 0) {
        if (remainingSkip >= count) {
          remainingSkip -= count;
        } else {
          const take = Math.min(remainingTake, count - remainingSkip);
          const data = await this.prisma[tableName].findMany({
            where: filters,
            orderBy: sortFields.length > 0 ? sortFields : undefined,
            skip: remainingSkip,
            take: take,
            include: { items: true },
          });

          console.log(`Fetched ${data.length} records from ${tableName}`);

          results.push(...data);
          remainingTake -= data.length;
          remainingSkip = 0;
        }
      }
    }

    if (sortFields.length > 0) {
      results.sort((a, b) => {
        for (const sortField of sortFields) {
          const field = Object.keys(sortField)[0];
          const order = sortField[field] === 'asc' ? 1 : -1;
          if (a[field] < b[field]) return -1 * order;
          if (a[field] > b[field]) return 1 * order;
        }
        return 0;
      });
    }
    return {
      data: results.slice(0, pageSize),
      meta: {
        currentPage: page,
        pageSize,
        totalRecords,
        totalPages: Math.ceil(totalRecords / pageSize),
        records: results.length,
      },
    };
  }

  async createSalesOrder(year: string, data: any) {
    try {
      const createdOrder = await this.prisma[`salesOrder${year}`].create({
        data: {
          orderId: `${year}-${uuidv4()}`,
          email: data.email,
          grandTotal: data.grandTotal,
          grandTotalIncTax: data.grandTotalIncTax,
          status: data.status,
          items: {
            create: data.items.map((item: any) => ({
              itemId: `${year}-${uuidv4()}`,
              sku: item.sku,
              price: item.price,
              priceIncTax: item.priceIncTax,
            })),
          },
        },
      });

      return createdOrder;
    } catch (error) {
      throw new Error(`Failed to create sales order: ${error.message}`);
    }
  }
}
