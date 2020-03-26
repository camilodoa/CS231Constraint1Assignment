/*Kevin Ma, Michael Garcia, Shengdi Lin, Camilo Ortiz*/

:- lib(lists).
:- lib(fd).
:- lib(fd_search).

sentries(Castle) :-
  setup(Castle),
  solve(Castle),
  printC(Castle).

sentries2(Castle) :-
  setup(Castle),
  printC(Castle).

setup(Castle) :-
  /* a list of 12 variables */
  Castle = [N, NNE, NE, E, SE, SSE, S, SSW, SW, W, NW, NNW],

  /* each variable is an integer between 0 and 12 */
  Castle :: 0..12,

  /* sum of the variables is 12 - note the #= -
  it must be #= so that this is a delayable integer
  constraint the others are #> #< #>= #=< #\=
  a delayable constraint is one that is not
  necessarily evaluated
  when it is first set up
  */

  N + NNE + NE + E + SE + SSE + S + SSW + SW + W + NW + NNW #= 12,

  NNW + N + NNE #=  W + NW + NNW,
  W + NW + NNW #= W + SW + SSW,
  W + SW + SSW #= SSW + S + SSE,
  SSW + S + SSE #= SSE + SE + E,
  SSE + SE + E #= E + NE + NNE,

  alldifferent(Castle).

/* solve the problem by labeling the variables */
solve(Castle) :-
  labeling(Castle).

printC(Castle) :-
  Castle = [N, NNE, NE, E, SE, SSE, S, SSW, SW, W, NW, NNW],
  printf("  %3d %3d %3d  \n", [NNW, N, NNE]),
  printf(" %3d \t %3d \n", [NW, NE]),
  printf("%3d \t %3d\n", [ W, E]),
  printf(" %3d \t %3d \n", [SW, SE]),
  printf("  %3d %3d %3d  \n", [SSW, S, SSE]).
