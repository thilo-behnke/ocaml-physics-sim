open Jest;
open EventModule;

describe("EventModule", () => {
  open Expect;
  open! Expect.Operators;

  test("Should serialize the event log correctly to a list of events", () => {
    let event1 = Event.create("hello world", 200039384.);
    let event2 = Event.create("Now doing this...", 200039390.);

    let log =
      OrderedEventLog.create()
      ->OrderedEventLog.add(event1)
      ->OrderedEventLog.add(event2);

    let output = EventLogOutput.serialize(log);
    let expected = "[200039390]: Now doing this...\n[200039384]: hello world";

    expect(expected) === output;
  });
});
