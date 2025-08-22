#include "jogo_audio.h"
#include "../consts.h"

#include <SDL2/SDL_mixer.h>

#include <iostream>

void JogoAudio::inicializa() {
	bool fontResult = Mix_SetSoundFonts( sounds::FONT.c_str() );
	if ( !fontResult )
		std::cerr << "Erro na inicializacao da fonte de audio.\n" << Mix_GetError() << std::endl;				

	numAudio = AUDIO_NENHUM;		
	
	audioAberturaFundo = Mix_LoadMUS( sounds::ABERTURA_FUNDO.c_str() );
	audioJogoFundo = Mix_LoadMUS( sounds::JOGO_FUNDO.c_str() );

	audioJogadorMoveu = Mix_LoadWAV( sounds::JOGADOR_MOVEU.c_str() );
	audioCompMoveu = Mix_LoadWAV( sounds::COMP_MOVEU.c_str());
	audioCaptura = Mix_LoadWAV( sounds::CAPTURA.c_str() );
					
	audioXeque = Mix_LoadWAV( sounds::XEQUE.c_str() );

	audioPerdeu = Mix_LoadWAV( sounds::PERDEU.c_str() );	
	audioVenceu = Mix_LoadWAV( sounds::VENCEU.c_str() );
	audioEmpatou = Mix_LoadWAV( sounds::EMPATOU.c_str() );
	
	audioJogadaInvalida = Mix_LoadWAV( sounds::BEEP.c_str() );
	
	this->reinicia();
}

void JogoAudio::finaliza() {	
	Mix_FreeMusic( audioAberturaFundo );
	Mix_FreeMusic( audioJogoFundo );
	
	Mix_FreeChunk( audioJogadorMoveu );
	Mix_FreeChunk( audioCompMoveu );
	Mix_FreeChunk( audioCaptura );
		
	Mix_FreeChunk( audioXeque );
	
	Mix_FreeChunk( audioPerdeu );
	Mix_FreeChunk( audioVenceu );
	Mix_FreeChunk( audioEmpatou );
	
	Mix_FreeChunk( audioJogadaInvalida );
}

void JogoAudio::reinicia() {
	if ( Mix_PlayingMusic() ) 
		Mix_HaltMusic();
		
	audioFundo = audioAberturaFundo;
	Mix_PlayMusic( audioFundo, -1 );	
}

void JogoAudio::pauseMusica() {
	Mix_PauseMusic();
}

void JogoAudio::resumeMusica() {
	Mix_ResumeMusic();
}

void JogoAudio::setMusica( int musica ) {
	switch( musica ) {
		case AUDIO_FUNDO_ABERTURA:
			if ( Mix_PlayingMusic() )
				Mix_HaltMusic();				
			audioFundo = audioAberturaFundo;
			Mix_PlayMusic( audioFundo, -1 );				
			break;
		case AUDIO_FUNDO_JOGO:
			if ( Mix_PlayingMusic() )
				Mix_HaltMusic();				
			audioFundo = audioJogoFundo;
			Mix_PlayMusic( audioFundo, -1 );
			break;
	}	
}

void JogoAudio::tocaAudio() {
	Mix_Chunk* audio = NULL;
	switch( numAudio ) {
		case AUDIO_JOG_JOGOU:
			audio = audioJogadorMoveu;
			break;
		case AUDIO_COMP_JOGOU:
			audio = audioCompMoveu;
			break;
		case AUDIO_CAPTURA:
			audio = audioCaptura;
			break;
		case AUDIO_XEQUE:
			audio = audioXeque;
			break;
		case AUDIO_VENCEU:
			audio = audioVenceu;
			break;
		case AUDIO_PERDEU:
			audio = audioPerdeu;
			break;
		case AUDIO_EMPATOU:
			audio = audioEmpatou;
			break;
		case AUDIO_JOGADA_INVALIDA:
			audio = audioJogadaInvalida;
			break;
	}

	if ( audio != NULL )
		Mix_PlayChannel( -1, audio, 0 );
		
	numAudio = AUDIO_NENHUM;
}

int JogoAudio::getNumAudio() {
	return numAudio;
}

void JogoAudio::setNumAudio( int num ) {
	this->numAudio = num;
}
