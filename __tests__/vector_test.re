open Jest;
open VectorOpModule;

describe("Dot product", () => {
  open Expect;
  open! Expect.Operators;

  test("Calculate vector dot product correctly (1)", () => {
    let v1 = VectorOp.create(10., 5.);
    let v2 = VectorOp.create(5., 3.);

    let res = VectorOp.dot(v1, v2);

    expect(res) === 65.;
  });
  test("Calculate vector dot product correctly (2)", () => {
    let v1 = VectorOp.create(10., -5.);
    let v2 = VectorOp.create(-2., 3.);

    let res = VectorOp.dot(v1, v2);

    expect(res) === (-35.);
  });
  test("Calculate vector dot product correctly (3)", () => {
    let v1 = VectorOp.create(10., -5.);
    let v2 = VectorOp.create(2., 4.);

    let res = VectorOp.dot(v1, v2);

    expect(res) === 0.;
  });
});

describe("length", () => {
  open Expect;
  open! Expect.Operators;

  test("Calculate vector length (1)", () => {
    let v = VectorOp.create(3., 4.);

    let res = VectorOp.len(v);

    expect(res) === 5.;
  });

  test("Calculate vector length (2)", () => {
    let v = VectorOp.create(3., 0.);

    let res = VectorOp.len(v);

    expect(res) === 3.;
  });
});

describe("Get angle", () => {
  open Expect;
  open! Expect.Operators;

  test("Get angle between the same vector should be 0", () => {
    let v1 = VectorOp.create(3., 4.);
    let v2 = VectorOp.create(3., 4.);

    let res = VectorOp.get_angle(v1, v2);

    expect(res) === 0.;
  });

  test("Get angle between the opposite vectors should be pi", () => {
    let v1 = VectorOp.create(3., 4.);
    let v2 = VectorOp.create(-3., -4.);

    let res = VectorOp.get_angle(v1, v2);

    let pi = acos(-1.);

    expect(res) === pi;
  });

  test("Get angle between the orthogonal vectors should be pi/2", () => {
    let v1 = VectorOp.create(1., 1.);
    let v2 = VectorOp.create(-1., 1.);

    let res = VectorOp.get_angle(v1, v2);

    let pi = acos(-1.);

    expect(res) === pi /. 2.;
  });
});

describe("Normalize", () => {
  open Expect;
  open! Expect.Operators;

  test("Normalize vector correctly", () => {
    let v = VectorOp.create(3., 4.);

    let res = VectorOp.norm(v);
    let expected = VectorOp.create(3. /. 5., 4. /. 5.);

    expect(VectorOp.eql(res, expected)) === true;
  });

  test("Normalize unity vector correctly", () => {
    let v = VectorOp.create(1., 1.);

    let res = VectorOp.norm(v);
    let expected =
      VectorOp.create(sqrt(2.) |> (/.)(1.), sqrt(2.) |> (/.)(1.));

    expect(VectorOp.eql(res, expected)) === true;
  });
});

describe("Get single comp", () => {
  open Expect;
  open! Expect.Operators;

  test("Get the x comp correctly", () => {
    let v = VectorOp.create(3., 4.);

    let res = VectorOp.get_x_vec(v);
    let expected = VectorOp.create(3., 0.);

    expect(VectorOp.eql(res, expected)) === true;
  });

  test("Get the y comp correctly", () => {
    let v = VectorOp.create(3., 4.);

    let res = VectorOp.get_y_vec(v);
    let expected = VectorOp.create(0., 4.);

    expect(VectorOp.eql(res, expected)) === true;
  });
});

describe("Get distance", () => {
  open Expect;
  open! Expect.Operators;

  test("Get the distance between two vectors", () => {
    let v1 = VectorOp.create(3., 4.);
    let v2 = VectorOp.create(9., 1.);

    let res = VectorOp.distance(v1, v2);
    let expected = 6.708203932499369;

    expect(res) === expected;
  });

  test("Get the y comp correctly", () => {
    let v = VectorOp.create(3., 4.);

    let res = VectorOp.get_y_vec(v);
    let expected = VectorOp.create(0., 4.);

    expect(VectorOp.eql(res, expected)) === true;
  });
});
