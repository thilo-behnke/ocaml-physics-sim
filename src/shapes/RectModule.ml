open GeneralUtils
open ShapesModule
open LineModule
open VectorOpModule

type rect_boundary = {
    top_left: VectorOp.vec;
    top_right: VectorOp.vec;
    bottom_left: VectorOp.vec;
    bottom_right: VectorOp.vec
}


module RectShape : Shape with type boundary = rect_boundary =
    struct
        type shape = {top_left: VectorOp.vec; dim: VectorOp.vec}
        type boundary = rect_boundary

        let create top_left dim = {top_left; dim}
        let get_boundary s : rect_boundary =
            let {top_left; dim} = s in
            let top_right = VectorOp.get_x_vec dim |> VectorOp.add top_left in
            let bottom_left = VectorOp.get_y_vec dim |> VectorOp.sub top_left in
            let bottom_right_tmp = VectorOp.get_y_vec dim |> VectorOp.sub top_left in let bottom_right = (VectorOp.get_x_vec dim) |> VectorOp.sub bottom_right_tmp in
            {top_left; top_right; bottom_left; bottom_right}

        let is_point_in_shape s p =
            let {top_left; top_right; bottom_left; bottom_right} = get_boundary s in
            let top = Line.create top_left top_right in
            let right = Line.create top_right bottom_right in
            let bottom = Line.create bottom_right bottom_left in
            let left = Line.create bottom_left top_left in
            Line.is_below_shape top p && Line.is_above_shape bottom p && Line.is_right_to_shape left p && Line.is_left_to_shape right p
        let overlap (s1: shape) (s2: shape) =
            let {top_left; top_right; bottom_left; bottom_right} = get_boundary s1 in
            let {top_left = top_left2; top_right = top_right2; bottom_left = bottom_left2; bottom_right = bottom_right2} = get_boundary s2 in
            VectorOp.eql top_left top_left2 || VectorOp.eql top_right top_right2 || VectorOp.eql bottom_left bottom_left2 || VectorOp.eql bottom_right bottom_right2 ||
            is_point_in_shape s1 top_left2 || is_point_in_shape s1 top_right2 || is_point_in_shape s1 bottom_left2 || is_point_in_shape s1 bottom_right2
(*        TODO: Implement*)
        let where_is_point_to_shape rect point = function
            | HORIZONTAL -> LEFT
            | VERTICAL -> RIGHT
        let is_left_to_shape line point = false
        let is_right_to_shape line point = false
        let is_above_shape line point = false
        let is_below_shape line point = false
    end
