#!/usr/bin/env python
# vim:fileencoding=utf-8
from sys import argv
from random import randint

def main(quotes_path):
    lines = str()
    with open(quotes_path, "r") as csvfile:
        lines = csvfile.readlines()
    last = len(lines) - 1
    if last < 0:
        print("Failed to read quotes from file")
        return -1
    index = randint(0, last)
    line = lines[index]
    abbreviation, description = line.split(";")
    print("BMW Abbreviation of the day:\n {} - {}".format(abbreviation, description))

if __name__ == "__main__":
    exit(main(argv[1]))
