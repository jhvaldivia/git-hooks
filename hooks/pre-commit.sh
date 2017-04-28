#!/bin/bash

# save the file as <git_directory>/.git/hooks/pre-commit.d/mvn_test and chmod +x

echo "Running mvn clean test for errors"

# retrieving current working directory
CWD=`pwd`
MAIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# echo "Main dir ${MAIN_DIR}"
# go to main project dir
cd $MAIN_DIR/../../
# running maven clean test
MVN_RESULT=$(mvn clean test 2>&1)
if [ $? -ne 0 ]; then
  echo
  echo "${MVN_RESULT}" | ((tee /dev/fd/5 | grep -A 10 -B 2 "Reactor Summary:" >/dev/fd/4) 5>&1 | sed -n -e '/^Failed tests:/,/Tests run:.*$/ p' ) 4>&1
  echo
  echo "Error while testing the code"
  # go back to current working dir
  cd $CWD
  exit 1
fi
# go back to current working dir
cd $CWD
