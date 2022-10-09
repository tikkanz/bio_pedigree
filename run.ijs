loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
ProjPath=: fpath_j_ loc ''                      NB. folder containing this file

NB. =========================================================
NB. Build & Test
NB. =========================================================
load ProjPath,'/build.ijs'   NB. rebuild
load ProjPath,'/pedigree.ijs'   NB. reload
NB. run tests here
echo 'Running tests...'
load ProjPath,'/test/test.ijs'
