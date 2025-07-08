# Build the binary
FROM golang:1.23 AS builder

WORKDIR /go/src/github.com/victorbecerragit/action-docker/authz-webhook
# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum

# Copy the go source
COPY main.go main.go

# Build the binary
# Use CGO_ENABLED=0 to ensure the binary is statically linked
# Use GOOS=linux to ensure the binary is compatible with the Alpine image
RUN CGO_ENABLED=0 GOOS=linux go build -o authz-webhook ./main.go

# Copy the binary to a thin image
FROM alpine:3.13.5
RUN apk add gcompat
WORKDIR /root
COPY --from=builder /go/src/github.com/victorbecerragit/action-docker/authz-webhook/authz-webhook /usr/local/bin/authz-webhook

