#!/bin/bash
PWD=$(pwd)
SCRIPT_WORKDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASENAME_LOWER=$(basename $SCRIPT_WORKDIR | tr '[:upper:]' '[:lower:]')

DJANGO_IMAGE=django:1.11
DJANGO_PROJECT=webapp

DJANGO_CONTAINER=django_$DJANGO_PROJECT

build(){
    
    # echo ${DJANGO_IMAGE}"_$(date +%s)"
    docker build -t $DJANGO_IMAGE $SCRIPT_WORKDIR/docker
}

start_project(){
    
    if [ ! -d "$SCRIPT_WORKDIR/$DJANGO_PROJECT" ]; then
        docker run --rm \
        -v $SCRIPT_WORKDIR:/src/app \
        $DJANGO_IMAGE django-admin.py startproject $DJANGO_PROJECT
    fi
}

run(){
    
    start_project
    
    docker run -d \
    -v $SCRIPT_WORKDIR/$DJANGO_PROJECT:/src/app \
    -p 8000:8000 \
    $DJANGO_IMAGE
}

$1