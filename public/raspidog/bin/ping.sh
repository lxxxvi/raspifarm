#!/bin/bash

ping $1 -W 1 -c 1 | grep "1 received" | wc -l