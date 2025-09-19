% define as listas de opções de [mochila, nome, mes, jogo, materia e suco]
lista_mochilas([amarela, azul, branca, verde, vermelha]).
lista_nomes([denis, joao, lenin, otavio, will]).
lista_meses([agosto, dezembro, janeiro, maio, setembro]).
lista_jogos([tres_ou_mais, caca_palavras, cubo_vermelho, jogo_da_forca, problema_de_logica]).
lista_materias([biologia, geografia, historia, matematica, portugues]).
lista_sucos([laranja, limao, maracuja, morango, uva]).

main :-
  statistics(cputime, T1),
  findall(Sol, modelo(Sol), Solucoes), % pega as tuplas do modelo sol, faz as tabelas possíveis e armazena em "Solucoes" / sintaxe: findall(Template, Goal, Lista)
  statistics(cputime, T2),

  % loop if-then-else (condição -> fazSeVerdadeiro : fazSeFalso)
  length(Solucoes, NumSolucoes),
  ( NumSolucoes =:= 0 -> % =:= comparar números
      write('Nenhuma solucao encontrada.'), nl
  ;
      last(Solucoes, UltimaSol), % pega a ultima solução 
      imprime_tabela(UltimaSol)
  ),

  T is T2 - T1, % "is" indica que T é a diferença entre T2 e T1 (lembrar!)
  format('\nTempo de CPU: ~3f segundos~n', [T]),
  format('Busca finalizada. ~w solucao(oes) encontrada(s).~n', [NumSolucoes]).

% imprime_todas_solucoes([]).
% imprime_todas_solucoes([Sol|T]) :-
%    imprime_tabela(Sol),
%    imprime_todas_solucoes(T).
% O codigo estava retornando mais de uma solucao/tabela, porem somente a ultima delas era a correta, entao removi essa parte

modelo(Sol) :-
    % estrutura da solução:
    Sol = [
        (M1, Nome1, Mes1, Jogo1, Mat1, Suco1),
        (M2, Nome2, Mes2, Jogo2, Mat2, Suco2),
        (M3, Nome3, Mes3, Jogo3, Mat3, Suco3),
        (M4, Nome4, Mes4, Jogo4, Mat4, Suco4),
        (M5, Nome5, Mes5, Jogo5, Mat5, Suco5)
    ],

    % cria listas de variáveis 
    Mochilas = [M1, M2, M3, M4, M5],
    Nomes    = [Nome1, Nome2, Nome3, Nome4, Nome5],
    Meses    = [Mes1, Mes2, Mes3, Mes4, Mes5],
    Jogos    = [Jogo1, Jogo2, Jogo3, Jogo4, Jogo5],
    Materias = [Mat1, Mat2, Mat3, Mat4, Mat5],
    Sucos    = [Suco1, Suco2, Suco3, Suco4, Suco5],

    % primeiras definições dadas diretamente:
    % o M5 eh Lenin, Otavio esta em uma das pontas, o primeiro menino gosta de suco de limão;
    % O M3 gosta de suco de morango, de biologia e de jogo da forca
    Nome5 = lenin,
    Nome1 = otavio,
    Suco1 = limao,
    Suco3 = morango, Mat3 = biologia, Jogo3 = jogo_da_forca,

    % alldifferent só garante que não está se repetindo e preciso atribuir valores pois nao gera combinacoes, 
    % enquanto o permutation gera todas as ordens possíveis sem repetir (talvez gaste mais tempo para gerar a tabela)
    lista_mochilas(ListaMochilas), permutation(ListaMochilas, Mochilas),
    lista_nomes(ListaNomes),       permutation(ListaNomes, Nomes),
    lista_meses(ListaMeses),       permutation(ListaMeses, Meses),
    lista_jogos(ListaJogos),       permutation(ListaJogos, Jogos),
    lista_materias(ListaMaterias), permutation(ListaMaterias, Materias),
    lista_sucos(ListaSucos),       permutation(ListaSucos, Sucos),

    % o dono da mochila azul nasceu em janeiro
    member((azul, _, janeiro, _, _, _), Sol),

    % quem gosta de suco de uva gosta de problemas de logica
    member((_, _, _, problema_de_logica, _, uva), Sol), 

    % joao gosta de historia
    member((_, joao, _, _, historia, _), Sol),

    % o menino que gosta de matematica nasceu em dezembro e gosta de maracuja
    member((_, _, dezembro, _, matematica, maracuja), Sol),

    % quem nasceu em janeiro esta ao lado de quem nasceu em setembro
    ( (Mes1 = janeiro, Mes2 = setembro) ; 
      (Mes2 = janeiro, (Mes1 = setembro ; Mes3 = setembro)) ; 
      (Mes3 = janeiro, (Mes2 = setembro ; Mes4 = setembro)) ; 
      (Mes4 = janeiro, (Mes3 = setembro ; Mes5 = setembro)) ; 
      (Mes5 = janeiro, Mes4 = setembro) ),

    % o garoto da mochila azul esta em algum lugar a esquerda de quem nasceu em maio
    ( (M1 = azul, (Mes2 = maio ; Mes3 = maio ; Mes4 = maio ; Mes5 = maio)) ; 
      (M2 = azul, (Mes3 = maio ; Mes4 = maio ; Mes5 = maio)) ; 
      (M3 = azul, (Mes4 = maio ; Mes5 = maio)) ; 
      (M4 = azul, Mes5 = maio) ),

    % will esta ao lado do menino que gosta de problemas de logica
    ( (Nome1 = will, Jogo2 = problema_de_logica) ; 
      (Nome2 = will, (Jogo1 = problema_de_logica ; Jogo3 = problema_de_logica)) ; 
      (Nome3 = will, (Jogo2 = problema_de_logica ; Jogo4 = problema_de_logica)) ; 
      (Nome4 = will, (Jogo3 = problema_de_logica ; Jogo5 = problema_de_logica)) ; 
      (Nome5 = will, Jogo4 = problema_de_logica) ),

    % mochila branca esta exatamente a esquerda de Will
    ( (M1 = branca, Nome2 = will) ; (M2 = branca, Nome3 = will) ; 
      (M3 = branca, Nome4 = will) ; 
      (M4 = branca, Nome5 = will) ),

    % o que gosta de suco de uva esta exatamente a esquerda de quem gosta de portugus
    ( (Suco1 = uva, Mat2 = portugues) ; 
      (Suco2 = uva, Mat3 = portugues) ; 
      (Suco3 = uva, Mat4 = portugues) ; 
      (Suco4 = uva, Mat5 = portugues) ),

    % quem curte problemas de logica esta ao lado do menino da mochila amarela
    ( (Jogo1 = problema_de_logica, M2 = amarela) ; 
      (Jogo2 = problema_de_logica, (M1 = amarela ; M3 = amarela)) ; 
      (Jogo3 = problema_de_logica, (M2 = amarela ; M4 = amarela)) ; 
      (Jogo4 = problema_de_logica, (M3 = amarela ; M5 = amarela)) ; 
      (Jogo5 = problema_de_logica, M4 = amarela) ),

    % cubo vermelho esta em uma das pontas
    (Jogo1 = cubo_vermelho ; Jogo5 = cubo_vermelho),

    % quem gosta de jogo da forca (menino#3) esta ao lado do dono da mochila vermelha
    (M2 = vermelha ; M4 = vermelha),

    % o menino que nasceu em setembro esta ao lado do que gosta de suco de laranja
    ( (Mes1 = setembro, Suco2 = laranja) ; 
      (Mes2 = setembro, (Suco1 = laranja ; Suco3 = laranja)) ; 
      (Mes3 = setembro, (Suco2 = laranja ; Suco4 = laranja)) ; 
      (Mes4 = setembro, (Suco3 = laranja ; Suco5 = laranja)) ; 
      (Mes5 = setembro, Suco4 = laranja)),

    % o jogo da forca (menino#3) esta ao lado do que gosta de 3 ou mais
    (Jogo2 = tres_ou_mais ; Jogo4 = tres_ou_mais),

    % O garoto que gosta de suco de uva esta a direita do garoto da mochila azul
    ( (M1 = azul, (Suco2 = uva ; Suco3 = uva ; Suco4 = uva ; Suco5 = uva)) ; 
      (M2 = azul, (Suco3 = uva ; Suco4 = uva ; Suco5 = uva)) ; 
      (M3 = azul, (Suco4 = uva ; Suco5 = uva)) ; 
      (M4 = azul, Suco5 = uva) ),

    % o menino que nasceu em setembro esta ao lado de quem gosta de jogar cubo vermelho
    ( (Mes1 = setembro, Jogo2 = cubo_vermelho) ; 
      (Mes2 = setembro, (Jogo1 = cubo_vermelho ; Jogo3 = cubo_vermelho)) ; 
      (Mes3 = setembro, (Jogo2 = cubo_vermelho ; Jogo4 = cubo_vermelho)) ; 
      (Mes4 = setembro, (Jogo3 = cubo_vermelho ; Jogo5 = cubo_vermelho)) ; 
      (Mes5 = setembro, Jogo4 = cubo_vermelho)).


      imprime_tabela(Sol) :-
        solucao_para_listas(Sol, Mochilas, Nomes, Meses, Jogos, Materias, Sucos), % recebe a solução final e extrai as colunas (predicado no final)

        format('+---------------+--------------+--------------+--------------+--------------+--------------+~n'),
        format('| Categoria     | Menino#1     | Menino#2     | Menino#3     | Menino#4     | Menino#5     |~n'),
        format('+---------------+--------------+--------------+--------------+--------------+--------------+~n'),
        
        print_row('Mochila', Mochilas), % print_row não trbalha com lista de tuplas, 
        print_row('Nome', Nomes),
        print_row('Mes', Meses),
        print_row('Jogo', Jogos),
        print_row('Materia', Materias),
        print_row('Suco', Sucos),
      
      
      print_row(Label, Values) :-
        format('| ~w~t~15  ||', [Label]),
        print_values(Values),
        nl.
      
      print_values([]).
      print_values([V|Vs]) :-
        format(' ~w~t~12||', [V]),
        print_values(Vs).      
      

% extrai as listas separadas a partir da solução (ultima)
solucao_para_listas(Sol, Mochilas, Nomes, Meses, Jogos, Materias, Sucos) :-
  findall(M, member((M,_,_,_,_,_), Sol), Mochilas),
  findall(N, member((_,N,_,_,_,_), Sol), Nomes),
  findall(Me, member((_,_,Me,_,_,_), Sol), Meses),
  findall(J, member((_,_,_,J,_,_), Sol), Jogos),
  findall(Mat, member((_,_,_,_,Mat,_), Sol), Materias),
  findall(S, member((_,_,_,_,_,S), Sol), Sucos).
