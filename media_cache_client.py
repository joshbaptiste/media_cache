#!/usr/bin/env python3
import sys
import configparser
import argparse
import redis

class Client():
    def __init__(self):
        self.config = configparser.SafeConfigParser()

    def connect_to_redis(self, host, port):
        try:
            host = self.redis_host
            port = self.redis_port
            r = redis.StrictRedis(host=host, port=port, db=0)
            fname, cfsize, sfsize = r.get('media_files')
        except redis.ConnectionError:
            print("Unable to connect to Redis")
            sys.exit(1)

    def file_scan():
        dirs = config.directories()
        

def arg_help():
    parser = argparse.ArgumentParser(description='Media Cache Client') 
    parser.add_argument('--config', help='Path/To/ConfigFile')



if __name__ == '__main__':
    arg_help()
