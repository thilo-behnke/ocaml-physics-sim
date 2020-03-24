open ShapesModule
open VectorOpModule
open GeneralUtils

type line = {
    l_start: VectorOp.vec;
    l_end: VectorOp.vec;
}

module type LineShape =
    sig
       include Shape

       val are_parallel: shape -> shape -> bool
    end

module Line : LineShape with type boundary = line =
    struct
        type shape = VectorOp.vec*VectorOp.vec
        type boundary = line

        let create l_start l_end = l_start, l_end
        let get_boundary line = let l_start, l_end = line in {l_start; l_end}
        let is_point_in_shape line point =
            let l_start, l_end = line in
            VectorOp.distance l_start point +. VectorOp.distance l_end point = VectorOp.distance l_start l_end
        let where_is_point_to_shape line point position =
            let l_start, l_end = line in
            let cross = VectorOp.cross (VectorOp.sub l_end l_start) (VectorOp.sub l_end point) in
            let pos = cross >= 0. in
            match position, pos with
                | HORIZONTAL, false -> RIGHT
                | HORIZONTAL, true -> LEFT
                | VERTICAL, false -> UP
                | VERTICAL, true -> DOWN
        let is_left_to_shape line point = where_is_point_to_shape line point HORIZONTAL = LEFT
        let is_right_to_shape line point = where_is_point_to_shape line point HORIZONTAL = RIGHT
        let is_above_shape line point = where_is_point_to_shape line point VERTICAL = UP
        let is_below_shape line point = where_is_point_to_shape line point VERTICAL = DOWN

        let are_parallel line1 line2 = let l_start1, l_end1 = line1 in let l_start2, l_end2 = line2 in
            let distance_start = VectorOp.distance l_start1 l_start2 in
            let distance_end = VectorOp.distance l_end1 l_end2 in
            distance_start = distance_end

        let overlap line1 line2 = are_parallel line1 line2 |> not
    end
