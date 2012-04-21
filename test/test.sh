#!/bin/bash
set -e

rm -rf  CordovaApp.dart.js
rm -rf  ../../../iPad/www/CordovaApp.dart.js
rm -rf  ../../../iPad/www/DartGap.js

frogc CordovaApp.dart
cp -a ../DartGap.js ../../../iPad/www
cp -a CordovaApp.dart.js ../../../iPad/www
