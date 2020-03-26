:- lib(lists).
:- lib(fd).
:- lib(fd_search).

sentries(Castle) :-
  setup(Castle),
  solve(Castle),
  printC(Castle).

sentries2(Castle) :-
  setup(Castle),
  solve2(Castle),
  printC(Castle).

setup(Castle) :-
  /* a list of 8 variables */
  Castle = [NW,N,NE,E,SE,S,SW,W],

  /* each variable is an integer between 0 and 12 */
  Castle :: 0..12,

  /* sum of the variables is 12 - note the #= -
  it must be #= so that this is a delayable integer
  constraint the others are #> #< #>= #=< #\=
  a delayable constraint is one that is not
  necessarily evaluated
  when it is first set up
  */

  NW + NE + SW + SE + E + W + S + N #= 12,
  NW+ NE + N #= 5,
  SE+ SW + S #= 5,
  NW + W + SW #= 5,
  SE + E + NE #= 5.

/* solve the problem by labeling the variables */
solve(Castle) :-
  labeling(Castle).

solve2(Castle) :-
  Castle = [NW,N,NE,E,SE,S,SW,W],
  Middles #= N+W,
  minimize(labeling(Castle),Middles).

printC(Castle) :-
  Castle = [NW,N,NE,E,SE,S,SW,W],
  printf("%3d%3d%3d\n", [NW,N,NE]),
  printf("%3d %3d\n", [ W, E]),
  printf("%3d%3d%3d\n", [SW,S,SE]).
