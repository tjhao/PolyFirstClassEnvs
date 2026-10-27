# EnvML implementation

EnvML is the named source language for the explicitly typed first-class
environment calculus. The native implementation parses EnvML programs,
elaborates them to Core FE, converts names to de Bruijn indices, checks types,
and evaluates programs.

The implementation, tests, and examples come from the `POPL-27` branch of
[EnvML](https://github.com/jam-khan/EnvML), commit
`9c9263812478c8cbe8c08336fcc246b431b18cbf`.

## Build and test

Run these commands from `impl/`. You need GHC, Cabal, Make, Alex, and Happy.
This import is tested with GHC 9.6.7 and Cabal 3.12.1.0. The package declares
`base >= 4.17`; other compiler versions have not been checked here.

```sh
make build
make test
```

`make build` generates the two lexers and parsers before building the library
and executable. Cabal resolves the Haskell dependencies. Alex and Happy must
be on `PATH`; they can be installed with `cabal install alex happy`.

## Run

```sh
cabal run exe:EnvML
```

For example, at the `envml>` prompt:

```text
:check examples/section24_latest.eml
:eval examples/section24_latest.eml
:q
```

The paper examples evaluate to a module containing `previewResult = true` and
`mockResult = false`. `examples/typedep.eml` exercises dependencies between
module components, and `examples/test15.eml` exercises module composition.

The REPL also provides `:p`, `:e`, and `:n` to inspect parsing, elaboration,
and the de Bruijn core. Use `:help` for the full command list.

## Tests and source

`test/` includes core, de Bruijn conversion, and elaboration tests. Its
end-to-end checks discover every `examples/*.eml` file and run parsing,
elaboration, type checking, and evaluation. To see individual test results:

```sh
cabal test --test-show-details=direct
```

`src/EnvML/` implements the source language; `src/CoreFE/` implements the core
calculus. The related Rocq module-language proofs are in
[`../mech/fe_calculus/source/`](../mech/fe_calculus/source/README.md).
They establish typing preservation for the formal nameless source language.
The Haskell implementation has additional conveniences, including booleans,
lists and named syntax.

`src/WASM.hs` and `docs/index.html` are retained as browser frontend sources.
This import does not include generated WebAssembly binaries; playground
building and hosting are a separate follow-up.

`make clean` removes generated parsers and native build outputs.
