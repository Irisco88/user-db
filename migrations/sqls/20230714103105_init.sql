-- +goose Up
-- +goose StatementBegin
CREATE TABLE users
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255),
    user_name  VARCHAR(255) NOT NULL,
    email      VARCHAR(255),
    password   VARCHAR(255) NOT NULL,
    role       INTEGER      NOT NULL DEFAULT 0,
    avatar     VARCHAR(500),
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX idx_users_unique_email ON users (email);
CREATE UNIQUE INDEX idx_users_unique_user_name ON users (user_name);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS users;
-- +goose StatementEnd
