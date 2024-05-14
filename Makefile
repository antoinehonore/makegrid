CARGS=

ifdef retrain
	CARGS=--retrain
endif

ifndef verbose
	verbose=0
endif

ifndef n_jobs
	n_jobs=1
endif

ifndef script
	script=main.py
endif

MK_ARGS = verbose=$(verbose) n_jobs=$(n_jobs) script=$(script)

%:
	make -f makefile.mk indir=$* $(MK_ARGS) CARGS=$(CARGS)
%-init:
	make -f makefile.mk indir=$* $(MK_ARGS) CARGS=$(CARGS) init

