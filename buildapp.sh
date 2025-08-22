#!/bin/bash

BUILD_FOLDER=build
APP_FOLDER=italo-xadrez-2.2-linux
GLIBC_FOLDER=glibc-2.39
GLIBC_APP_FOLDER=italo-xadrez-2.2-linux-glibc

SCRIPT_APP_FILE_NAME=italo-xadrez
GLIBC_SCRIPT_APP_FILE_NAME=italo-xadrez-glibc

APP_DIR=$BUILD_FOLDER/$APP_FOLDER
GLIBC_APP_DIR=$BUILD_FOLDER/$GLIBC_APP_FOLDER

LIBS_DIR=$APP_DIR/libs
GLIBC_DIR=$GLIBC_APP_DIR/$GLIBC_FOLDER

APP_FILE=$APP_DIR/italo-xadrez-app
SCRIPT_APP_FILE=$APP_DIR/$SCRIPT_APP_FILE_NAME
GLIBC_SCRIPT_APP_FILE=$GLIBC_APP_DIR/$SCRIPT_APP_FILE_NAME


./cbuild buildall

echo ""

if [ -d "$LIBS_DIR" ]; then
    rm -rf $LIBS_DIR
    echo "Removido: $LIBS_DIR"
fi

mkdir -p $LIBS_DIR
echo "Criado: $LIBS_DIR"

ldd $APP_FILE | while read -r file; do
    IFS=' ' read -r -a array <<< "$file"
    
    if [ ${#array[@]} == 4 ]; then
        cp "${array[2]}" "$LIBS_DIR/${array[0]}"
    fi
done

if [ -d "$GLIBC_APP_DIR" ]; then
    rm -rf $GLIBC_APP_DIR
    echo "Removido: $GLIBC_APP_DIR"
fi

mkdir $GLIBC_APP_DIR
echo "Criado: $GLIBC_APP_DIR"


cp -r $APP_DIR/* $GLIBC_APP_DIR

cp $SCRIPT_APP_FILE_NAME $SCRIPT_APP_FILE
cp $GLIBC_SCRIPT_APP_FILE_NAME $GLIBC_SCRIPT_APP_FILE

cp -r $GLIBC_FOLDER $GLIBC_APP_DIR/$GLIBC_FOLDER

echo ""

if [ -f "$APP_DIR.tar.gz" ]; then
    rm "$APP_DIR.tar.gz"
    echo "Removido: $APP_DIR.tar.gz"
fi

if [ -f "$GLIBC_APP_DIR.tar.gz" ]; then
    rm "$GLIBC_APP_DIR.tar.gz"
    echo "Removido: $GLIBC_APP_DIR.tar.gz" 
fi

cd $BUILD_FOLDER

echo ""
echo "Empacotando... $APP_DIR.tar.gz"

tar -czf "$APP_FOLDER.tar.gz" $APP_FOLDER
echo "Criado: $APP_DIR.tar.gz" 

echo "Empacotando... $GLIBC_APP_DIR.tar.gz"

tar -czf "$GLIBC_APP_FOLDER.tar.gz" $GLIBC_APP_FOLDER
echo "Criado: $GLIBC_APP_DIR.tar.gz"

cd ..

echo ""
echo "Build concluido!"
echo "Execute: $SCRIPT_APP_FILE"
