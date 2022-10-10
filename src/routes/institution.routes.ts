import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../config/uploadFile';

import { ensureAuthenticated } from '../middleware/ensureAuthenticated';
import { ensureAdmin } from '../middleware/ensureAdmin';

import { createInstitution } from '../controllers/InstitutionController/createInstitution';
import { getAllInstitutions } from '../controllers/InstitutionController/getAllInstitutions';
import { updateInstitutionById } from '../controllers/InstitutionController/updateInstitutionById';
import { deleteInstitution } from '../controllers/InstitutionController/deleteInstitution';

const institutionRouter = Router();

const upload = multer(uploadConfig.multer);

institutionRouter.post(
  '/create',
  ensureAuthenticated,
  ensureAdmin,
  upload.fields([
    { name: 'profileImage', maxCount: 1 },
    { name: 'galleryImages', maxCount: 6 },
  ]),
  createInstitution,
);
institutionRouter.get('/all', ensureAuthenticated, getAllInstitutions);
institutionRouter.patch(
  '/:id',
  ensureAuthenticated,
  ensureAdmin,
  upload.fields([
    { name: 'profileImage', maxCount: 1 },
    { name: 'galleryImages', maxCount: 6 },
  ]),
  updateInstitutionById,
);
institutionRouter.delete(
  '/:id',
  ensureAuthenticated,
  ensureAdmin,
  deleteInstitution,
);

export default institutionRouter;
