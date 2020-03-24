open VectorOpModule
open RectModule
open PhysicsObjectModule
open MathModule
open GeneralUtils

type car_state = STANDING | ACCELERATING | DRIVING | BREAKING | DESTROYED

module type CarSig =
    sig
        type car

        val create : int -> VectorOp.vec -> car
        val update : car -> time_obj -> car
        val accelerate : car -> car
        val break : car -> car

        val get_id : car -> int
        val get_state : car -> car_state
        val get_physics : car -> PhysicsObject.physics_obj
        val is_driving : car -> bool
        val is_standing : car -> bool

        val state_to_string : car_state -> string
    end

module Car : CarSig =
    struct
        type car = {id: int; physics_obj: PhysicsObject.physics_obj; state: car_state}
        type state = car_state

        let create id initial_pos =
            let physics = PhysicsObject.create
                ~dim:(VectorOp.create 10.0 5.0)
                ~max_acc:(VectorOp.create 5.0 50.0)
                ~max_vel:(VectorOp.create 20.0 200.0)
                ~acc_per_ms:(VectorOp.create 0.02 0.5)
                ~pos:initial_pos
                ~vel:(VectorOp.create 0. 0.)
                ~acc:(VectorOp.create 0. 0.) in
            {id = id; physics_obj = physics; state = STANDING}
        let update car time_obj = let {physics_obj; state} = car in
            let physics_obj_accelerated = match state with
                | ACCELERATING -> PhysicsObject.accelerate physics_obj time_obj
                | BREAKING -> PhysicsObject.decelerate physics_obj time_obj
                | _ -> physics_obj in
            let physics_obj_updated = PhysicsObject.update physics_obj_accelerated time_obj in
            let vel = PhysicsObject.get_vel physics_obj_updated in
            let car_is_driving = VectorOp.reduce vel MathFloat.add > 0. in
            {car with state = if car_is_driving then DRIVING else STANDING}
        let accelerate car = {car with state = ACCELERATING}
        let break car = {car with state = BREAKING}
        let get_id {id} = id
        let get_state {state} = state
        let is_driving {state} = state = DRIVING
        let is_breaking {state} = state = BREAKING
        let is_standing {state} = state = STANDING

        let get_physics {physics_obj} = physics_obj

        let state_to_string = function
            | STANDING -> "STANDING"
            | DRIVING -> "DRIVING"
            | BREAKING -> "BREAKING"
            | ACCELERATING -> "ACCELERATING"
            | DESTROYED -> "DESTROYED"
    end

(*// TODO: Would it be possible to use a functor here? This would it make possible to inject the physics module instead hard coding it.*)
(*module Car = CarFunc(PhysicsObject)*)
