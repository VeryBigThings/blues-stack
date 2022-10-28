--! Previous: -
--! Hash: sha1:3e16d3c8a421e02e8d43cd0d64e158bca001005e
--! Message: Support UPDATE updated_at & citext

CREATE EXTENSION IF NOT EXISTS citext;

CREATE OR REPLACE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS
$$
BEGIN
    IF row (NEW.*) IS DISTINCT FROM row (OLD.*) THEN
        NEW.updated_at = now();
        RETURN NEW;
    ELSE
        RETURN OLD;
    END IF;
END;

$$ language 'plpgsql';
