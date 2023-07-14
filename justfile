#!/usr/bin/env just --justfile

# clean build directory
clean:
    @[ -d "./bin" ] && rm -r ./bin && echo "bin directory cleaned" || true

# build and compress bineary
upx: build
    upx --best --lzma bin/migration

# clean and build
build: clean
    go build -o ./bin/migration -ldflags="-s -w" .

# update go module
update:
    go get -u
    go mod tidy -v

# create new sql migration
create-sql MigrateName:
    goose -dir migrations/sqls create {{MigrateName}} sql

# create new golang migration
create-gomigrate MigrateName:
    goose -dir migrations/golang create {{MigrateName}} go

# run up migrations
up: build
    ./bin/migration --driver pgx --database "postgres://pgdbadmin:12345678@127.0.0.1:9623/postgresdb?sslmode=disable" --path "migrations/sqls" up

#build docker image
image tag:
    docker buildx build --build-arg GITHUB_TOKEN="$GITHUB_TOKEN" --tag {{tag}} .