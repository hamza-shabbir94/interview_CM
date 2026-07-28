# Stage 1: Build the application
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Install git and download/install http-echo
RUN apk add --no-cache git
RUN go install github.com/hashicorp/http-echo@latest

# Stage 2: Create a secure, minimal runtime image
FROM alpine:3.20

# Create a non-root user and group for security best practices
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy the compiled binary from the builder stage
COPY --from=builder /go/bin/http-echo /usr/local/bin/http-echo

# Switch to the non-root user
USER appuser

# Expose the default port
EXPOSE 5678

# Run the application with a default message
ENTRYPOINT ["http-echo"]
CMD ["-text", "Hello from Hamza to CardMarkt Interviewer!"]