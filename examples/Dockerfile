FROM golang:alpine AS build

RUN mkdir -p /build
WORKDIR /build

COPY main.go /build
RUN go build -o main .

FROM alpine:latest

RUN adduser -S -D -H -h /app appuser
USER appuser

COPY --from=build /build/main /app/
WORKDIR /app

CMD ["./main"]
