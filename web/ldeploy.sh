# local deploy script for the web front-end

# This file is responsible for preprocessing all TypeScript files, making
# sure all dependencies are up-to-date, copying all necessary files into a
# local deploy directory, and starting a web server

# This is the resource folder where maven expects to find our files
TARGETFOLDER=./local

# step 1: make sure we have someplace to put everything.  We will delete the
#         old folder, and then make it from scratch
rm -rf $TARGETFOLDER
mkdir $TARGETFOLDER

# step 2: update our npm dependencies
npm update

# step 3: copy static html, css, and JavaScript files
cp index_simple.html $TARGETFOLDER/index.html
cp todo.js todo.css $TARGETFOLDER
cp -r src $TARGETFOLDER/src
cp app.css $TARGETFOLDER

# step 4: compile TypeScript files
# node_modules/typescript/bin/tsc app.ts --strict --outFile $TARGETFOLDER/app.js
node_modules/typescript/bin/tsc app.ts --lib "es2015","dom" --target es5 --strict --outFile $TARGETFOLDER/app.js

# step final: launch the server.  Be sure to disable caching
# (Note: we don't currently use -s for silent operation)
node_modules/.bin/http-server $TARGETFOLDER -c-1

# This next line stops the script (no further lines executed)
exit 0

# step future: compile front-end tests and copy tests to the local deploy folder
node_modules/typescript/bin/tsc apptest.ts --strict --outFile $TARGETFOLDER/apptest.js
cp spec_runner.html $TARGETFOLDER
cp node_modules/jasmine-core/lib/jasmine-core/jasmine.css $TARGETFOLDER
cp node_modules/jasmine-core/lib/jasmine-core/jasmine.js $TARGETFOLDER
cp node_modules/jasmine-core/lib/jasmine-core/boot0.js $TARGETFOLDER
cp node_modules/jasmine-core/lib/jasmine-core/boot1.js $TARGETFOLDER
cp node_modules/jasmine-core/lib/jasmine-core/jasmine-html.js $TARGETFOLDER