[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# makegrid
Run a grid of parameters in multiple processes.


## Requirements
make, python
```bash
$ apt-get install build-essential make
```

## Install
To create a new project based on makegrid, simply clone the repo:
```bash
$ git clone https://github.com/barketplace/makegrid 
```

To download the files in an existing project without tempering with existing `.git/`, you need npm:
```bash
$ npm init using barketplace/makegrid
```


## Example
The parameter grid is defined in a json file, e.g. `configs/example.json`.

1. Create all the possible combination of parameters in the grid:
```bash
$ make init indir=example

$ cat configs/example/1.json 
{
   "set_of_options1": {
      "option_a": 1,
      "option_b": "this"
   }
}
```

2. For a dry-run of the grid, use the `-n` option :

```bash
$ make indir=example script=main.py n_jobs=4 verbose=1 -n
python main.py -i configs/example/10.json -v 0 -j 1
python main.py -i configs/example/11.json -v 0 -j 1
python main.py -i configs/example/12.json -v 0 -j 1
python main.py -i configs/example/1.json -v 0 -j 1
python main.py -i configs/example/2.json -v 0 -j 1
python main.py -i configs/example/3.json -v 0 -j 1
python main.py -i configs/example/4.json -v 0 -j 1
python main.py -i configs/example/5.json -v 0 -j 1
python main.py -i configs/example/6.json -v 0 -j 1
python main.py -i configs/example/7.json -v 0 -j 1
python main.py -i configs/example/8.json -v 0 -j 1
python main.py -i configs/example/9.json -v 0 -j 1
```

3. For a real run of the parameter grid defined in configs/example, using 2 parallel processes, and with 4 tasks per process.

```bash
$ make indir=example n_jobs=4 -j 2
```

## Interpreter
You need a python interpreter at least to run the `make init` command, i.e. to compute the combination of options in a grid.

### On the host
The interpreter is specified in the `cfg.mk` file, e.g. :
```bash
PYTHON=python
```

### In a container
To use a python interpreter inside an apptainer (i.e. singularity) container file `env.sif`, you can use e.g.
```bash
PYTHON=apptainer exec --nv env.sif python3
```

The `--nv` flag maps the nvidia binaries in the container and makes GPU visible to python.

### Non-python code
The repo is still usable if your parameter grid configures scripts that are written in Python. To adapt for this, modify the recipe corresponding to the last target in the `Makefile`:
```bash
	$(PYTHON) $(script) -i $^ -v $(verbose) -j $(n_jobs)
```

The symbol `$^` refers to the first dependency (i.e. the numbered config file passed `$(cfg_dir)/$(indir)/%.json`) required to produce the target.
To manipulate the `Makefile` it's a good idea to learn about the generic principles, e.g. ![https://makefiletutorial.com/](https://makefiletutorial.com/)