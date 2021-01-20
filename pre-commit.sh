#!/bin/sh

#  -----   Start Check prospector   ------
set -u

cd app

prospector_test=$(prospector --profile-path prospector.yaml)

if [ "$prospector_test" != "" ]
then
	printf "Code Style - Fail\n\n"
	printf "$prospector_test\n"
	exit 1
else
	printf "Code Style - OK\n\n"
fi
#  -----   End Check prospector   ------



#  -----   Start Check Prohibited Words   ------
cd ..

# Modify this
# WORD_LIST='list\|of\|words\|splitted\|by\|slash\|and\|pipe'
# WORD_LIST="puts\|debugger\|binding.pry\|alert(\|console.log("
WORD_LIST="pydevd_pycharm"
FILE_TO_EXCLUDE="pre-commit.sh"

if git rev-parse --verify HEAD >/dev/null 2>&1; then
    against=HEAD
else
    against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

for FILE in `git diff-index --name-status --cached $against -- | cut -c3-` ; do
    echo $FILE
    if [ $FILE != $FILE_TO_EXCLUDE ]
    then
        # Check if the file contains one of the words in WORD_LIST
        word=$(grep -w $WORD_LIST $FILE)
        if [ "$word" != "" ]
        then
            printf "Prohibited Words - Fail\n"
            printf $FILE" --> Has one of the words you don't want to commit. Please remove it\n"
            printf "$word\n"
            exit 1
        fi
    fi
done
printf "Prohibited Words - OK\n"
#  -----   End Check Prohibited Words   ------

exit