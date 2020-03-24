open ListExtModule

type message = string
type timestamp_ms = float

module type EventSig =
    sig
        type event

        val create: message -> timestamp_ms -> event
        val serialize: event -> string
    end

module Event : EventSig =
    struct
        type event = {message: message; timestamp_ms: timestamp_ms}

        let create m ts_ms = {message = m; timestamp_ms = ts_ms}
        let serialize {message; timestamp_ms} = "[" ^ (int_of_float timestamp_ms |> string_of_int) ^ "]: " ^ message
    end

module type EventLogSig =
    sig
        type event_log

        val create: unit -> event_log
        val add: event_log -> Event.event -> event_log
        val get_newest: event_log -> int -> event_log
        val map: (Event.event -> 'a) -> event_log -> 'a list
        val fold_left: ('a -> Event.event -> 'a) -> 'a -> event_log -> 'a
    end

module OrderedEventLog : EventLogSig =
    struct
        type event_log = Event.event list

        let create () = []
        let add log e = e::log
        let get_newest log n = ListExt.take log n
        let map f event_log = List.map f event_log
        let fold_left f acc event_log = List.fold_left f acc event_log
    end


module EventLogOutputFunc(M: EventLogSig) =
    struct
        let serialize (event_log: M.event_log) =
            let fold_log acc event =
                let event_serialized = Event.serialize event in
                let acc' = (match acc with | "" -> "" | _ ->  acc ^ "\n") in
                acc' ^ event_serialized
            in M.fold_left fold_log "" event_log
    end

module EventLogOutput = EventLogOutputFunc(OrderedEventLog)
