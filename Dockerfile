FROM --platform=${BUILDPLATFORM} golang:1.17 as builder
WORKDIR $GOPATH/src/github.com/transferwise/oomie
COPY . $GOPATH/src/github.com/transferwise/oomie
ARG TARGETOS=linux
ARG TARGETARCH=amd64
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH make build

FROM debian:10-slim
COPY --from=builder /go/src/github.com/transferwise/oomie/bin/oomie /oomie
ENTRYPOINT ["/oomie"]
