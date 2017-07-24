COQPROJECT_EXISTS=$(wildcard _CoqProject)

ifeq "$(COQPROJECT_EXISTS)" ""
$(error "Run ./configure before running make")
endif

default: Makefile.coq
	$(MAKE) -f Makefile.coq

Makefile.coq: _CoqProject
	coq_makefile -f _CoqProject -o Makefile.coq -no-install \
          -extra-phony 'distclean' 'clean' \
	    'rm -f $$(join $$(dir $$(VFILES)),$$(addprefix .,$$(notdir $$(patsubst %.v,%.vo.aux,$$(VFILES)))))'

clean:
	if [ -f Makefile.coq ]; then \
	  $(MAKE) -f Makefile.coq distclean; fi
	rm -f Makefile.coq

distclean: clean
	rm -f _CoqProject

.PHONY: default clean distclean
