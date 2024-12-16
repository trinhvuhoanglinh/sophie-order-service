import { Body, Controller, Get, Param, Post, Query } from '@nestjs/common';
import { OrderService } from './order.service';

@Controller('orders')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  // Get sales orders with filters, sorting, and pagination
  @Get()
  async getSalesOrders(
    @Query('years') years?: string,
    @Query('email') email?: string,
    @Query('status') status?: string,
    @Query('grandTotalMax') grandTotalMax?: string,
    @Query('grandTotalMin') grandTotalMin?: string,
    @Query('sort') sort?: string,
    @Query('page') page: number = 1,
    @Query('pageSize') pageSize: number = 10,
  ) {
    return await this.orderService.getSalesOrders(
      years,
      email,
      status,
      grandTotalMax,
      grandTotalMin,
      sort,
      page,
      pageSize,
    );
  }

  // Create a new sales order
  @Post(':year')
  async createSalesOrder(@Param('year') year: string, @Body() data: any) {
    return this.orderService.createSalesOrder(year, data);
  }
}
