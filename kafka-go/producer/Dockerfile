FROM golang:latest AS base
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY main.go ./

FROM base AS build
RUN go build -o /consumer

FROM build AS final
CMD ["/producer"]