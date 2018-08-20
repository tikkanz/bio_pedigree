require 'general/unittest'

getDir=: '/' joinstring (_1 * 0 >. ])@[ }. '/' cut fpath_j_@jpath@]
loc_z_=: 3 : 'jpath > (4!:4 <''y'') { 4!:3 $0'  NB. pathname of script calling it
AddonPath=. 1 getDir loc ''

echo AddonPath,'/test/test_0.ijs'
NB. unittest jpath '~Addons/bio_pedigree/test/test_0.ijs'
unittest jpath AddonPath,'/test/test_0.ijs'