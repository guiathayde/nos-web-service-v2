import bcrypt from 'bcryptjs';

export async function validateHash(string: string, hash: string) {
  return await bcrypt.compare(string, hash);
}
