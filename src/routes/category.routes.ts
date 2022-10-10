import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../config/uploadFile';

import { ensureAuthenticated } from '../middleware/ensureAuthenticated';
import { ensureAdmin } from '../middleware/ensureAdmin';

import { createCategory } from '../controllers/CategoryController/createCategory';

const categoryRouter = Router();

const upload = multer(uploadConfig.multer);

categoryRouter.post(
  '/create',
  ensureAuthenticated,
  ensureAdmin,
  upload.single('image'),
  createCategory,
);

export default categoryRouter;
