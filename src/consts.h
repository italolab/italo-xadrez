
#ifndef CONSTS_H
#define CONSTS_H

#include <string>
using std::string;

namespace consts {

	constexpr double FATOR_CELULA_DIM = 0.1;
	constexpr int ANIM_RAIO_INC = 10;

	constexpr int JANELA_LARGURA = 640;
	constexpr int JANELA_ALTURA = 640;

};

namespace sounds {

	const string FONT = "assets/sounds/fonts/default-GM.sf3";
		
	const string ABERTURA_FUNDO = "assets/sounds/abertura-fundo.mid";
	const string JOGO_FUNDO = "assets/sounds/jogo-fundo.mid";

	const string JOGADOR_MOVEU = "assets/sounds/jogador-moveu.wav";
	const string COMP_MOVEU = "assets/sounds/comp-moveu.wav";
	const string CAPTURA = "assets/sounds/captura.wav";
					
	const string XEQUE = "assets/sounds/xeque.wav";

	const string PERDEU = "assets/sounds/perdeu.wav";	
	const string VENCEU = "assets/sounds/venceu.wav";
	const string EMPATOU = "assets/sounds/empatou.wav";
	
	const string BEEP = "assets/sounds/beep.wav";

}

namespace images {
	
	const string ABERTURA = "assets/images/abertura.png";
	
	const string AUDIO_LIGADO = "assets/images/audio-ligado.png";
	const string AUDIO_DESLIGADO = "assets/images/audio-desligado.png";
	
	const string PEAO_PRETO = "assets/images/peao-preto.png";			
	const string PEAO_BRANCO = "assets/images/peao-branco.png";			
	const string PEAO_VERMELHO = "assets/images/peao-vermelho.png";
				
	const string TORRE_PRETA = "assets/images/torre-preta.png";			
	const string TORRE_BRANCA = "assets/images/torre-branca.png";			
	const string TORRE_VERMELHA = "assets/images/torre-vermelha.png";			
	
	const string CAVALO_PRETO = "assets/images/cavalo-preto.png";			
	const string CAVALO_BRANCO = "assets/images/cavalo-branco.png";			
	const string CAVALO_VERMELHO = "assets/images/cavalo-vermelho.png";			
	
	const string BISPO_PRETO = "assets/images/bispo-preto.png";			
	const string BISPO_BRANCO = "assets/images/bispo-branco.png";			
	const string BISPO_VERMELHO = "assets/images/bispo-vermelho.png";
				
	const string RAINHA_PRETA = "assets/images/rainha-preta.png";			
	const string RAINHA_BRANCA = "assets/images/rainha-branca.png";			
	const string RAINHA_VERMELHA = "assets/images/rainha-vermelha.png";			
	
	const string REI_PRETO = "assets/images/rei-preto.png";			
	const string REI_BRANCO = "assets/images/rei-branco.png";			
	const string REI_VERMELHO = "assets/images/rei-vermelho.png";

}

namespace fonts {

	const string FONT = "assets/fonts/arial.ttf";

}

#endif
