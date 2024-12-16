import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { IUserTokenPayload } from '../interface';

export const User = createParamDecorator((ctx: ExecutionContext) => {
  const request = ctx.switchToHttp().getRequest();
  return request.user as IUserTokenPayload;
});
