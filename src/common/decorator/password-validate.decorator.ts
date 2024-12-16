import { registerDecorator, ValidationOptions } from 'class-validator';

export function IsPasswordValid(validationOptions?: ValidationOptions) {
  return function (object: object, propertyName: string) {
    registerDecorator({
      name: 'isPasswordValid',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: {
        validate(value: any) {
          if (typeof value !== 'string' || value.length < 8) {
            return false;
          }
          if (!/[A-Z]/.test(value)) {
            return false;
          }
          if (!/[a-z]/.test(value)) {
            return false;
          }
          if (!/[0-9]/.test(value)) {
            return false;
          }

          if (!/[!@#$%^&*]/.test(value)) {
            return false;
          }
          return true;
        },
        defaultMessage() {
          return 'Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character.';
        },
      },
    });
  };
}
