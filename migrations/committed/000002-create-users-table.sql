--! Previous: sha1:3e16d3c8a421e02e8d43cd0d64e158bca001005e
--! Hash: sha1:5aa0a3886281d3f4205cf4fc07801beb7841607a
--! Message: Create users table

CREATE TABLE IF NOT EXISTS users (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS users_email_index ON users (email);

CREATE INDEX users_email_password_hash_index ON users (email, password_hash);

CREATE OR REPLACE TRIGGER update_users_updated_at
  BEFORE UPDATE
  ON users
  FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();
