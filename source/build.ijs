NB. build
require 'project'
writesource_jp_ '~Addons/bio_pedigree/source';'~Addons/bio_pedigree/pedigree.ijs'

NB. (jpath '~addons/bio/pedigree/pedigree.ijs') (fcopynew ::0:) jpath '~Addons/bio_pedigree/pedigree.ijs'

f=. 3 : 0
NB. (jpath '~Addons/bio_pedigree/',y) fcopynew jpath '~Addons/bio_pedigree/source/',y
(jpath '~addons/bio/pedigree/',y) (fcopynew ::0:) jpath '~Addons/bio_pedigree/source/',y
)

NB. mkdir_j_ jpath '~addons/bio/pedigree'
NB. f 'manifest.ijs'
NB. f 'history.txt'
NB. f 'test/test.ijs'
NB. f 'test/test_pedigrees.ijs'
