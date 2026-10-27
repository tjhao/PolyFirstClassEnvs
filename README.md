# PolyFirstClassEnvs

Artifact for **Polymorphic First-Class Environments**.

- [`impl/`](impl/README.md): EnvML implementation, REPL, tests, and examples.
- [`mech/`](mech/README.md): Rocq proofs for the explicit calculus, implicit
  variant, and the source-module elaboration of Section 6.2 / Appendix G.

## Build and run

From the repository root:

```sh
make build                 # native implementation
make test                  # implementation test suite and all examples
make mech                  # both Rocq developments, including module elaboration
cd impl
cabal run exe:EnvML
```

`make check` runs the implementation tests and both proof builds. See the
linked READMEs for prerequisites and REPL examples.

## Sources

The implementation was imported from `EnvML` branch `POPL-27`, commit
`9c9263812478c8cbe8c08336fcc246b431b18cbf`. Generated files, caches, REPL
history, and prebuilt playground binaries are excluded.

The four module-elaboration proof files were imported from
`FirstForall/Rocq/exists/source/` at commit
`dffd804b80b7ff865b505835f2b429136aeee0e4`. They are unchanged from the EnvML
commit above and build against the explicit core already in this repository.

## Verification

Checked with GHC 9.6.7, Cabal 3.12.1.0, and Rocq 9.1.0. The implementation
suite passes all 343 tests, including every supplied EnvML example and the
expected results of the paper examples. Both Rocq developments build; the
module and declaration preservation theorems are closed under the global
context (no axioms).
