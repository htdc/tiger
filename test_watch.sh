#! /bin/bash

watchexec -c -p -e 'ex,exs,lock' -- mix test --stale
