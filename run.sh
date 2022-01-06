#!/bin/bash
which jupyter
jupyter notebook /opt/workspace --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
