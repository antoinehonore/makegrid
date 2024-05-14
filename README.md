[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# makegrid
Run a grid of script parameters in parallel processes with a Makefile.

## Requirements
You need make and Python.
To understand the `Makefile` you can look at e.g. ![https://makefiletutorial.com/](https://makefiletutorial.com/).

### For Debian/Ubuntu:
```bash
apt-get install build-essential make
```

```bash
apt-get install python3
```

## Install
To create a new project based on makegrid, simply clone the repo:
```bash
git clone https://github.com/barketplace/makegrid 
```

To download the files in an existing project without tempering with existing `.git/`, you need `npm`:
```bash
npm init using barketplace/makegrid
```



## Example
The parameter grid is defined in a json file, e.g. `configs/example.json`.

Note 1: The field names must not contain the colon(`:`) character.

Note 2: Computing all the combinations of parameters is done in only 1 process. It takes a while to compute when the grid has more than `1000` combinations.

1. Create all the `12` possible combinations of parameters in the grid defined in `configs/example.json`:
```bash
make example-init
[OR]
make -f makefile.mk init indir=example
```

Look at the first combination:
```bash
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
$ make -f makefile.mk indir=example script=main.py n_jobs=4 verbose=1 -n
python main.py -i configs/example/10.json -v 1 -j 4
python main.py -i configs/example/11.json -v 1 -j 4
python main.py -i configs/example/12.json -v 1 -j 4
python main.py -i configs/example/1.json -v 1 -j 4
python main.py -i configs/example/2.json -v 1 -j 4
python main.py -i configs/example/3.json -v 1 -j 4
python main.py -i configs/example/4.json -v 1 -j 4
python main.py -i configs/example/5.json -v 1 -j 4
python main.py -i configs/example/6.json -v 1 -j 4
python main.py -i configs/example/7.json -v 1 -j 4
python main.py -i configs/example/8.json -v 1 -j 4
python main.py -i configs/example/9.json -v 1 -j 4
```
This lists all the `12` commands that will be executed.

By default, a Python interpreter and a `main.py` script taking at least arguments `-i` , `-v` and `-j` are expected.

Note: The name of the script can be edited in the `Makefile` or passed as an argument: `script=main.py`.

3. For a real run of all the configurations, using 2 parallel processes, and with 4 tasks per process:

```bash
make -f makefile.mk indir=example n_jobs=4 -j 2
```

## Interpreter
You need a Python interpreter in order to run the `make -f makefile.mk init indir=example` command, i.e. to compute the combination of options in a grid.
The interpreter is specified in the `cfg.mk` file.

### Python interpreter on the host
```bash
PYTHON=python
```

### In a container
To use a python interpreter inside an apptainer container file `env.sif`, you can use e.g.
```bash
PYTHON=apptainer exec --nv env.sif python3
```

The `--nv` flag is specific to singularity and maps the nvidia binaries inside the container. This makes GPUs available on the host, also available in the container.
To read more about apptainer: ![https://apptainer.org/docs/user/latest/](https://apptainer.org/docs/user/latest/)

### Non-python code
The repo is still usable if your parameter grid configures scripts that are not written in Python. 
To adapt for this, modify the recipe corresponding to the last target in the `Makefile`:
```bash
$(PYTHON) $(script) -i $^ -v $(verbose) -j $(n_jobs)
```

The symbol `$^` refers to all the dependencies (here `$(cfg_dir)/$(indir)/%.json`) required to produce the target (`$(res_dir)/$(indir)/%.pkl`).
In makegrid, the first (and only) dependency is a configuration file.

Note: Here the targets are never actually created and are just placeholders to trigger the execution of the recipies.

