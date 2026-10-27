# Appendix G: module elaboration

This directory formalizes the source language of first-class modules in
Appendix G, “A Source Language and its Elaboration,” including functors,
declarations, sandboxing, and module merge. It elaborates into the explicit
calculus in `mech/fe_calculus/` and proves that elaboration preserves typing.

The four `.v` files were imported unchanged from
`FirstForall/Rocq/exists/source/` at commit
`dffd804b80b7ff865b505835f2b429136aeee0e4`. They originate in EnvML's
`POPL-27` branch, `mech/fe_calculus/source/`, at commit
`9c9263812478c8cbe8c08336fcc246b431b18cbf`, and remain byte-identical to it.
They use this repository's existing `Teq`, `ExpSyntax`, `Semantics`, and `Safety`
development through the `Top.source` namespace.

| Appendix G definition or result | Rocq file | Definition or theorem |
| --- | --- | --- |
| Module expressions and declarations | `Syntax.v` | `smod`, `sdecl` |
| Signature shape, label membership, uniqueness | `Syntax.v` | `sig_shape`, `has_lbl`, `unique_labels` |
| Elaboration and merge expansion | `Elaboration.v` | `elab`, `elabd`, `expands`, `numv` |
| Closed Types are Shift-Invariant | `Lemmas.v` | `closed_tshift_id` |
| Environment Growth | `Lemmas.v` | `get_var_grow` |
| Existence of Label Lookup | `Lemmas.v` | `rlk_exists` |
| Soundness of Expansion | `Lemmas.v` | `expands_sound` |
| Elaboration Preserves Typing | `Preservation.v` | `elab_elabd_preservation`, `elab_preservation`, `elabd_preservation` |

The mechanized `expands_sound` statement explicitly requires `lshape GIn`,
the shape condition on the initial output signature omitted from the appendix's
statement. The merge proof establishes this condition using
`lsh_nil` and `expands_lshape`.

From the repository root, with `coqc` and `coq_makefile` on `PATH`, build the
explicit calculus and this elaboration together:

```sh
make -C mech/fe_calculus -j4
```

To build only the elaboration and its dependencies:

```sh
make -C mech/fe_calculus Makefile.coq
make -C mech/fe_calculus -f Makefile.coq source/Preservation.vo
```

Verified with Rocq 9.1.0: the full build succeeds, and `Preservation.v` reports
both preservation theorems as `Closed under the global context` (no axioms).
`make -C mech/fe_calculus clean` removes generated artifacts from both the core
and `source/`.
