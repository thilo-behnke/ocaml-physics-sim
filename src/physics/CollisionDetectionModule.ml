open CarModule
open RectModule
open PhysicsObjectModule
open GeneralUtils

module type CollisionDetection =
    sig
        type car
        val handle_collision : car -> car -> (car*car)
        val are_colliding: car -> car -> bool
        val get_collision_direction: car -> car -> direction
    end

(*TODO: This should just work with physics objects, cars are not relevant here...*)
module CollisionDetectionImpl : CollisionDetection with type car = Car.car =
    struct
        type car = Car.car
        let handle_collision (c1: car) (c2: car) =
            let car1_rect = Car.get_physics c1 |> PhysicsObject.get_bounding_box in let car2_rect = Car.get_physics c2 |> PhysicsObject.get_bounding_box in c1, c2
        let are_colliding (c1: car) (c2: car) =
            let car1_rect = Car.get_physics c1 |> PhysicsObject.get_bounding_box in
            let car2_rect = Car.get_physics c2 |> PhysicsObject.get_bounding_box in
            RectShape.overlap car1_rect car2_rect
        let get_collision_direction car1 car2 = NONE
    end



