# Atividade de Inteligência Artificial – Quebra-Cabeça Lógico

## Descrição

Esta atividade consiste em resolver um **quebra-cabeça lógico** utilizando Prolog, baseado em regras e restrições dadas para cinco meninos. Cada menino possui informações sobre:

* Mochila
* Nome
* Mês de nascimento
* Jogo favorito
* Matéria favorita
* Suco preferido

O objetivo é determinar a **distribuição correta de cada característica** de acordo com as restrições fornecidas.

---

## Estrutura do Código

1. **Definição das listas de opções**
   Antes de gerar soluções, são definidas as opções possíveis para cada categoria:

```prolog
lista_mochilas([amarela, azul, branca, verde, vermelha]).
lista_nomes([denis, joao, lenin, otavio, will]).
lista_meses([agosto, dezembro, janeiro, maio, setembro]).
lista_jogos([tres_ou_mais, caca_palavras, cubo_vermelho, jogo_da_forca, problema_de_logica]).
lista_materias([biologia, geografia, historia, matematica, portugues]).
lista_sucos([laranja, limao, maracuja, morango, uva]).
```

Essas listas representam o **universo de possibilidades** para cada categoria.

---

2. **Predicado `modelo(Sol)`**

   * Define a **estrutura da solução**, usando 5 tuplas, cada uma representando um menino:

```prolog
Sol = [
  (M1, Nome1, Mes1, Jogo1, Mat1, Suco1),
  (M2, Nome2, Mes2, Jogo2, Mat2, Suco2),
  ...
]
```

* Aplica as **restrições do problema**, como por exemplo:

  * Lenin é o menino da posição 5.
  * Otavio está em uma das pontas.
  * O dono da mochila azul nasceu em janeiro.
  * Quem gosta de suco de uva gosta de problemas de lógica.
  * Regras de posição, vizinhança e sequência entre meninos.

* Garante que **não haja repetição** de elementos dentro de cada categoria usando `permutation/2`.

---

3. **Predicado `solucao_para_listas(Sol, Mochilas, Nomes, ...)`**

   * Recebe a solução final (`Sol`) e **extrai as colunas**, transformando-as em listas separadas por categoria:

```prolog
Mochilas = [amarela, azul, branca, verde, vermelha]
Nomes    = [denis, joao, lenin, otavio, will]
...
```

* Essas listas são chamadas de **listas de categoria**, usadas para impressão.

---

4. **Predicado `imprime_tabela(Sol)`**

   * Organiza os dados da solução em uma **tabela legível no terminal**.
   * Cada linha representa uma categoria (Mochila, Nome, Mês, Jogo, Matéria, Suco).
   * Cada coluna representa um menino:

| Categoria | Menino #1      | Menino #2  | Menino #3     | Menino #4       | Menino #5      |
| --------- | ---------------| ---------- | --------------| ----------------| -------------- |
| Mochila   | verde          | branca     | branca        | vermelha        | amarela        |
| Nome      | otavio         | denis      | lenin         | joao            | lenin          |
| Mês       | agosto         | dezembro   | janeiro       | setembro        | maio           |
| Jogo      | caça-palavras  | 3 ou mais  | jogo da forca | problemas de logica  | cubo\_vermelho |
| Matéria   | geografia      | matematica | biologia      | historia        | portugues      |
| Suco      | limao          | maracuja   | morango       | uva             | laranja        |

---

5. **Predicado `print_row` e `print_values`**

   * `print_row/2` imprime uma linha da tabela, recebendo o nome da categoria e a lista correspondente.
   * `print_values/1` percorre a lista de elementos de cada categoria e imprime de forma alinhada.

---

## Como Executar

1. Carregar o arquivo no SWI-Prolog ou VS code:

```prolog
?- ['atividade-meninos.pl'].
```

2. Executar o predicado principal:

```prolog
?- main.
```

3. O programa irá:

   * Calcular todas as soluções possíveis (`modelo(Sol)`).
   * Selecionar a última solução correta.
   * Imprimir a tabela organizada.
   * Mostrar o tempo de CPU gasto e o número de soluções encontradas.

---

## Conclusão

* Esta atividade demonstra **uso de lógica de restrições em Prolog** para resolver problemas combinatórios.
* Permite compreender como as variáveis, permutações e restrições trabalham juntas para gerar **uma solução consistente**.
* A tabela final permite visualizar **de forma clara e organizada** a solução do quebra-cabeça.

