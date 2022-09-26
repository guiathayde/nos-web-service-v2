import { Request, Response } from 'express';
import validator from 'validator';
import { PrismaClient } from '@prisma/client';

import AppError from '../../errors/AppError';

export async function createUser(request: Request, response: Response) {
  const { name, email, password } = request.body;

  if (!name || !email || !password) {
    throw new AppError('Nome, e-mail ou senha vazia.', 403);
  }

  if (!validator.isEmail(email)) {
    throw new AppError('E-mail inválido.', 403);
  }

  const prisma = new PrismaClient();

  const verifyEmail = await prisma.user.findUnique({
    where: { email },
  });
  if (verifyEmail) {
    throw new AppError('E-mail já cadastrado.', 403);
  }

  const user = await prisma.user.create({
    data: {
      name,
      email,
      password,
    },
  });

  return response.status(201).json({
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      isAdmin: user.isAdmin,
    },
  });
}
