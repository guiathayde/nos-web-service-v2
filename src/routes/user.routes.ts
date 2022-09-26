import { Router } from 'express';

import { createUser } from '../controllers/UserController/createUser';
import { login } from '../controllers/UserController/login';

const usersRouter = Router();

usersRouter.post('/signup', createUser);
usersRouter.post('/signin', login);

export default usersRouter;
