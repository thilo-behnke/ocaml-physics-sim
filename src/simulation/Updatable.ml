
module type Updatable =
    sig
        val update: 'a -> float -> float -> 'a
    end
