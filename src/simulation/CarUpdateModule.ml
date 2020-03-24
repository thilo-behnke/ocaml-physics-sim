open CarModule
open EventModule
open PhysicsObjectModule

module type CarUpdateSig =
    sig
        type car_update

        val get_car: car_update -> Car.car
        val get_state_update: car_update -> car_state*car_state

        val extract_car_state_updates: Car.car list -> Car.car list -> car_update list

        val serialize: car_update -> time_obj -> Event.event
    end

module CarUpdate : CarUpdateSig =
    struct
        type car_update = {car: Car.car; prev_state: car_state; new_state: car_state}

        let get_car {car} = car
        let get_state_update {prev_state; new_state} = prev_state,new_state
        let extract_car_state_updates cars_prev cars_new =
            let rec inner acc = function
                | car_prev::rest_cars_prev, car_new::rest_cars_new ->
                    let prev_state = Car.get_state car_prev in
                    let new_state = Car.get_state car_new in
                    let acc' = (
                        match prev_state != new_state with
                        | true -> {car = car_new; prev_state = prev_state; new_state = new_state}::acc
                        | false -> acc
                    )
                     in inner acc' (rest_cars_prev, rest_cars_new)
                | _,_ -> acc
            in inner [] (cars_prev, cars_new)
        let serialize {car; prev_state; new_state} {time_ms} =
            let message = "State of car with id " ^ (Car.get_id car |> string_of_int) ^ " has updated its state: " ^ (Car.state_to_string prev_state) ^ " -> " ^ (Car.state_to_string new_state) in
            Event.create message time_ms
    end

