open Vector2DModule

module Vector (M : Vector2D) =
struct
    include M
    let zero_vec = M.create 0. 0.
    let unity_vec = M.create 1. 1.

    let get_x_vec v = create 1. 0. |> mult v
    let get_y_vec v = create 0. 1. |> mult v
end

module VectorOp = Vector(Vector2DImpl)
