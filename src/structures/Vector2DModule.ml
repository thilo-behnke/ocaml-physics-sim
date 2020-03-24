open MathModule

module type Vector2D =
    sig
        type vec

        val create : float -> float -> vec
        val add : vec -> vec -> vec
        val sub : vec -> vec -> vec
        val mult: vec -> vec -> vec
        val scalar_prod : vec -> float -> vec
        val dot : vec -> vec -> float
        val cross : vec -> vec -> float
        val min : vec -> vec -> vec
        val max : vec -> vec -> vec
        val lte : vec -> vec -> bool
        val get_angle : vec -> vec -> float
        val len : vec -> float
        val norm : vec -> vec
        val eql : vec -> vec -> bool
        val distance : vec -> vec -> float
        val get_coordinates : vec -> float*float
        val reduce : vec -> (float -> float -> 'b) -> 'b
    end

module Vector2DImpl : Vector2D =
    struct
        type vec = (float*float)
        let create x y = (x,y)

        let add (x, y) (x2, y2) = (x +. x2, y +. y2)
        let sub (x, y) (x2, y2) = (x -. x2, y -. y2)
        let mult (x, y) (x2, y2) = (x *. x2, y *. y2)
        let scalar_prod (x, y) s = (x *. s, y *. s)
        let dot (x, y) (x2, y2) = x *. x2 +. y *. y2
(*        TODO: How exactly does this cross product work?*)
        let cross (x, y) (x2, y2) = x *. y2 -. x2 *. y
        let min (x, y) (x2, y2) = (MathFloat.min x x2), (MathFloat.min y y2)
        let max (x, y) (x2, y2) = (MathFloat.max x x2), (MathFloat.max y y2)
        let len (x, y) = let x_sq = x ** 2.0 in let y_sq = y ** 2.0 in x_sq +. y_sq |> sqrt
        let lte (x, y) (x2, y2) = x <= x2 && y <= y2
        let get_angle v1 v2 =
            let v_dot = dot v1 v2 in
            let v1_len = len v1 in
            let v2_len = len v2 in
            let v_cos = v1_len *. v2_len |> MathFloat.div v_dot in acos v_cos
        let norm ((x, y) as v) = let v_len = len v in create (MathFloat.div x v_len) (MathFloat.div y v_len)
        let eql (x, y) (x2, y2) = x = x2 && y = y2
        let distance (x, y) (x2, y2) = let d_x = (x -. x2)**2.0 in let d_y = (y -. y2)**2.0 in d_x +. d_y |> sqrt
        let get_coordinates v = let (x, y) = v in x, y
        let reduce (v: vec) f = let x, y = get_coordinates v in f x y
    end
