CREATE TABLE IF NOT EXISTS users (
    id bigserial PRIMARY KEY,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    email text NOT NULL,
    encrypted_password text NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS users_email_index ON users (email);
