#!/bin/bash
set -eux -o pipefail

GOBIN="${HOME}/bin" go install ./cmd/ramdisk
