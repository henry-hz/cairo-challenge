



sqrt1 0 s = 1
sqrt1 n s = (x + s/x) / 2 where x = sqrt1 (n-1) s

main = do
  let result = sqrt1 20 16
  print result
