--! Previous: sha1:5aa0a3886281d3f4205cf4fc07801beb7841607a
--! Hash: sha1:8dce514638fb03d51ef6529e182e9ec864245654
--! Message: Create notes table

CREATE TABLE IF NOT EXISTS notes (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  created_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id uuid REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
);

CREATE OR REPLACE TRIGGER update_notes_updated_at
  BEFORE UPDATE
  ON notes
  FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();
