# Use the official PostgreSQL image as the base image
FROM postgres:latest

ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB

# Copy SQL scripts to the container
COPY ./init.sql /docker-entrypoint-initdb.d/

