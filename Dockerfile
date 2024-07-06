# syntax=docker/dockerfile:1

# Stage 1: Build the binary
FROM golang:1.22.5-alpine AS brudi_builder

# Set necessary environment variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0

# Set the Current Working Directory inside the container
WORKDIR /build

# Install git
RUN apk add --no-cache git

# Clone the repository
RUN git clone https://github.com/mittwald/brudi.git .

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Build the Go app for the current architecture
RUN go build -o brudi

# # Stage 2: Create the final image
# FROM alpine:latest

# # Set the Current Working Directory inside the container
# WORKDIR /app

# # Copy the pre-built binary from the builder stage
# COPY --from=builder /build/brudi .

# # Command to run the binary
# CMD ["./brudi"]


FROM        postgres:16.2-alpine3.19

LABEL       maintainer="s83 <https://github.com/s83>"

ENV         BRUDI_USER="brudi" \
            BRUDI_GID="1000" \
            BRUDI_UID="1000"
            
COPY        --from=brudi_builder /build/brudi /usr/local/bin/brudi
COPY        --from=restic/restic:0.16.4 /usr/bin/restic /usr/local/bin/restic
COPY        --from=redis:7.2.4-alpine3.19 /usr/local/bin/redis-cli /usr/local/bin/redis-cli

RUN         apk add --no-cache --upgrade \
                mysql-client \
                rclone \
                curl \
            && \
            addgroup \
                -S "${BRUDI_USER}" \
                -g "${BRUDI_GID}" \
            && \
            adduser \
                -u "${BRUDI_UID}" \
                -S \
                -G "${BRUDI_USER}" \
                "${BRUDI_USER}" \
            && mkdir -p /home/${BRUDI_USER}/.config/rclone \
            && touch /home/${BRUDI_USER}/.config/rclone/rclone.conf

USER        ${BRUDI_USER}
WORKDIR /home/${BRUDI_USER}

ENTRYPOINT  ["brudi"]

