module type MathSig  =
  sig
    type rep
    val add : rep -> rep -> rep
    val div : rep -> rep -> rep
    val max : rep -> rep -> rep
    val min : rep -> rep -> rep
    val between: int -> int -> int -> bool
  end

module MathInt : MathSig with type rep = int =
    struct
        type rep = int
        let add n m = n + m
        let div n m = n / m
        let max n m = if n >= m then n else m
        let min n m = if n <= m then n else m
        let between low high value = value >= low && value <= high
    end

module MathFloat : MathSig with type rep = float =
    struct
        type rep = float
        let add n m = n +. m
        let div n m = n /. m
        let max n m = if n >= m then n else m
        let min n m = if n <= m then n else m
        let between low high value = value >= low && value <= high
    end
