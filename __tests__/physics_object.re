open Jest;
open PhysicsObjectModule;
open VectorOpModule;

let dim = VectorOp.create(10.0, 5.0);
let max_acc = VectorOp.create(5.0, 50.0);
let max_vel = VectorOp.create(20.0, 200.0);
let acc_per_ms = VectorOp.create(0.02, 0.5);
let pos = VectorOp.create(0.0, 0.0);
let vel = VectorOp.create(0., 0.);
let acc = VectorOp.create(0., 0.);

let create_physics_obj = () => {
  let physics =
    PhysicsObject.create(
      ~dim,
      ~max_acc,
      ~max_vel,
      ~acc_per_ms,
      ~pos,
      ~vel,
      ~acc,
    );
  physics;
};

describe("PhysicsObject: accelerate", () => {
  open Expect;
  open! Expect.Operators;

  let test_acceleration_with_delta = (delta_ms: float) => {
    let physics_obj = create_physics_obj();
    let time_obj = {time_ms: 10000.0 +. delta_ms, delta_ms};
    let physics_obj_accelerated =
      PhysicsObject.accelerate(physics_obj, time_obj);

    let acc_after_update = PhysicsObject.get_acc(physics_obj_accelerated);
    let expected_acc =
      VectorOp.create(delta_ms, delta_ms)
      ->VectorOp.mult(acc_per_ms)
      ->VectorOp.min(max_acc);

    expect(VectorOp.eql(acc_after_update, expected_acc)) === true;
  };

  testAll(
    "Accelerate should increase the acceleration based on the time delta",
    [0.0, 2.0, 14.0, 22.0],
    test_acceleration_with_delta,
  );
});

describe("PhysicsObject: deaccelerate", () => {
  open Expect;
  open! Expect.Operators;

  let create_accelerated_obj = () => {
    let physics_obj = create_physics_obj();
    let time_obj = {time_ms: 10000.0 +. 10., delta_ms: 10.};
    let physics_obj_accelerated =
      PhysicsObject.accelerate(physics_obj, time_obj);
    physics_obj_accelerated;
  };

  let test_deceleration_with_delta = (delta_ms: float) => {
    let physics_obj = create_accelerated_obj();
    let acc_before_break = PhysicsObject.get_acc(physics_obj);

    let time_obj = {time_ms: 10000.0 +. delta_ms, delta_ms};
    let physics_obj_decelerated =
      PhysicsObject.decelerate(physics_obj, time_obj);
    let physics_obj_updated =
      PhysicsObject.update(physics_obj_decelerated, time_obj);

    let acc_after_update = PhysicsObject.get_acc(physics_obj_updated);
    let expected_acc =
      VectorOp.create(delta_ms, delta_ms)
      ->VectorOp.mult(acc_per_ms)
      ->VectorOp.sub(acc_before_break, _)
      ->VectorOp.max(VectorOp.zero_vec);

    expect((
      VectorOp.lte(acc_after_update, acc_before_break),
      VectorOp.eql(acc_after_update, expected_acc),
    ))
    == (true, true);
  };

  testAll(
    "Decelerate should decrease the acceleration based on the time delta",
    [0.0, 2.0, 14.0, 22.0],
    test_deceleration_with_delta,
  );
});
