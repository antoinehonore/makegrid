import argparse
import os 

parser = argparse.ArgumentParser()

parser.add_argument("-i", help="Input .json configuration file.", type=str)
parser.add_argument("-v", help="Verbosity level", default=0, type=int)
parser.add_argument("-j", help="Number of tasks", default=1, type=int)

args = parser.parse_args()

if args.v:
    print("Process: ", os.getpid())
    print("Input arguments:", args)
    print("--------\n")
