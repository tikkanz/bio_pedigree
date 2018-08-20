NB. init

Note 'pedigree utilities'
A pedigree is represented by a 3-column table of animalid, sireid, damid
If the ids are not numeric then a missing/unknown parent is represented by '.'
If the ids are numeric then a missing/unknown parent is represented by 0
)

cocurrent 'pedigree'
require 'general/misc/validate'
NB. ped

getMissing=: (0 ;< <,'.') {::~ isboxed     NB. choose approriate missing value depending on input

NB.*getPedIds v Returns canonical list of Ids from a pedigree
NB. useful for converting to/from recoded pedigrees
NB. eg: (getPedIds {~ sortPed@recodePed) myped
getPedIds=: [: ~. getMissing , ,

NB.*recodePed v Recodes 3-column pedigree to integers 0-n
NB. y is: either 3-column integer pedigree or 3-column boxed literal pedigree
recodePed=: i.~ getPedIds

NB.*readPlinkPed v Reads pedigree from Plink .ped filename given by y
readPlinkPed=: 1 2 3 {"1 (_99) ". [: ];._2 freads  NB. works for numeric ids

NB. expects a pedigree consisting of 3 columns of integer ids: id,sire,dam

Unknown=: 0                           NB. id of unknown/missing animals
uniqKnown=: Unknown -.~ ~.            NB. uniq ids without missing/unknown ids
uniqIds=: uniqKnown@:(0&{"1)          NB. uniq animal ids without missing/unknown ids
uniqSires=: uniqKnown@:(1&{"1)        NB. uniq sire ids without missing/unknown ids
uniqDams=: uniqKnown@:(2&{"1)         NB. uniq dam ids without missing/unknown ids
getAllParents=: uniqKnown@,@:(}."1)
getAllParents=: uniqSires,uniqDams    NB. uniq parent ids without missing/unknown ids

NB.*checkPed v Check pedigree in y for any common errors
NB. Note that for some species some of these will not necessarily be pedigree errors
checkPed=: any@ownParents , any@multiSexSires , any@duplicateIds , any@noIds

Errors=: <;._2 noun define
Some animals are their own parents.
Some animals are both sires and dams.
Some animals have multiple individual records.
Some parents do not have their own individual record.
)

NB.*reportPedErrors v Report any common errors found in pedigree y
reportPedErrors=: LF joinstring Errors #~ checkPed

NB. no duplicate ids
duplicateIds=: ([: <: [: #/.~ {."1)
getDuplicates=: duplicateIds # uniqIds

NB. no sires are also dams
multiSexSires=: uniqSires e. uniqDams
getMultiSexSires=: uniqSires ([ #~ e.) uniqDams

NB. animals that are their own parent
ownParents=: {."1 e."_1 }."1
getOwnParents=: #~ ownParents

NB. parents with no own record
noIds=: getAllParents -.@e.&(-.&Unknown) uniqIds
getNoIds=: getAllParents ([ #~ -.@e.&(-.&Unknown)) uniqIds
addNoIds=: ,~ ,.@getNoIds (,"1) 0 0"_

NB. ids that occur after id as parent
lateIds=: -.@(*./)@(i.@# <"1 (}. i."1 {.)@|:)
checkSorted=: [: *./ -.@lateIds

isParent=: {."1 e. getAllParents

NB. Journal of Animal and Veterinary Advances
NB. Year: 2009 | Volume: 8 | Issue: 1 | Page No.: 177-182
NB. An Algorithm to Sort Complex Pedigrees Chronologically without Birthdates
NB. Zhiwu Zhang , Changxi Li , Rory J. Todhunter , George Lust , Laksiri Goonewardene and Zhiquan Wang
getGen=: +/@(e."2 (#~ isParent)^:a:)

NB.*sortPed v Sort pedigree y so that no animal occurs before its parents
sortPed=: \: getGen

NB.*getParents v Get list of animalkeys for 1st generation ancestors of y in pedigree x
NB. y is: numeric list of animalkeys
NB. x is: 3-column numeric table of pedigree (animal, sire, dam)
NB. getParents=: (Unknown -.~ ~.@,)@((0 0 0 ,~ [) {~ {."1@[ i. ])
getParents=: uniqKnown@,@([ #~ {."1@[ e. ])

NB.*getProgeny v Get list of animalkeys for 1st generation descendants of y in pedigree x
NB. y is: numeric list of animalkeys
NB. x is: 3-column numeric table of pedigree (animal, sire, dam)
getProgeny=: ~.@(] , {."1@[ #~ [: +./"1 }."1@[ e."1 ])

NB.*getAncestors a Get list of animalkeys for all ancestors of y in pedigree x
NB. y is: numeric list of animalkeys
NB. x is: 3-column numeric table of pedigree (animal, sire, dam)
NB. m is: integer specifying the number of generations back to go
NB. eg: jvped  2 getAncestors 8
NB. eg: (readStructPed 'gsped.bin') 2 getAncestors 20966331
getAncestors=: 1 :'getParents^:m'
getAncestors=: getParents^:

NB.*getDescendants a Get list of animalkeys for all descendants of y in pedigree x
NB. y is: numeric list of animalkeys
NB. x is: 3-column numeric table of pedigree (animal, sire, dam)
NB. m is: integer specifying the number of generations forward to go
NB. eg: jvped 2 getDescendants 2
getDescendants=: 1 : 'getProgeny^:m'
getDescendants=: getProgeny^:

NB.*getDegreeRelatives a Get list of animalkeys for all relatives of y in pedigree x to degree m
NB. y is: numeric list of 1 or more animalkeys to start from
NB. x is: 3-column numeric table of pedigree (animal, sire, dam)
NB. m is: integer specifying the number of meioses from the starting animals to include
getDegreeRelatives=: 1 :'~.@(getProgeny , getParents)^:m'
getDegreeRelatives=: ~.@(getProgeny , getParents)^:
NB. util

any=: +./
