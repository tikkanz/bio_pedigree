dbr 1
NB. load 'bio/pedigree'
loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it

AddonPath=. fpath_j_^:2 loc ''

load AddonPath,'/test/test.ijs'
