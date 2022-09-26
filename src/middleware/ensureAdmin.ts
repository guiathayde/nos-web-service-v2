import { NextFunction, Request, Response } from 'express';
import AppError from '../errors/AppError';

import { PrismaClient } from '@prisma/client';

export async function ensureAdmin(
  request: Request,
  response: Response,
  next: NextFunction,
) {
  const prisma = new PrismaClient();

  const user = await prisma.user.findUnique({
    where: {
      id: request.user.id,
    },
  });

  if (!user) {
    throw new AppError('Usuário não encontrado.', 403);
  } else if (!user.isAdmin) {
    throw new AppError('Usuário não é administrador.', 403);
  }

  return next();
}
