FROM golang:1.11

WORKDIR /go/src/github.com/Lusitaniae/apache_exporter
COPY ./ ./

RUN make

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /bin/
COPY --from=0 /go/src/github.com/Lusitaniae/apache_exporter/apache_exporter .
EXPOSE     9117
ENTRYPOINT ["/bin/apache_exporter"]
