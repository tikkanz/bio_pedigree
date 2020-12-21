# Pedigree

Utilities for working with animal pedigrees

Expects pedigrees to be provided as a table of 3 fields:
 `ProgenyID`, `SireID`, `DamID`

IDs can be numeric or non-numeric. 
Unknown IDs are represented as `0` or `.` for numeric and non-numeric IDs respectively.

  * Reading: `readPlinkPed`
  * Checking: `checkPed`, `reportPedErrors`, `checkSorted`
  * Sorting: `sortPed`
  * Recoding: `recodePed`, `getPedId`
  * Retrieving related animals
    * Ancestors: `getAllParents`, `getParents`, `getAncestors`
    * Descendants: `getProgeny`, `getDescendants`
    * Relatives: `getDegreeRelatives`

```j
   load 'bio/pedigree'
   coinsert 'pedigree'
   load 'bio/pedigree/test/test_pedigrees.ijs'
   ]litped
┌────────┬──────┬────────┐
│Harry   │George│Daisey  │
├────────┼──────┼────────┤
│Gertrude│Jim   │Jessica │
├────────┼──────┼────────┤
│Nader   │Harry │Gloria  │
├────────┼──────┼────────┤
│Karen   │Harry │Michelle│
├────────┼──────┼────────┤
│Steve   │Harry │Fatma   │
├────────┼──────┼────────┤
│Frances │Harry │.       │
├────────┼──────┼────────┤
│Hein    │Tom   │Gertrude│
├────────┼──────┼────────┤
│Emily   │Tom   │Susan   │
├────────┼──────┼────────┤
│Barry   │Hein  │Karen   │
├────────┼──────┼────────┤
│Scott   │Hein  │Karen   │
├────────┼──────┼────────┤
│Kristi  │Hein  │Karen   │
├────────┼──────┼────────┤
│Helen   │Hein  │Emily   │
└────────┴──────┴────────┘
   litped getParents <'Helen'
┌─────┬────┬─────┐
│Helen│Hein│Emily│
└─────┴────┴─────┘
   litped 1 getAncestors <'Helen'
┌─────┬────┬─────┐
│Helen│Hein│Emily│
└─────┴────┴─────┘
   litped 2 getAncestors <'Helen'
┌────┬───┬────────┬─────┬─────┬─────┐
│Hein│Tom│Gertrude│Emily│Susan│Helen│
└────┴───┴────────┴─────┴─────┴─────┘
   litped _ getAncestors <'Helen'        NB. get all ancestors
┌────────┬───┬───────┬────┬───┬─────┬─────┬─────┐
│Gertrude│Jim│Jessica│Hein│Tom│Emily│Susan│Helen│
└────────┴───┴───────┴────┴───┴─────┴─────┴─────┘
   litped 1 getDegreeRelatives <'Harry'  NB. get relatives within once meiosis (parents & progeny).
┌─────┬─────┬─────┬─────┬───────┬──────┬──────┐
│Harry│Nader│Karen│Steve│Frances│George│Daisey│
└─────┴─────┴─────┴─────┴───────┴──────┴──────┘
```

## Checking/recoding/sorting pedigrees
```j
   reportPedErrors badped
Some animals are their own parents.
Some animals are both sires and dams.
Some animals have multiple individual records.
Some parents do not have their own individual record.
```

Some algoritms require all animals to have their own record, `addNoIds` will add records for parents that don't have their own record.
```j
   reportPedErrors litped
Some parents do not have their own individual record.
   addNoIds litped
┌────────┬──────┬────────┐
│George  │.     │.       │
├────────┼──────┼────────┤
│Jim     │.     │.       │
├────────┼──────┼────────┤
│Tom     │.     │.       │
├────────┼──────┼────────┤
│Daisey  │.     │.       │
├────────┼──────┼────────┤
│Jessica │.     │.       │
├────────┼──────┼────────┤
│Gloria  │.     │.       │
├────────┼──────┼────────┤
│Michelle│.     │.       │
├────────┼──────┼────────┤
│Fatma   │.     │.       │
├────────┼──────┼────────┤
│Susan   │.     │.       │
├────────┼──────┼────────┤
│Harry   │George│Daisey  │
├────────┼──────┼────────┤
│Gertrude│Jim   │Jessica │
├────────┼──────┼────────┤
│Nader   │Harry │Gloria  │
├────────┼──────┼────────┤
│Karen   │Harry │Michelle│
├────────┼──────┼────────┤
│Steve   │Harry │Fatma   │
├────────┼──────┼────────┤
│Frances │Harry │.       │
├────────┼──────┼────────┤
│Hein    │Tom   │Gertrude│
├────────┼──────┼────────┤
│Emily   │Tom   │Susan   │
├────────┼──────┼────────┤
│Barry   │Hein  │Karen   │
├────────┼──────┼────────┤
│Scott   │Hein  │Karen   │
├────────┼──────┼────────┤
│Kristi  │Hein  │Karen   │
├────────┼──────┼────────┤
│Helen   │Hein  │Emily   │
└────────┴──────┴────────┘
```

Some algoritms require all parents to occur in the pedigree before their progeny, `sortPed` will ensure this is the case.
```j
   checkSorted shuffle litped
0
   checkSorted sortPed shuffle litped
1
```

For larger pedigrees it will probably be more performant to recode non-numeric IDs as numeric and retrieve as necessary.
```j
   recodePed litped
 1  2  3
 4  5  6
 7  1  8
 9  1 10
11  1 12
13  1  0
14 15  4
16 15 17
18 14  9
19 14  9
20 14  9
21 14 16
   (getPedIds litped) {~ (recodePed litped) getProgeny 9
┌─────┬─────┬─────┬──────┐
│Karen│Barry│Scott│Kristi│
└─────┴─────┴─────┴──────┘
```
