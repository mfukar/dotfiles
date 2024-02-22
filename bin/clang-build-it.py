#!/usr/bin/env python3
import sys, json, subprocess
def main():
    with open('compile_commands.json') as fh:
        blob = json.loads(fh.read())
    command = [item['arguments'] for item in blob if sys.argv[1] in item['file']]
    subprocess.run(sum(command,[]))

if __name__ == '__main__':
    main()
