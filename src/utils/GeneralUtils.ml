type direction = RIGHT | DOWN | LEFT | UP | NONE

let (|>) x f = f x
let (<|) f x = x f

