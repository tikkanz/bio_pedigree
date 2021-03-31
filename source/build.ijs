NB. build
require 'project'
loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
AddonPath=: fpath_j_^:2 loc ''

writesource_jp_ (AddonPath,'/source');AddonPath,'/pedigree.ijs'

Proj_Src=: AddonPath,'/source'
Proj_Tgt=: AddonPath,'/pedigree.ijs'
writesource_jp_ Proj_Src;Proj_Tgt

echo 'Built file: ',Proj_Tgt
echo 'From: ',Proj_Src

NB. (jpath '~addons/bio/pedigree/pedigree.ijs') (fcopynew ::0:) jpath AddonPath,'/pedigree.ijs'

NB. f=. 3 : 0
NB. (jpath '~addons/bio/pedigree/',y) (fcopynew ::0:) jpath AddonPath,'/source/',y
NB. )

NB. mkdir_j_ jpath '~addons/bio/pedigree'
NB. f 'manifest.ijs'
NB. f 'history.txt'
NB. f 'test/test.ijs'
NB. f 'test/test_pedigrees.ijs'
