import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../config/uploadFile';

import { ensureAuthenticated } from '../middleware/ensureAuthenticated';
import { ensureAdmin } from '../middleware/ensureAdmin';

import { createItem } from '../controllers/ItemController/createItem';

const itemRouter = Router();

const upload = multer(uploadConfig.multer);

itemRouter.post(
  '/create',
  ensureAuthenticated,
  ensureAdmin,
  upload.single('image'),
  createItem,
);

export default itemRouter;
