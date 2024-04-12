# makegrid
Run a grid of parameters in multiple processes.


## Requirements
make, python
```bash
apt-get install build-essential make
```

## Example
The parameter grid is defined in a json file, e.g. `configs/example.json`.

Create all the possible combination of parameters in the grid:
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

For a dry-run of the grid:

```bash
$ make indir=example script=main.py -n
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

Real run of the parameter grid defined in configs/example in two independent processes, with 4 tasks per processes.

```bash
$ make indir=example n_jobs=4 -j 2
```

## Interpreter
You need a python interpreter to run the `make init` command, i.e. to compute the combination of options in a grid.

