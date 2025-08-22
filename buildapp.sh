#!/bin/bash

BUILD_FOLDER=build
APP_FOLDER=italo-xadrez-2.2-x64
GLIBC_FOLDER=glibc-2.39
DEB_FOLDER=deb

SCRIPT_APP_FILE_NAME=italo-xadrez

APP_DIR=$BUILD_FOLDER/$APP_FOLDER

LIBS_DIR=$APP_DIR/libs
DEB_APP_DIR=$APP_DIR-deb

APP_FILE=$APP_DIR/italo-xadrez-app
SCRIPT_APP_FILE=$APP_DIR/$SCRIPT_APP_FILE_NAME

if [ -d "$GLIBC_FOLDER" ]; then
    rm -r $GLIBC_FOLDER
fi

tar -xf "$GLIBC_FOLDER.tar.gz"
echo "Extraido: $GLIBC_FOLDER.tar.gz"

if [ -d "$APP_DIR" ]; then
    echo
    rm -rf $APP_DIR
    echo "Removido: $APP_DIR"
fi

if [ -d "$DEB_APP_DIR" ]; then
    echo
    rm -rf $DEB_APP_DIR
    echo "Removido: $DEB_APP_DIR"
fi

if [ -f "$APP_DIR.tar.gz" ]; then
    echo
    rm "$APP_DIR.tar.gz"
    echo "Removido: $APP_DIR.tar.gz"
fi

if [ -f "$APP_DIR.deb" ]; then
    echo
    rm "$APP_DIR.deb"
    echo "Removido: $APP_DIR.deb"
fi

mkdir -p $APP_DIR
mkdir -p $LIBS_DIR
mkdir -p $DEB_APP_DIR

echo

./cbuild buildall --settings-file=settings-linux.txt

ldd $APP_FILE | while read -r file; do
    IFS=' ' read -r -a array <<< "$file"
    
    if [ ${#array[@]} == 4 ]; then
        cp "${array[2]}" "$LIBS_DIR/${array[0]}"
    fi
done

echo

cp $SCRIPT_APP_FILE_NAME $SCRIPT_APP_FILE
echo "Copiado: $SCRIPT_APP_FILE_NAME para pasta de build"

cp -r $GLIBC_FOLDER $APP_DIR/$GLIBC_FOLDER
echo "Copiado: $GLIBC_FOLDER para pasta de build"

cd $BUILD_FOLDER

echo
echo "Empacotando... $APP_DIR.tar.gz"

tar -czf "$APP_FOLDER.tar.gz" $APP_FOLDER
echo "Finalizado." 

cd ..

echo
cp -r $DEB_FOLDER/* $DEB_APP_DIR/
cp -r $APP_DIR "$DEB_APP_DIR/opt"
echo "Copiado: $DEB_FOLDER/* para pasta $DEB_APP_DIR"
echo "Copiado: $APP_DIR para pasta $DEB_APP_DIR/opt"

echo
echo "Empacotando... $APP_DIR.deb"
dpkg-deb -b "$DEB_APP_DIR/" "$APP_DIR.deb"
echo "Finalizado."

echo
echo "Build concluido!"
echo "Execute: $SCRIPT_APP_FILE"
