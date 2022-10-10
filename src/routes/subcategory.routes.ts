import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../config/uploadFile';

import { ensureAuthenticated } from '../middleware/ensureAuthenticated';
import { ensureAdmin } from '../middleware/ensureAdmin';

import { createSubcategory } from '../controllers/SubcategoryController/createSubcategory';

const itemRouter = Router();

const upload = multer(uploadConfig.multer);

itemRouter.post(
  '/create',
  ensureAuthenticated,
  ensureAdmin,
  upload.single('image'),
  createSubcategory,
);

export default itemRouter;
