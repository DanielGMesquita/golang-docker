# Stage 1: Build the Go application
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -o fullcycle main.go

# Stage 2: Create a minimal image with the Go application
FROM scratch

WORKDIR /root/
COPY --from=builder /app/fullcycle .

EXPOSE 8080

CMD ["./fullcycle"]