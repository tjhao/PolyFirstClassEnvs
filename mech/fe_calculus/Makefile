COQPROJECT := _CoqProject
COQMK      := Makefile.coq
COQDIRS   := . source

# ---- build ---------------------------------------------------------------
all: $(COQMK)
	@$(MAKE) --no-print-directory -f $(COQMK)

# (re)generate the coq build makefile whenever _CoqProject changes
$(COQMK): $(COQPROJECT)
	coq_makefile -f $(COQPROJECT) -o $(COQMK)

# ---- cleaning ------------------------------------------------------------
clean:
	rm -f $(foreach dir,$(COQDIRS),$(addprefix $(dir)/,*.vo *.vok *.vos *.glob))
	rm -f $(foreach dir,$(COQDIRS),$(addprefix $(dir)/,.*.aux *.aux))
	rm -f $(foreach dir,$(COQDIRS),$(addprefix $(dir)/,.*.d *.d))
	rm -f $(foreach dir,$(COQDIRS),$(addprefix $(dir)/,.lia.cache .nia.cache))
	rm -f $(COQMK) $(COQMK).conf .$(COQMK).d
	rm -f Makefile.coq.bak CoqMakefile CoqMakefile.conf
	rm -f Makefile.conf .Makefile.d
	rm -f *~

.PHONY: all clean
