#!/bin/bash
echo "Hello, world" > index.html
echo "the database port is ${db_address}" >> index.html
echo "the database endpoint is ${db_port}" >> index.html
nohup busybox httpd -f -p 8080 & 