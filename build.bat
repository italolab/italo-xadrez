set VERSION=2.2
set SO=linux
set ARCH=x64

set PROJ_NAME=italo-xadrez

set BUILD_FOLDER=build
set APP_FOLDER=%PROJ_NAME%-%VERSION%-%SO%-%ARCH%

set APP_DIR=%BUILD_FOLDER%/%$APP_FOLDER%


rem LIMPANDO ARQUIVOS E DIRETÓRIOS

if exist %APP_DIR% (
    del /s /q %APP_DIR%
    rmdir %APP_DIR%
    echo Removido: %APP_DIR%
)

if exist %APP_DIR%.zip (
    del /q %APP_DIR%.zip
    echo Removido: %APP_DIR%.zip
fi

mkdir %APP_DIR%

echo.

rem COMPILANDO...

.\foxmake.exe buildall --script=FoxMakefile

rem EMPACOTANDO EM .TAR.GZ

cd %BUILD_FOLDER%

echo.
echo Empacotando... %APP_DIR%.tar.gz

tar -a -cvf %APP_FOLDER%.zip %APP_FOLDER%
echo Finalizado.

cd ..

echo.

rem BUILD CONCLUIDO

echo.
echo Build concluido!

