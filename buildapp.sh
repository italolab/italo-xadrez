#!/bin/bash

BUILD_FOLDER=build
APP_FOLDER=italo-xadrez-2.2
GLIBC_FOLDER=glibc-2.39

SCRIPT_APP_FILE_NAME=italo-xadrez

APP_DIR=$BUILD_FOLDER/$APP_FOLDER

LIBS_DIR=$APP_DIR/libs

APP_FILE=$APP_DIR/italo-xadrez-app
SCRIPT_APP_FILE=$APP_DIR/$SCRIPT_APP_FILE_NAME

rm -r $GLIBC_FOLDER
tar -xf "$GLIBC_FOLDER.tar.gz"
echo "Extraido: $GLIBC_FOLDER.tar.gz"


if [ -d "$APP_DIR" ]; then
    echo
    rm -rf $APP_DIR
    echo "Removido: $APP_DIR"
fi

mkdir -p $APP_DIR
mkdir -p $LIBS_DIR

echo

./cbuild buildall --settings-file=settings-linux.txt

ldd $APP_FILE | while read -r file; do
    IFS=' ' read -r -a array <<< "$file"
    
    if [ ${#array[@]} == 4 ]; then
        cp "${array[2]}" "$LIBS_DIR/${array[0]}"
    fi
done

cp $SCRIPT_APP_FILE_NAME $SCRIPT_APP_FILE
echo "Copiado: $SCRIPT_APP_FILE_NAME para pasta de build"

cp -r $GLIBC_FOLDER $APP_DIR/$GLIBC_FOLDER
echo "Copiado: $GLIBC_FOLDER para pasta de build"

if [ -f "$APP_DIR.tar.gz" ]; then
    echo ""
    rm "$APP_DIR.tar.gz"
    echo "Removido: $APP_DIR.tar.gz"
fi

cd $BUILD_FOLDER

echo ""
echo "Empacotando... $APP_DIR.tar.gz"

tar -czf "$APP_FOLDER.tar.gz" $APP_FOLDER
echo "Criado: $APP_DIR.tar.gz" 

cd ..

echo ""
echo "Build concluido!"
echo "Execute: $SCRIPT_APP_FILE"
