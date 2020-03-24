open Jest;
open LineModule;
open VectorOpModule;
open GeneralUtils;

describe("Shapes testing: Line -> is point on line", () => {
  open Expect;
  open! Expect.Operators;

  test("Should detect that a point is on the line", () => {
    let line_start = VectorOp.create(0., 0.);
    let line_end = VectorOp.create(5., 0.);
    let line = Line.create(line_start, line_end);
    let point = VectorOp.create(2., 0.);

    let res = Line.is_point_in_shape(line, point);

    expect(res) === true;
  });

  test("Should detect that a point is not on the line", () => {
    let line_start = VectorOp.create(0., 0.);
    let line_end = VectorOp.create(5., 0.);
    let line = Line.create(line_start, line_end);
    let point = VectorOp.create(2., 4.);

    let res = Line.is_point_in_shape(line, point);

    expect(res) === false;
  });
});

describe("Shapes testing: Line -> where is point to line", () => {
  open Expect;
  open! Expect.Operators;

  test("Should detect that a point is above a line", () => {
    // Horizontal line, no slope
    let line_start = VectorOp.create(0., 0.);
    let line_end = VectorOp.create(5., 0.);
    let line = Line.create(line_start, line_end);

    let point = VectorOp.create(2., 5.);

    let res = Line.where_is_point_to_shape(line, point, VERTICAL);

    expect(res) === UP;
  });

  test("Should detect that a point is below a line", () => {
    // Horizontal line, no slope
    let line_start = VectorOp.create(0., 0.);
    let line_end = VectorOp.create(5., 0.);
    let line = Line.create(line_start, line_end);

    let point = VectorOp.create(4., -5.);

    let res = Line.where_is_point_to_shape(line, point, VERTICAL);

    expect(res) === DOWN;
  });

  test("Should detect that a point is left of a line", () => {
    // Vertical line, no slope
    let line_start = VectorOp.create(0., 9.);
    let line_end = VectorOp.create(0., 4.);
    let line = Line.create(line_start, line_end);

    let point = VectorOp.create(-8., 7.);

    let res = Line.where_is_point_to_shape(line, point, HORIZONTAL);

    expect(res) === LEFT;
  });

  test("Should detect that a point is right of a line", () => {
    // Vertical line, no slope
    let line_start = VectorOp.create(0., 9.);
    let line_end = VectorOp.create(0., 4.);
    let line = Line.create(line_start, line_end);

    let point = VectorOp.create(8., 7.);

    let res = Line.where_is_point_to_shape(line, point, HORIZONTAL);

    expect(res) === RIGHT;
  });
  // TODO: This does not work with the current implementation.
  //  test("Should detect that a point is below + right of a diagonal line", () => {
  //    // f(x) = 5x
  //    let line_start = VectorOp.create(0., 0.);
  //    let line_end = VectorOp.create(1., 5.);
  //    let line = Line.create(line_start, line_end);
  //
  //    let point = VectorOp.create(2., 2.);
  //
  //    let ver = Line.where_is_point_to_shape(line, point, VERTICAL);
  //    let hor = Line.where_is_point_to_shape(line, point, HORIZONTAL);
  //
  //    expect((ver, hor)) == (DOWN, RIGHT);
  //  });
});

describe("Shapes testing: Line -> detect parallel lines", () => {
  open Expect;
  open! Expect.Operators;

  test("Should detect that 2 horizontal lines are parallel", () => {
    let line_start = VectorOp.create(0., 0.);
    let line_end = VectorOp.create(5., 0.);
    let line = Line.create(line_start, line_end);

    let line_start2 = VectorOp.create(10., 0.);
    let line_end2 = VectorOp.create(15., 0.);
    let line2 = Line.create(line_start2, line_end2);

    let res = Line.are_parallel(line, line2);

    expect(res) === true;
  });

  test("Should detect that 2 sloped lines are parallel", () => {
    let line_start = VectorOp.create(0., 2.);
    let line_end = VectorOp.create(5., 12.);
    let line = Line.create(line_start, line_end);

    let line_start2 = VectorOp.create(10., 2.);
    let line_end2 = VectorOp.create(15., 12.);
    let line2 = Line.create(line_start2, line_end2);

    let res = Line.are_parallel(line, line2);

    expect(res) === true;
  });

  test("Should detect that 2 sloped lines are not parallel", () => {
    let line_start = VectorOp.create(0., 3.);
    let line_end = VectorOp.create(5., 22.);
    let line = Line.create(line_start, line_end);

    let line_start2 = VectorOp.create(10., 2.);
    let line_end2 = VectorOp.create(15., 12.);
    let line2 = Line.create(line_start2, line_end2);

    let res = Line.are_parallel(line, line2);

    expect(res) === false;
  });
});
