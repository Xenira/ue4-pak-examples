#!/bin/bash

rm -rf pak

wget -i build/download/file-urls-v11 -P pak/v11
wget -i build/download/file-urls-v9 -P pak/v9
wget -i build/download/file-urls-v8 -P pak/v8
wget -i build/download/file-urls-v7 -P pak/v7
wget -i build/download/file-urls-v5 -P pak/v5
wget -i build/download/file-urls-v4 -P pak/v4
wget -i build/download/file-urls-v3 -P pak/v3
wget -i build/download/file-urls-v2 -P pak/v2