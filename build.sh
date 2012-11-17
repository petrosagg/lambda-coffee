# vim: set noexpandtab:
#!/bin/bash

coffee -jbc functional boolean arithmetic list stream string meta stdlib test
mv ./-b.js lambda.js

node lambda.js
