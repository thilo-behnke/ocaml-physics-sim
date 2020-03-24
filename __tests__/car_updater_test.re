open Jest;
open CarUpdateModule;
open CarModule;
open VectorOpModule;

describe("CarUpdaterTest", () => {
  open Expect;
  open! Expect.Operators;

  test("Should detect car state changes", () => {
    let standing_car = Car.create(_, VectorOp.zero_vec);

    let accelerating_car =
      VectorOp.zero_vec->Car.create(2, _)->Car.accelerate;

    let cars_prev = [standing_car(1), standing_car(2), standing_car(3)];
    let cars_new = [standing_car(1), accelerating_car, standing_car(3)];

    let state_updates =
      CarUpdate.extract_car_state_updates(cars_prev, cars_new);
    let update_1 = List.hd(state_updates);
    let (state_prev, state_new) = CarUpdate.get_state_update(update_1);
    let car = CarUpdate.get_car(update_1);

    expect((List.length(state_updates), car, state_prev, state_new))
    == (1, accelerating_car, STANDING, ACCELERATING);
  });

  test("Should detect no car state changes if none exists", () => {
    let standing_car = Car.create(_, VectorOp.zero_vec);

    let cars_prev = [standing_car(1), standing_car(2), standing_car(3)];
    let cars_new = [standing_car(1), standing_car(2), standing_car(3)];

    let state_updates =
      CarUpdate.extract_car_state_updates(cars_prev, cars_new);

    expect(List.length(state_updates)) == 0;
  });
});
