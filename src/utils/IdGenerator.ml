
module type IdGeneratorSig =
    sig
        type generator

        val create: unit -> generator
        val next: generator -> generator*int
    end


module IdGenerator : IdGeneratorSig =
    struct
        type generator = {state: int}

        let create () = {state = 0}
        let next {state} = let next_counter = state + 1 in {state = next_counter}, next_counter
    end
