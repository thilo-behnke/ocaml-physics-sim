open RectModule
open VectorOpModule
open MathModule
open GeneralUtils

type time_obj = {time_ms: float; delta_ms: float}

module type PhysicsObjectSig =
    sig
        type physics_obj

        val create: dim:VectorOp.vec -> max_acc:VectorOp.vec -> max_vel:VectorOp.vec -> acc_per_ms:VectorOp.vec -> pos:VectorOp.vec -> acc:VectorOp.vec -> vel:VectorOp.vec -> physics_obj
        val get_bounding_box: physics_obj -> RectShape.shape
        val accelerate: physics_obj -> time_obj -> physics_obj
        val decelerate: physics_obj -> time_obj -> physics_obj
        val get_acc: physics_obj -> VectorOp.vec
        val set_acc: physics_obj -> VectorOp.vec -> physics_obj
        val get_vel: physics_obj -> VectorOp.vec
        val update: physics_obj -> time_obj -> physics_obj
    end


module PhysicsObject : PhysicsObjectSig =
    struct
        type physics_obj_constants = {
            dim: VectorOp.vec;
            max_acc: VectorOp.vec;
            acc_per_ms: VectorOp.vec;
            max_vel: VectorOp.vec;
        }

        type physics_obj_state = {
            pos: VectorOp.vec;
            acc: VectorOp.vec;
            vel: VectorOp.vec;
            dir: direction
        }

        type physics_obj = physics_obj_constants*physics_obj_state

(*        TODO: What is the pattern to handle a create method func with that many parameters?*)
        let create ~dim ~max_acc ~max_vel ~acc_per_ms ~pos ~acc ~vel =
            let constants = {dim = dim; max_acc = max_acc; max_vel = max_vel; acc_per_ms = acc_per_ms} in
            let initialState = {pos = pos; acc = acc; vel = vel; dir = UP} in
            constants, initialState
        let get_bounding_box (constants, state) = let {pos} = state in let {dim} = constants in RectShape.create pos dim

        let accelerate (constants,state) {time_ms; delta_ms} =
            let {max_acc; acc_per_ms} = constants in
            let {acc} = state in
            let acc' = VectorOp.scalar_prod acc_per_ms delta_ms |> VectorOp.add acc |> VectorOp.min max_acc in
            constants, {state with acc = acc'}

        let decelerate (constants,state) {time_ms; delta_ms} =
            let {acc_per_ms} = constants in
            let {acc} = state in
            let acc' = VectorOp.scalar_prod acc_per_ms delta_ms |> VectorOp.sub acc |> VectorOp.max VectorOp.zero_vec in
            constants, {state with acc = acc'}

        let update_vel (constants, state : physics_obj) =
            let {max_vel} = constants in
            let {acc; vel} = state in
            let vel' = VectorOp.add vel acc |> VectorOp.min max_vel
            in constants, {state with vel = vel'}

        let get_acc (_,state : physics_obj) = let {acc} = state in acc
        let set_acc (constants,state : physics_obj) acc' = constants,{state with acc = acc'}
        let get_vel (_,state : physics_obj) = let {vel} = state in vel
(*        TODO: Implement*)
        let update physics_obj time =
            let physics_obj_velocity_updated = update_vel physics_obj
            in physics_obj_velocity_updated
    end
