#!/bin/bash

coffee -jbc boolean arithmetic list meta stdlib test
mv ./-b.js lambda.js
