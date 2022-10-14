# deploy script for the web front-end

# This file is responsible for preprocessing all TypeScript files, making sure
# all dependencies are up-to-date, and copying all necessary files into the
# web deploy directory.

# This is the resource folder where maven expects to find our files
TARGETFOLDER=../backend/src/main/resources

# This is the folder that we used with the Spark.staticFileLocation command
WEBFOLDERNAME=web

# step 1: make sure we have someplace to put everything.  We will delete the
#         old folder tree, and then make it from scratch
rm -rf $TARGETFOLDER
mkdir $TARGETFOLDER
mkdir $TARGETFOLDER/$WEBFOLDERNAME

# there are many more steps to be done.  For now, we will just copy an HTML file
cp index_simple.html $TARGETFOLDER/$WEBFOLDERNAME/index.html

# step 2: update our npm dependencies
npm update

# step 3: copy javascript and other files from src folder
cp todo.js $TARGETFOLDER/$WEBFOLDERNAME
cp -r src $TARGETFOLDER/$WEBFOLDERNAME/src

# step 4: copy css files
cp todo.css $TARGETFOLDER/$WEBFOLDERNAME

# step 5: compile TypeScript files
node_modules/typescript/bin/tsc app.ts --lib "es2015","dom" --target es5 --strict --outFile $TARGETFOLDER/$WEBFOLDERNAME/app.js

# step 6: copy css files
cp app.css $TARGETFOLDER/$WEBFOLDERNAME

# step 7: set up Jasmine
node_modules/typescript/bin/tsc apptest.ts --strict --outFile $TARGETFOLDER/$WEBFOLDERNAME/apptest.js
cp spec_runner.html $TARGETFOLDER/$WEBFOLDERNAME
cp node_modules/jasmine-core/lib/jasmine-core/*.css $TARGETFOLDER/$WEBFOLDERNAME
cp node_modules/jasmine-core/lib/jasmine-core/*.js $TARGETFOLDER/$WEBFOLDERNAME