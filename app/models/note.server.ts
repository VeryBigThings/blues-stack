import { db } from "~/db.server";
import { Table } from "ts-sql-query/Table";

class Note extends Table {
  id = this.autogeneratedPrimaryKey("id", "uuid");
  title = this.column("title", "string");
  body = this.column("body", "string");
  userId = this.column("user_id", "uuid");
  createdAt = this.column("created_at", "timestamp");
  updatedAt = this.column("updated_at", "timestamp");

  constructor() {
    super("notes");
  }
}

const note = new Note();

export function getNote({
  id,
  userId,
}: Pick<Note, "id"> & {
  userId: User["id"];
}) {
  return db
    .selectFrom(note)
    .select({ id: note.id, title: note.title, body: note.body })
    .where(note.id.equals(id))
    .and(note.userId.equals(userId))
    .executeSelectNoneOrOne();
}

export function getNoteListItems({ userId }: { userId: User["id"] }) {
  return db
    .selectFrom(note)
    .select({ id: note.id, title: note.title })
    .where(note.userId.equals(userId))
    .executeSelectMany();
}

export function createNote({
  body,
  title,
  userId,
}: Pick<Note, "body" | "title"> & {
  userId: User["id"];
}) {
  return db
    .insertInto(note)
    .set({ title: title, body: body, userId: userId })
    .executeInsert();
}

export function deleteNote({
  id,
  userId,
}: Pick<Note, "id"> & { userId: User["id"] }) {
  return db
    .where(note.id.equals(id))
    .and(note.userId.equals(userId))
    .executeDelete();
}
