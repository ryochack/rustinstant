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
#
# Flag:
# -f : enable rustfmt

set -eu

do_rustfmt=0
arg=""

function fn_run_rust() {
	exec_code="fn main() { $* }"
	if [ $do_rustfmt -eq 1 ]; then
		echo $exec_code | rustfmt
	else
		echo $exec_code
	fi | rustc - && ./rust_out && rm rust_out
}

if [ $# -gt 0 ]; then
	if [ "$1" = "-f" ]; then
		do_rustfmt=1
		if [ $# -gt 1 ]; then
			arg="$2"
		fi
	else
		arg="$1"
	fi
fi

if [ -p /dev/stdin ]; then
	code=$(cat -)
elif [ $# -gt 0 ]; then
	code=$arg
else
	echo "rustinstant failed"
	exit 1
fi

fn_run_rust $code

