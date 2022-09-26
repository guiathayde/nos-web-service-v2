import { Router } from 'express';

import { ensureAuthenticated } from '../middleware/ensureAuthenticated';
import { ensureAdmin } from '../middleware/ensureAdmin';

import { createInstitution } from '../controllers/InstitutionController/createInstitution';

const institutionRouter = Router();

institutionRouter.post(
  '/create',
  ensureAuthenticated,
  ensureAdmin,
  createInstitution,
);

export default institutionRouter;
