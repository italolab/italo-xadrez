#include "sistema.h"

#include <SDL2/SDL.h>
#include <thread>
#include <locale>
#include <cstring>

#ifdef _WIN32
    const string PT_BR_LOCALE = "C";
#else
    const string PT_BR_LOCALE = "pt_BR.UTF-8";
#endif

void execJogo( Sistema* sistema, void* id ) {
	sistema->execJogo( id );
}

int main(int argc, char** argv) {
	char* defaultLocale = setlocale( LC_ALL, nullptr );
    
    std::setlocale( LC_ALL, PT_BR_LOCALE.c_str() );
	if ( strcmp( setlocale( LC_ALL, nullptr ), "C" ) == 0 )
		std::setlocale( LC_ALL, defaultLocale );

	Sistema * sistema = new Sistema();
	std::thread thread( execJogo, sistema, (void*)"Thread 0" );
	
	sistema->execGUI();

	thread.join();

	return 0;
}
