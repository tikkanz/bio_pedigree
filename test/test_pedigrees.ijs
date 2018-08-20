NB.========================================================================================
NB. Test data

tstped=: (/: # ?@$ 0:) _99 ". ];._2  noun define
1 0 0
2 0 0
3 1 2
4 1 2
5 3 2
6 5 4
7 3 4
8 6 7
)

NB. pedigree from Zhang et. al. 2009
jvped=: _99 ". ];._2  noun define
1 4 12
2 11 13
3 0 0
4 3 9
5 14 15
6 5 10
7 6 8
8 2 1
9 0 0
10 11 13
11 3 9
12 0 0
13 0 0
14 0 0
15 3 9
)

NB. errors own parent, duplicate ids, multisex parent, no indiv record
badped=: (/: # ?@$ 0:) _99 ". ];._2  noun define
1 0 0
2 0 0
3 1 2
4 1 5
5 3 2
5 9 5
6 4 1
7 4 3
8 6 7
)

NB. circular pedigree
NB. cannot be correctly sorted
NB. Test for circular pedigree by sorting then check if sorted?
badped2=: (/: # ?@$ 0:) _99 ". ];._2  noun define
1 0 0
2 0 0
3 1 2
4 1 9
5 3 2
6 5 2
7 3 4
8 5 6
9 8 7
10 3 6
)

Note 'Working with literal pedigree'
recodePed litped                          NB. represent pedigree as integers
reportPedErrors recodePed litped
reportPedErrors addNoIds recodePed litped
(getPedIds {~ sortPed@recodePed) litped   NB. get changed pedigree back with original ids
)

litped=: cut;._2 noun define
Harry      George   Daisey
Gertrude   Jim      Jessica
Nader      Harry    Gloria
Karen      Harry    Michelle
Steve      Harry    Fatma
Frances    Harry    .
Hein       Tom      Gertrude
Emily      Tom      Susan
Barry      Hein     Karen
Scott      Hein     Karen
Kristi     Hein     Karen
Helen      Hein     Emily
)
