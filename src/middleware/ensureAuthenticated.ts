import { Request, Response, NextFunction } from 'express';
import { verify } from 'jsonwebtoken';

import auth from '../config/auth';
import AppError from '../errors/AppError';

interface ITokenPayload {
  iat: number;
  exp: number;
  sub: string;
}

export function ensureAuthenticated(
  request: Request,
  response: Response,
  next: NextFunction,
): void {
  if (typeof auth.secret_token === 'undefined') {
    throw new AppError('Secret token not defined.', 500);
  }

  const authHeader = request.headers.authorization;

  if (!authHeader) {
    throw new AppError('Token is missing', 401);
  }

  const [, token] = authHeader.split(' ');

  try {
    const decoded = verify(token, auth.secret_token);

    const { sub } = decoded as ITokenPayload;

    request.user = {
      id: sub,
    };

    return next();
  } catch (err) {
    throw new AppError(`Invalid JWT token: ${JSON.stringify(err)}`, 401);
  }
}
