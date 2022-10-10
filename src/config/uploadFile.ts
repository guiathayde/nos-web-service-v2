// Quem sabe um dia usamos uma CDN para armazenar as imagens. Template caso usar a CDN da AWS.

import path from 'path';
import crypto from 'crypto';
import multer, { StorageEngine } from 'multer';

const tmpFolder = path.resolve(__dirname, '..', '..', 'tmp');

interface IUploadConfig {
  driver: 's3' | 'disk';

  tmpFolder: string;
  uploadsFolder: string;

  multer: {
    storage: StorageEngine;
  };

  config: {
    disk: {};
    aws: {
      bucket: string;
    };
  };
}

export default {
  driver: process.env.STORAGE_DRIVER,

  tmpFolder,
  uploadsFolder: path.resolve(__dirname, '..', '..', 'files'),

  multer: {
    storage: multer.diskStorage({
      destination: tmpFolder,
      filename(request, file, callback) {
        const fileHashName = `${crypto.randomBytes(10).toString('hex')}.jpeg`;

        return callback(null, fileHashName);
      },
    }),
  },

  config: {
    disk: {},
    aws: {
      bucket: process.env.STORAGE_BUCKET,
    },
  },
} as IUploadConfig;
