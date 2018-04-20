#!/usr/bin/env sh

# Usage:
#
# $ rustinstant 'println!("hello world!")'
# => hello world
#
# or
#
# $ cat << EOF | rustinstant
# > println!("hello world!");
# > EOF
# => hello world

set -eu

function fn_run_rust() {
	echo "fn main() { $* }" | rustc - && ./rust_out && rm rust_out
}

if [ -p /dev/stdin ]; then
	code=$(cat -)
elif [ $# -gt 0 ]; then
	code=$1
else
	echo "rustinstant failed"
	exit 1
fi

fn_run_rust $code

