#!/bin/bash

echo "Staring ssh service"
service ssh restart
exec "$@"