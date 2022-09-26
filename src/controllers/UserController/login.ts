import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';
import jwt from 'jsonwebtoken';

import auth from '../../config/auth';
import AppError from '../../errors/AppError';
import { validateHash } from '../../services/Hash/validateHash';

export async function login(request: Request, response: Response) {
  if (typeof auth.secret_token === 'undefined') {
    throw new AppError('Secret token not defined.', 500);
  }

  const { email, password } = request.body;

  if (!email || !password) {
    throw new AppError('E-mail ou senha vazia.', 403);
  }

  const prisma = new PrismaClient();

  const user = await prisma.user.findUnique({
    where: { email },
  });

  if (!user) {
    throw new AppError('Usuário não encontrado.', 403);
  }

  const isValidPassword = await validateHash(password, user.password);
  if (!isValidPassword) {
    throw new AppError('E-mail ou senha inválidos.', 403);
  }

  const token = jwt.sign({}, auth.secret_token, {
    subject: user.id,
    expiresIn: '1d',
  });

  return response.json({
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      isAdmin: user.isAdmin,
    },
    token,
  });
}
