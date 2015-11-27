#!/bin/bash

/bin/cat /proc/sys/fs/file-nr | awk '{print $1}'
