FROM golang:1.20-alpine as builder
WORKDIR /app
COPY . .

RUN go env -w GOPROXY=https://goproxy.cn,https://goproxy.io,direct
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o keda-go-app

FROM alpine
WORKDIR /app/
COPY --from=builder /app/keda-go-app .
EXPOSE 80
CMD ["./keda-go-app"]
