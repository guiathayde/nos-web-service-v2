import 'reflect-metadata';
import 'dotenv/config';
import 'express-async-errors';

import express, { NextFunction, Request, Response } from 'express';
import cors from 'cors';

import uploadConfig from './config/uploadFile';

import routes from './routes';
import AppError from './errors/AppError';

import { createAdminUser } from './services/createAdminUser';

createAdminUser();

const app = express();

app.use(cors());
app.use(express.json());
app.use('/api/files', express.static(uploadConfig.uploadsFolder));

app.use('/api', routes);

app.use(
  (err: Error, request: Request, response: Response, next: NextFunction) => {
    if (err instanceof AppError) {
      return response.status(err.statusCode).json({
        status: 'error',
        message: err.message,
      });
    }

    console.error(err);

    return response.status(500).json({
      status: 'error',
      message: 'Internal server error',
    });
  },
);

app.listen(3333, () => {
  console.log('Server is running on port 3333');
});
