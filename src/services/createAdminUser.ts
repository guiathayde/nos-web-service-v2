import { PrismaClient } from '@prisma/client';

import AppError from '../errors/AppError';
import { createHash } from './Hash/createHash';

export function createAdminUser() {
  if (!process.env.ADMIN_PASSWORD) {
    throw new AppError('Admin password not defined.', 500);
  }

  const prisma = new PrismaClient();

  createHash(process.env.ADMIN_PASSWORD)
    .then(password => {
      if (!process.env.ADMIN_EMAIL || !process.env.ADMIN_NAME) {
        throw new AppError('Admin User not defined.');
      }

      prisma.user
        .upsert({
          where: {
            email: process.env.ADMIN_EMAIL,
          },
          update: {},
          create: {
            email: process.env.ADMIN_EMAIL,
            name: process.env.ADMIN_NAME,
            password,
            isAdmin: true,
          },
        })
        .catch((error: any) => {
          console.error('Connection error PostgresSQL', error);
        });
    })
    .catch(error => console.error(error));
}
