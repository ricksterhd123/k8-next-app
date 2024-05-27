#! /usr/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rm -rf $SCRIPT_DIR/../node_modules
rm -rf $SCRIPT_DIR/../.next
rm -rf $SCRIPT_DIR/../out
