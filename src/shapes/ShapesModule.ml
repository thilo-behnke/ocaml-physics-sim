open GeneralUtils
open VectorOpModule

type position = HORIZONTAL | VERTICAL

module type Shape =
    sig
        type shape
        type boundary
        val create : VectorOp.vec -> VectorOp.vec -> shape
        val overlap : shape -> shape -> bool
        val get_boundary : shape -> boundary
        val is_point_in_shape : shape -> VectorOp.vec -> bool
        val where_is_point_to_shape : shape -> VectorOp.vec -> position -> direction
        val is_left_to_shape: shape -> VectorOp.vec -> bool
        val is_right_to_shape: shape -> VectorOp.vec -> bool
        val is_above_shape: shape -> VectorOp.vec -> bool
        val is_below_shape: shape -> VectorOp.vec -> bool
    end

