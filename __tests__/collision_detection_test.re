open Jest;
open CollisionDetectionModule;
open CarModule;
open VectorOpModule;

describe("CollisionDetection Testing", () => {
  open Expect;
  open! Expect.Operators;

  test("Should detect a collision of 2 cars on same positions", () => {
    let c1 = Car.create(1, VectorOp.zero_vec);
    let c2 = Car.create(2, VectorOp.zero_vec);

    let res = CollisionDetectionImpl.are_colliding(c1, c2);

    expect(res) === true;
  });

  test("Should detect a collision of 2 cars on different positions", () => {
    let c1 = Car.create(1, VectorOp.zero_vec);
    let c2 = Car.create(2, VectorOp.zero_vec);

    let res = CollisionDetectionImpl.are_colliding(c1, c2);

    expect(res) === true;
  });
});
