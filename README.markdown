# Terra-Luvit - Node.JS for the Lua Terra Inventor

Terra-Luvit is a Fork of [Luvit](https://www.github.com/luvit/luvit) that bundles [Terra](https://www.github.com/terralang/terra) directly in it.

## Binary Modules

Terra-Luvit supports FFI and Lua and Terra based binary modules.

## Hacking on Luvit Core

First you need to clone and build luvit, this is easy and works cross-platform thanks to `Makefile` and `make.bat`.

```sh
git clone https://github.com/shiranuit/terra-luvit.git
cd terra-luvit
make
```

If you want to test terra-luvit without constantly building, use `luvi`.

```sh
luvi .
```

Always make sure to run `make test` before submitting a PR.

## Notes to Maintainers

 - Use `luvi /path/to/terra-luvit` to test changes without rebuilding the binary.
 - To run the test suite, run `make test` to build a luvit and use that.
 - If you want to test a custom built luvi, run `luvi . -- tests/run.lua`
 - If you want to run a specific test file with a custom built luvi, run `luvi . -- tests/test-<name-of-test>.lua` (e.g. `luvi . -- tests/test-http.lua`)

[lit]: https://github.com/luvit/lit/
[luvi]: https://github.com/luvit/luvi/
[luvit]: https://github.com/luvit/luvit/
