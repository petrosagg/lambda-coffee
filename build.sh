#!/bin/bash

coffee -jbc functional boolean arithmetic list meta stdlib test
mv ./-b.js lambda.js

node lambda.js
