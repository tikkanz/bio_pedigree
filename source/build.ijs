NB. build
require 'project'
NB. loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
AddonPath=: fpath_j_^:2 loc ''

writesource_jp_ (AddonPath,'/source');AddonPath,'/pedigree.ijs'

NB. (jpath '~addons/bio/pedigree/pedigree.ijs') (fcopynew ::0:) jpath AddonPath,'/pedigree.ijs'

f=. 3 : 0
(jpath '~addons/bio/pedigree/',y) (fcopynew ::0:) jpath AddonPath,'/source/',y
)

NB. mkdir_j_ jpath '~addons/bio/pedigree'
NB. f 'manifest.ijs'
NB. f 'history.txt'
NB. f 'test/test.ijs'
NB. f 'test/test_pedigrees.ijs'
