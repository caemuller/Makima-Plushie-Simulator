# :heart: Makima Plushie Simulator :heart:
Repo for our project :heart:

-----------------------------------------------------
| Critérios Técnicos                                  
|-----------------------------------------------------
- [x] Malhas poligonais complexas                                  
- [x] Transformações geométricas controlada pelo usuário 
- [x] Câmera livre e câmera look-at
- [x] Instâncias de objetos                              
- [x] Três tipos de testes de intersecção                
- [x] Modelos de Iluminação Difusa e Blinn-Phong 
- [x] Modelos de Interpolação de Phong e Gouraud         
- [x] Mapeamento de texturas em todos os objetos         
- [x] Movimentação com curva Bézier cúbica               
- [x] Animações baseadas no tempo ($\Delta t$)   
- [x] Makima plushie   (soon I hope :sunglasses:)                                  
- [x] Walls (who tf needs walls nowadays anyway?)                                             
- [x] Enemies                       
- [x] Crosshair                 
- [x] Trees    
|-----------------------------------------------------

Contribuições

Caetano: 
- Malhas poligonais complexas - gnomo
- Makima (Main character)
- Câmera livre e câmera look-at
- Modelos de Iluminação Difusa e Blinn-Phong
- Mapeamento de texturas em todos os objetos
- Animações baseadas no tempo ($\Delta t$)
- Crosshair
- Colisoes
 
Victor:
- Malhas poligonais complexas - Arvores
- Modelos de Interpolação de Phong e Gouraud
- Transformações geométricas controlada pelo usuário - SMASH
- Mapeamento de texturas em todos os objetos
- Movimentação com curva Bézier cúbica
- Animações baseadas no tempo ($\Delta t$)
- Iluminacao feita pela Lua
- Colisoes

Animações, instancias de objetos, mapeamento de texturas entre outras implementações repetitivas e relativamete simples foram feitos por ambos.

## Aplicação dos conceitos de computação gráfica:
- Malhas poligonais complexas: os obejetos mais complexos são os gnomos e a personagem(makima plushie *-*), sendo o gnomo mais complexo que a vaca.
- Transformações geométricas controlada pelo usuário: o jogo se baseia em SMASH(amaçar) os inimigos, sendo eles os gnomos.
- Câmera livre e câmera look-at: O jogo inicia com a camera livre, e ao apertar V pode-se alternar entre esta e a look-at.
- Instâncias de objetos: variados objetos instânciados.
- Três tipos de testes de intersecção: (Point-Point, Point-Box, Box-Box)
- Modelos de Iluminação Difusa e Blinn-Phong: estando ambos presentes nos dois modelos de interpolação podem ser observados em todos objetos, embora com diferentes K's.
- Modelos de Interpolação de Phong e Gouraud: Todos objetos utilizam a interpolação de phong com excessão de uma esfera utilizada para demonstrar a de gourad ao lado de sua cópia com a de phong, pois é um método de iluminação  "pior", e não tinha porque usá-la no trabalho, sendo uma das duas esferas rotacionando.
- Mapeamento de texturas em todos os objetos: Todos objetos possuem textura, com "excessão" do crosshair que não é uum objeto, sendo apenas colorido.
- Movimentação com curva Bézier cúbica: não pensamos no que utilizar, talvez nos gnomos, mas tem uma bola rotacionando que circula a floresta em um arco com o método.
- Animações baseadas no tempo ($\Delta t$): todas animações, são abaseadas no tempo, incluindo a movimentação com a curva de bezier, a movimentação da camera, a movimentação da lua, a skysphere(skybox). Se alguma faltou, provavelmente também é.

## Manual do Makima plushie simulator(MAKIMA SMASH):
Interações:
- W,S,A,D: utilizados para movimentação do personagem(camera).
- E: SMASH. (modo ataque + DEATH TOUCH)
- 1: Habilita/Desabilita o crosshair.
- V: Trocar entre camera look-at e free-view.
- P, O: trocam entre as projeções(herança do laboratório, e buga a skysphere).


## Jogo:
O objetivo do jogo eh AMASSAR os gnomos. Acompanhado de uma ambientação ABSURDA. E com umas bolinhas amigas

## Como Executar
Em um terminal basta rodar o comando 

make run

## Uso de LLMs
Foi usado a ferramenta Github Copilot em grande parte do trabalho para acelerar
partes que requerem grande esforco manual.

O uso do ChatGPT ocorreu apenas uma vez para o crosshair (nao foi util no geral)

## Images

This game was inspired by our goddess
![Makima](pictures/makima-egg.jpg)

1st screenshot of the game
![Screenshot 1](pictures/print_jogo1.png)

2nd screenshot of the game
![Screenshot 2](pictures/print_jogo2.png)