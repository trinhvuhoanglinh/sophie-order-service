# Chọn image Node.js 20
FROM node:18.20.4

# Đặt thư mục làm việc
WORKDIR /usr/src/app

# Sao chép package.json và yarn.lock
COPY package*.json ./
COPY yarn.lock ./

# Cài đặt dependencies
RUN yarn install

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Biên dịch TypeScript (nếu bạn sử dụng TypeScript)
RUN yarn build

# Chạy ứng dụng
CMD ["yarn", "start:prod"]

# Mở cổng ứng dụng
EXPOSE 3001
