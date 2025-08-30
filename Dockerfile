# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:d2664e3ddedc9bbee969d6442225524ecccfd352f263082da55da219298c52da AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:6a4b683f4708f1f167ba218e31fcac0b7515d94c33c3acf223c36d5c6acd3783
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
