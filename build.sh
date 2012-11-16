#!/bin/bash

coffee -jbc functional boolean arithmetic list stream meta stdlib test
mv ./-b.js lambda.js

node lambda.js
