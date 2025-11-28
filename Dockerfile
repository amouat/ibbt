# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:5e975512438c9de0779d6af9fa05ddb5d2951e95d6e5062efb2ab464153f4e47 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:c9635595e59e9f4a48da16842ce8dd8984298af3140dcbe5ed2ea4a02156db9c
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
