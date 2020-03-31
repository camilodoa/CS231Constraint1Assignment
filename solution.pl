/* Kevin Ma, Michael Garcia, Shengdi Lin, Camilo Ortiz */
:- lib(lists).
:- lib(fd).
:- lib(fd_search).

sentries(Castle) :-
  % C is our sentries per wall variable
  C :: 0..100,
  setup(Castle, C),
  solve(Castle, C),
  printC(Castle).

setup(Castle, C) :-
  /* a list of 12 variables */
  Castle = [N, NNE, NE, E, SE, SSE, S, SSW, SW, W, NW, NNW],

  /* each variable is an integer between 0 and 100 */
  Castle :: 0..100,

  /* each wall value is unique */
  alldifferent(Castle),

  NNW + N + NNE #= C,
  W + NW + NNW #= C,
  W + SW + SSW #= C,
  SSW + S + SSE #= C,
  SSE + SE + E #= C,
  E + NE + NNE #= C.

/* solve the problem by labeling the variables */
solve(Castle, C) :-
  minimize(labeling(Castle), C).

printC(Castle) :-
  Castle = [N, NNE, NE, E, SE, SSE, S, SSW, SW, W, NW, NNW],
  printf("  %3d %3d %3d  \n", [NNW, N, NNE]),
  printf(" %3d \t \t %3d \n", [NW, NE]),
  printf("%3d \t \t %3d\n", [ W, E]),
  printf(" %3d \t \t %3d \n", [SW, SE]),
  printf("  %3d %3d %3d  \n", [SSW, S, SSE]).
