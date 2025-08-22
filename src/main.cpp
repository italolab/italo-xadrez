#include "sistema.h"

#include <SDL2/SDL.h>
#include <thread>
#include <locale>

void execJogo( Sistema* sistema, void* id ) {
	sistema->execJogo( id );
}

int main(int argc, char** argv) {
	std::setlocale( LC_ALL, "pt_BR.UTF-8" );

	Sistema * sistema = new Sistema();
	std::thread thread( execJogo, sistema, (void*)"Thread 0" );
	
	sistema->execGUI();

	thread.join();

	return 0;
}
