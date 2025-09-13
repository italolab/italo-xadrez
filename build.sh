#!/bin/bash

VERSION=2.2
SO=linux
ARCH=x64

PROJ_NAME=italo-xadrez

DEB_CONTROL_PACKAGE_NAME=$PROJ_NAME
DEB_CONTROL_INSTALLED_SIZE=192512
DEB_CONTROL_MAINTAINER="Italo Herbert Siqueira Gabriel (italoherbert@outlook.com)"
DEB_CONTROL_DESCRIPTION="Trata-se de um jogo de xadrez com inteligência artificial"

DEB_DESKTOP_APP_NAME="Italo Xadrez"

BUILD_FOLDER=build
APP_FOLDER=$PROJ_NAME-$VERSION-$SO-$ARCH
GLIBC_FOLDER=glibc-2.39

SCRIPT_APP_FILE_NAME=$PROJ_NAME

APP_DIR=$BUILD_FOLDER/$APP_FOLDER

LIBS_DIR=$APP_DIR/libs
DEB_APP_DIR=$APP_DIR-deb

APP_FILE=$APP_DIR/italo-xadrez-app
SCRIPT_APP_FILE=$APP_DIR/$SCRIPT_APP_FILE_NAME

DEB_SCRIPT_APP_FILE=/opt/$APP_FOLDER/$SCRIPT_APP_FILE_NAME
DEB_DESKTOP_FILE=$DEB_APP_DIR/usr/share/applications/italo-xadrez.desktop
DEB_CONTROL_FILE=$DEB_APP_DIR/DEBIAN/control

# LIMPANDO...

if [ -d "$GLIBC_FOLDER" ]; then
    rm -r $GLIBC_FOLDER
    echo "Removido: $GLIBC_FOLDER"
fi

tar -xf "$GLIBC_FOLDER.tar.gz"
echo "Extraido: $GLIBC_FOLDER.tar.gz"

if [ -d "$APP_DIR" ]; then
    rm -rf $APP_DIR
    echo "Removido: $APP_DIR"
fi

if [ -d "$DEB_APP_DIR" ]; then
    rm -rf $DEB_APP_DIR
    echo "Removido: $DEB_APP_DIR"
fi

if [ -f "$APP_DIR.tar.gz" ]; then
    rm "$APP_DIR.tar.gz"
    echo "Removido: $APP_DIR.tar.gz"
fi

if [ -f "$APP_DIR.deb" ]; then
    rm "$APP_DIR.deb"
    echo "Removido: $APP_DIR.deb"
fi

mkdir -p $APP_DIR
mkdir -p $LIBS_DIR
mkdir -p $DEB_APP_DIR

echo

# COMPILANDO...

./foxmake buildall --script=FoxMakefile

# COPIANDO BIBLIOTECAS DINAMICAS DE QUE O EXECUTAVEL DEPENDE

ldd $APP_FILE | while read -r file; do
    IFS=' ' read -r -a array <<< "$file"
    
    if [ ${#array[@]} == 4 ]; then
        cp "${array[2]}" "$LIBS_DIR/${array[0]}"
    fi
done


# COPIANDO O SCRIPT PRINCIPAL E A PASTA GLIBC PARA O DIRETORIO DA APLICAÇÃO EM BUILD

echo

cp $SCRIPT_APP_FILE_NAME $SCRIPT_APP_FILE
echo "Copiado: $SCRIPT_APP_FILE_NAME para pasta de build"

cp -r $GLIBC_FOLDER $APP_DIR/$GLIBC_FOLDER
echo "Copiado: $GLIBC_FOLDER para pasta de build"


# EMPACOTANDO EM .TAR.GZ

cd $BUILD_FOLDER

echo
echo "Empacotando... $APP_DIR.tar.gz"

tar -czf "$APP_FOLDER.tar.gz" $APP_FOLDER
echo "Finalizado." 

cd - &> /dev/null

echo


# COPIANDO A APLICACAO CONSTRUIDA PARA A PASTA DEB DE BUILD

mkdir -p $DEB_APP_DIR/opt

cp -r $APP_DIR "$DEB_APP_DIR/opt"
echo "Copiado: $APP_DIR para pasta $DEB_APP_DIR/opt"


# GERANDO LINK SIMBOLICO PARA SCRIPT PRINCIPAL DO .DEB

mkdir -p $DEB_APP_DIR/usr/bin

cd $DEB_APP_DIR/usr/bin
ln -s $DEB_SCRIPT_APP_FILE .
cd - &> /dev/null


# GERANDO DESKTOP FILE

mkdir -p $DEB_APP_DIR/usr/share/applications

echo "[Desktop Entry]" >> $DEB_DESKTOP_FILE
echo "Name=$DEB_DESKTOP_APP_NAME" >> $DEB_DESKTOP_FILE
echo "Version=$VERSION" >> $DEB_DESKTOP_FILE
echo "Exec=/opt/$APP_FOLDER/$SCRIPT_APP_FILE_NAME" >> $DEB_DESKTOP_FILE
echo "Icon=/opt/$APP_FOLDER/icon.ico" >> $DEB_DESKTOP_FILE
echo "Type=Application" >> $DEB_DESKTOP_FILE
echo "Terminal=false" >> $DEB_DESKTOP_FILE
echo "Keywords=Xadrez;Games;C++" >> $DEB_DESKTOP_FILE


# GERANDO O ARQUIVO CONTROL DO .DEB

mkdir -p $DEB_APP_DIR/DEBIAN

echo "Package: $DEB_CONTROL_PACKAGE_NAME" >> $DEB_CONTROL_FILE
echo "Version: $VERSION" >> $DEB_CONTROL_FILE
echo "Section: games" >> $DEB_CONTROL_FILE
echo "Architecture: amd64" >> $DEB_CONTROL_FILE
echo "Installed-Size: $DEB_CONTROL_INSTALLED_SIZE" >> $DEB_CONTROL_FILE
echo "Maintainer: $DEB_CONTROL_MAINTAINER" >> $DEB_CONTROL_FILE
echo "Description: $DEB_CONTROL_DESCRIPTION" >> $DEB_CONTROL_FILE

# EMPACOTANDO EM .DEB

echo
echo "Empacotando... $APP_DIR.deb"
dpkg-deb -b "$DEB_APP_DIR/" "$APP_DIR.deb"
echo "Finalizado."


# BUILD CONCLUIDO

echo
echo "Build concluido!"
echo "Execute: $SCRIPT_APP_FILE"
