#!/bin/bash

# Start Shelley (global flags go before the command)
exec /usr/local/bin/shelley -db /data/shelley.db serve -port 9000
