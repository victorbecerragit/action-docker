# Build the binary
FROM golang:1.23 AS builder

WORKDIR /go/src/github.com/victorbecerragit/action-docker/authn-webhook
COPY go.mod go.mod
COPY go.sum go.sum
COPY main.go main.go
RUN go build -o authn-webhook ./main.go

# Copy the binary to a thin image
FROM alpine:3.13.5
RUN apk add gcompat
WORKDIR /root
COPY --from=builder /go/src/github.com/victorbecerragit/action-docker/authn-webhook/auth-webhook /usr/local/bin/authn-webhook

CMD ["/app/auth-webhook"]
