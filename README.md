# Polymorphic First-Class Environments

This repository contains the EnvML implementation and Rocq mechanization for
**Polymorphic First-Class Environments**. The proofs cover the explicitly typed
calculus, its implicitly typed variant, and typing preservation for a source
language of first-class modules.

Try EnvML and Core FE in the [online playground](https://jam-khan.github.io/EnvML/).

## Implementation

[EnvML](impl/README.md) parses named source programs, elaborates them to Core FE,
converts names to de Bruijn indices, checks types, and evaluates programs.
The implementation, REPL, tests, and examples are in `impl/`.

You need Make, GHC, Cabal, Alex, and Happy. The implementation is tested with
GHC **9.6.7** and Cabal **3.12.1.0**. Alex and Happy can be installed with
`cabal install alex happy` and must be on `PATH`.

From the repository root:

```sh
make build
make test
cd impl
cabal run exe:EnvML
```

At the `envml>` prompt, check and evaluate a paper example:

```text
:check examples/section24_latest.eml
:eval examples/section24_latest.eml
:q
```

The result includes `previewResult = true` and `mockResult = false`.
Use `:help` for the REPL commands, including `:p`, `:e`, and `:n` to inspect
parsing, elaboration, and the de Bruijn core. See the
[implementation README](impl/README.md) for further examples and source details.

## Mechanization

The [Rocq development](mech/README.md) is organized as follows:

| Directory | Contents |
| --- | --- |
| [`mech/fe_calculus/`](mech/fe_calculus/) | Explicit calculus and its metatheory |
| [`mech/fe_implicit/`](mech/fe_implicit/) | Implicitly typed variant (Section 5) |
| [`mech/fe_calculus/source/`](mech/fe_calculus/source/README.md) | Module-language elaboration (Section 6.2 and Appendix F) |

The development targets **Rocq 9.1.1** and is also checked with **Rocq 9.1.0**.
`LibTactics.v` is included. Make sure `coqc` and `coq_makefile` are on `PATH`;
if you installed Rocq through OPAM, run `eval "$(opam env)"` first.

From the repository root, build both developments, including module elaboration:

```sh
make mech
```

The source-language result establishes typing preservation for the formal
nameless module language. See the [mechanization README](mech/README.md) for
proof structure and the [elaboration README](mech/fe_calculus/source/README.md)
for its definitions and assumptions.

## Paper and proof correspondence

### Explicit calculus

| Paper | File | Rocq declaration |
| --- | --- | --- |
| Theorem 3.1 | [Teq.v](mech/fe_calculus/Teq.v) | `teq_refl` |
| Theorem 3.2 | [Teq.v](mech/fe_calculus/Teq.v) | `teq_sym` |
| Theorem 3.3 | [Teq.v](mech/fe_calculus/Teq.v) | `teq_trans` |
| Theorem 3.4 | [Erased.v](mech/fe_calculus/Erased.v) | `sem_erase` |
| Lemma 4.1 | [Teq.v](mech/fe_calculus/Teq.v) | `inst_teq` |
| Lemma 4.2 | [Teq.v](mech/fe_calculus/Teq.v) | `inst_teq_gen` |
| Lemma 4.3 | [Teq.v](mech/fe_calculus/Teq.v) | `teq_spine_keyLen` |
| Lemma 4.4 | [Teq.v](mech/fe_calculus/Teq.v) | `dead_star_r` |
| Lemma 4.5 | [Safety.v](mech/fe_calculus/Safety.v) | `inst_typ` |
| Lemma 4.6 | [Safety.v](mech/fe_calculus/Safety.v) | `inst_typ_sp` |
| Lemma 4.7 | [Decide.v](mech/fe_calculus/Decide.v) | `teq_dec_size` |
| Corollary 4.8 | [Decide.v](mech/fe_calculus/Decide.v) | `teq_dec` |
| Lemma 4.9 | [Safety.v](mech/fe_calculus/Safety.v) | `clos_inv` |
| Lemma 4.10 | [Safety.v](mech/fe_calculus/Safety.v) | `bclos_inv` |
| Lemma 4.11 | [Safety.v](mech/fe_calculus/Safety.v) | `lookupv_prog` |
| Lemma 4.12 | [Safety.v](mech/fe_calculus/Safety.v) | `lookupv_pres` |
| Theorem 4.13 | [Safety.v](mech/fe_calculus/Safety.v) | `gprogress` |
| Theorem 4.14 | [Safety.v](mech/fe_calculus/Safety.v) | `gpreservation` |
| Lemma 4.15 | [Safety.v](mech/fe_calculus/Safety.v) | `value_boxing` |
| Lemma 4.16 | [Safety.v](mech/fe_calculus/Safety.v) | `vtyp_refl` |
| Theorem 4.17 | [Safety.v](mech/fe_calculus/Safety.v) | `progress` |
| Theorem 4.18 | [Safety.v](mech/fe_calculus/Safety.v) | `preservation` |
| Theorem 4.19 | [LogRel.v](mech/fe_calculus/LogRel.v) | `sem_sound` |
| Corollary 4.20 | [LogRel.v](mech/fe_calculus/LogRel.v) | `normalization` |
| Theorem 4.21 | [Conserve.v](mech/fe_calculus/Conserve.v) | `ccomplete` |
| Lemma 4.22 | [Conserve.v](mech/fe_calculus/Conserve.v) | `relate_gen` |
| Theorem 4.23 | [Conserve.v](mech/fe_calculus/Conserve.v) | `cconserve` |
| Lemma 4.24 | [Conserve.v](mech/fe_calculus/Conserve.v) | `cconserve_relaxed` |
| Lemma 4.25 | [Conserve.v](mech/fe_calculus/Conserve.v) | `teq_tt_eq` |
| Theorem 4.26 | [Conserve.v](mech/fe_calculus/Conserve.v) | `dyn_complete` |
| Theorem 4.27 | [Conserve.v](mech/fe_calculus/Conserve.v) | `cdyn_conserve` |
| Theorem E.1 | [LogRel.v](mech/fe_calculus/LogRel.v) | `sem_sound` |
| Lemma E.2 | [LogRel.v](mech/fe_calculus/LogRel.v) | `comp_eq` |
| Corollary E.3 | [LogRel.v](mech/fe_calculus/LogRel.v) | `normalization` |

### Implicitly typed variant

| Paper | File | Rocq declaration |
| --- | --- | --- |
| Theorem 5.1 | [LogRel.v](mech/fe_implicit/LogRel.v) | `sem_sound` |
| Corollary 5.2 | [LogRel.v](mech/fe_implicit/LogRel.v) | `normalization` |
| Theorem 5.3 | [Conserve.v](mech/fe_implicit/Conserve.v) | `complete` |
| Theorem 5.4 | [Conserve.v](mech/fe_implicit/Conserve.v) | `conserve_new` |
| Theorem 5.5 | [DynamicConservativity.v](mech/fe_implicit/DynamicConservativity.v) | `dyn_complete_imp` |
| Theorem 5.6 | [DynamicConservativity.v](mech/fe_implicit/DynamicConservativity.v) | `dyn_conserve_imp` |

### Source modules and elaboration

| Paper | File | Rocq declaration |
| --- | --- | --- |
| Source syntax | [Syntax.v](mech/fe_calculus/source/Syntax.v) | `smod`, `sdecl`, `sig_shape`, `unique_labels` |
| Elaboration and expansion rules | [Elaboration.v](mech/fe_calculus/source/Elaboration.v) | `elab`, `elabd`, `expands` |
| Closed Types are Shift-Invariant | [Lemmas.v](mech/fe_calculus/source/Lemmas.v) | `closed_tshift_id` |
| Environment Growth | [Lemmas.v](mech/fe_calculus/source/Lemmas.v) | `get_var_grow` |
| Existence of Label Lookup | [Lemmas.v](mech/fe_calculus/source/Lemmas.v) | `rlk_exists` |
| Soundness of Expansion | [Lemmas.v](mech/fe_calculus/source/Lemmas.v) | `expands_sound` |
| Elaboration Preserves Typing | [Preservation.v](mech/fe_calculus/source/Preservation.v) | `elab_elabd_preservation`, `elab_preservation`, `elabd_preservation` |

## Verification

Run `make check` from the repository root to test the implementation and build
both Rocq developments. All **343 implementation tests** pass, including every
supplied EnvML example and the expected results of the paper examples. Both
module-elaboration preservation theorems are closed under the global context
(no axioms). `make clean` removes generated implementation and proof files.
