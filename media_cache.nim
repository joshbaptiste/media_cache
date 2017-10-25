import os
import parseopt

# Media cache client

proc writeHelp(): void = 
    echo("media_cache --config=/path/to/config.json")
    quit("No parameters passed.. exiting")

proc parseConfigFile(file: string): void =
    discard

if  paramCount() == 0:
    writeHelp()
else:
    var cmd = initOptParser()
    for kind, key, val in cmd.getopt():
        if kind == cmdLongOption:
            if key == "config":
                parseConfigFile(val)
                

