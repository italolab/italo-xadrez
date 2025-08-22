# Italo Xadrez

Agora é possível rodar o aplicativo sem necessidade de instalação. Basta fazer o 
download e descompactar ou clonar o projeto e entrar na pasta build e executar o 
seguinte comando:

```
./italo-xadrez
```

Todas as dependências estão inclusas como bibliotecas dinâmicas.

## Como compilar e executar build?

Para compilar, linkar e copiar as dependências para uma pasta "libs", é necessário 
instalar o SDL2, versão de desenvolvimento, no seu sistema operacional. Se estiver 
no ubuntu, pode executar os seguintes comandos:

```
sudo apt -y install libsdl2-dev
sudo apt -y install libsdl2-mixer-dev
sudo apt -y install libsdl2-image-dev
sudo apt -y install libsdl2-ttf-dev
```

Feito isto, com o SDL2, o SDL2 mixer, o SDL2 image e o SDL2-ttf instalados, basta 
executar o seguinte script na raiz do projeto:

```
./buildapp.sh
```

Esse script utiliza um programa que criei: o "cbuild", que pode ser utilizado 
para build automático de aplicações C/C++.

Agora, o software está na basta "build/italo-xadrez-x.x", onde o x.x é a versão do projeto. Para executar o programa, basta entrar nessa pasta e executar como a seguir:

```
cd build/italo-xadrez-2.2
./italo-xadrez
```

Esse exemplo é para o caso da versão ser a "2.2"!