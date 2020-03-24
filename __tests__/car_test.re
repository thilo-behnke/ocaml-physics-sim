open Jest;
open CarModule;
open PhysicsObjectModule;
open VectorOpModule;

describe("Car Testing: Acceleration", () => {
  open Expect;
  open! Expect.Operators;

  test(
    "A car should still be standing after update if it is not accelerating", () => {
    let c1 = Car.create(1, VectorOp.create(0., 0.));
    let time_obj = {time_ms: 100000.0, delta_ms: 2.0};

    let c1_updated = Car.update(c1, time_obj);

    let is_standing = Car.is_standing(c1_updated);
    expect(is_standing) === true;
  });

  test("Accelerating a car should set its state to DRIVING", () => {
    let c1 = Car.create(1, VectorOp.create(0., 0.));
    let time_obj = {time_ms: 100000.0, delta_ms: 2.0};

    let c1_accelerated = Car.accelerate(c1);
    let c1_updated = Car.update(c1_accelerated, time_obj);

    let is_driving = Car.is_driving(c1_updated);
    expect(is_driving) === true;
  });
});

describe("Car Testing: Breaking", () => {
  open Expect;
  open! Expect.Operators;

  let get_driving_car = () => {
    let c1 = Car.create(1, VectorOp.create(0., 0.));
    let time_obj = {time_ms: 100000.0, delta_ms: 2.0};

    let c1_accelerated = Car.accelerate(c1);
    let c1_updated = Car.update(c1_accelerated, time_obj);

    c1_updated;
  };

  test(
    "Driving car with acceleration = 0. should set its state to BREAKING", () => {
    let car = get_driving_car();
    let time_obj = {time_ms: 100002.0, delta_ms: 2.0};

    let c1_after_break = Car.break(car);
    let c1_updated' = Car.update(c1_after_break, time_obj);

    let is_standing = Car.is_standing(c1_updated');
    expect(is_standing) === true;
  });
});
