
before_each=: 3 : 0
  load 'bio/pedigree'
  coinsert 'pedigree'
  load 'bio/pedigree/test/test_pedigrees'
)

test_ped1=: 3 : 0
  assert 8 3 = $tstped
)

test_pedchecks=: 3 : 0
  assert 0 0 0 0 -: checkPed tstped
  assert 0 0 0 0 -: checkPed jvped
  assert 0 0 0 1 -: checkPed litped
  assert 1 1 1 1 -: checkPed badped
  assert 0 0 0 0 -: checkPed badped2
)

test_sorting=: 3 :0
  assert -. checkSorted tstped
  assert -. checkSorted jvped
  assert -. checkSorted badped
  assert -. checkSorted badped2
  assert -. checkSorted sortPed badped2
  assert checkSorted sortPed tstped
  assert checkSorted sortPed jvped
  assert checkSorted litped
  assert -. checkSorted shuffle jvped
  assert checkSorted sortPed shuffle jvped
)

test_recoding=: 3 :0
  assert checkSorted recodePed litped
)