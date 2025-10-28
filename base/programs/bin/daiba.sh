#!/bin/bash
server=${1:-17}
ssh -A -J daiba yasser@192.168.101.$server
