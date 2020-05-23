# python project generator

genpy() {

    read "NAME_PROJECT?name project: "
    read "DESCRIPTION?description: " 
    read "VERSION?version: "
    read "AUTHOR?author: "

    SETUP_FILE="""
#!/usr/bin/env python3

from setuptools import setup, find_packages
import os

try:
    long_description = open('README.md', 'r').read()
except Exception as e:
    long_description = '$DESCRIPTION'


def read_requirements():
    requirements_path = os.path.join('.', 'requirements.txt')
    with open(requirements_path, 'r') as f:
        requirements = [line.strip() for line in f]
    
    return requirements


setup(
    name='$NAME_PROJECT',
    version='$VERSION',
    description='$DESCRIPTION',
    long_description=long_description,
    author='$AUTHOR',
    packages=find_packages(),
    script=['bin/$NAME_PROJECT'],
    install_requires=read_requirements(),
    classifiers=['Programming Language :: Python', 'Environment :: Console',],
)
"""

    README_FILE="""
# $NAME_PROJECT
$DESCRIPTION

## Install

### Prerequisites
+ one
+ two
+ three

\`\`\`
commands
\`\`\`

## Usage
\`\`\`
help program
\`\`\`

## Example
\`\`\`
examples
\`\`\`

"""

    if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
        echo """genpy $VERSION
    Usage:
        genpy

    Options:
        -h --help       Show this screen.
        """
        return 0
    fi
    
    if [[ -d $NAME_PROJECT ]]; then
        echo "[!] project '$NAME_PROJECT' already exists"
        return 1
    fi


    echo "generate new project: $NAME_PROJECT"
    mkdir -p $NAME_PROJECT; cd $NAME_PROJECT
    
    echo "\033[32m[+] generate README.md\033[0m"
    echo $README_FILE > README.md

    echo "\033[32m[+] generate setup.py\033[0m"
    echo $SETUP_FILE > setup.py

    echo "\033[32m[+] generate requirements.txt\033[0m"
    touch requirements.txt

    echo "\033[32m[+] generate bin/$NAME_PROJECT\033[0m"
    mkdir -p bin
    touch bin/$NAME_PROJECT; chmod +x bin/$NAME_PROJECT

    echo "the project has been created!"
    echo "project: $(pwd)"

}
