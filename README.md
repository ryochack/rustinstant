# rustinstant.sh
Run Rust code instantly on the shell.

## Usage
```sh
$ rustinstant 'println!("hello world!")'
# => hello world
```

or

```sh
$ cat << EOF | rustinstant
> println!("hello world!");
> EOF
# => hello world
```

