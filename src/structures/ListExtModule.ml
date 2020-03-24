
module type ListExtSig =
    sig
        val take: 'a list -> int -> 'a list
    end

module ListExt : ListExtSig =
    struct
        include List

        let take l n =
            let rec inner acc m = function
                | e::rest -> let acc' = e::acc in if List.length acc' < n then inner acc' (m - 1) rest else acc'
                | [] -> acc
            in inner [] n l |> List.rev
    end
