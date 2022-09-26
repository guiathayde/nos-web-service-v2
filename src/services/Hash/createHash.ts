import bcrypt from 'bcryptjs';

import AppError from '../../errors/AppError';

export async function createHash(string: string) {
  try {
    if (typeof process.env.BCRYPT_SALT === 'undefined') {
      throw new AppError('BCRYPT_SALT not defined.', 500);
    }

    const salt = await bcrypt.genSalt(Number(process.env.BCRYPT_SALT));
    return await bcrypt.hash(string, salt);
  } catch (err) {
    throw new AppError(`Error while hashing password: ${err}`, 500);
  }
}
