open EventModule
open CarModule
open PhysicsObjectModule
open CarUpdateModule

module type SimulationHandlerSig =
   sig
      type sim_data

      val initialize: unit -> sim_data
      val update: sim_data -> time_obj -> sim_data

      val add_car: sim_data -> Car.car -> sim_data
   end

module SimulationHandlerFunc (E: EventLogSig) (CU: CarUpdateSig) : SimulationHandlerSig =
    struct
        include CU

        type sim_data = {event_log: E.event_log; cars: Car.car list; loop_i: int; last_update_timestamp_ms: float}

        let initialize () = {event_log = E.create (); cars = []; loop_i = 0; last_update_timestamp_ms = 0.}

        let detect_car_state_updates sim_data_prev sim_data_new : car_update list =
            let {cars = cars_prev} = sim_data_prev in
            let {cars = cars_new} = sim_data_new
            in CU.extract_car_state_updates cars_prev cars_new

(*        TODO: Write a test for this function!*)
        let update sim_data time_obj =
            let {event_log; cars; loop_i; last_update_timestamp_ms} = sim_data in
            let cars' = List.map (fun car -> Car.update car time_obj) cars in
            let sim_data' = {sim_data with cars = cars'} in
            let car_state_updates = detect_car_state_updates sim_data sim_data' in
            let car_state_update_event_logs = List.map (fun state_update -> CU.serialize state_update time_obj) car_state_updates in
            let event_log' = List.fold_left E.add event_log car_state_update_event_logs in
            {sim_data' with event_log = event_log'}

(*        TODO: Cars should be identifiable, e.g. by id*)
        let add_car sim_data car = let {cars} = sim_data in let cars' = cars@[car] in {sim_data with cars = cars'}
    end

module SimulationHandler = SimulationHandlerFunc(OrderedEventLog)(CarUpdate)
