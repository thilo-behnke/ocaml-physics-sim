open Jest;
open RectModule;
open VectorOpModule;

describe("Shapes testing: Rect", () => {
  open Expect;
  open! Expect.Operators;

  test("Should get corners", () => {
    let rect =
      RectShape.create(VectorOp.create(0., 0.), VectorOp.create(5., 10.));

    let {top_left, top_right, bottom_left, bottom_right} =
      RectShape.get_boundary(rect);
    let top_left_expected = VectorOp.create(0., 0.);
    let top_right_expected = VectorOp.create(5., 0.);
    let bottom_left_expected = VectorOp.create(0., -10.);
    let bottom_right_expected = VectorOp.create(-5., -10.);

    /*    Wow...*/
    expect((
      VectorOp.eql(top_left, top_left_expected),
      VectorOp.eql(top_right, top_right_expected),
      VectorOp.eql(bottom_left, bottom_left_expected),
      VectorOp.eql(bottom_right, bottom_right_expected),
    ))
    == (true, true, true, true);
  });

  test("Should detect that a point on the boundary is not within the rect", () => {
    let rect =
      RectShape.create(VectorOp.create(0., 0.), VectorOp.create(5., 10.));
    let point = VectorOp.create(0., -1.);

    let res = RectShape.is_point_in_shape(rect, point);

    expect(res) === false;
  });

  test("Should detect that a point inside the boundary is in the rect", () => {
    let rect =
      RectShape.create(VectorOp.create(0., 0.), VectorOp.create(5., 10.));
    let point = VectorOp.create(-5., -1.);

    let res = RectShape.is_point_in_shape(rect, point);

    expect(res) === true;
  });

  test("Should detect an overlap if both rects are the same", () => {
    let rect1 =
      RectShape.create(VectorOp.create(0., 0.), VectorOp.create(5., 10.));
    let rect2 =
      RectShape.create(VectorOp.create(0., 0.), VectorOp.create(5., 10.));

    let res = RectShape.overlap(rect1, rect2);
    expect(res) === true;
  });

  test("Should detect no overlap if rects are not overlapping", () => {
    let rect1 =
      RectShape.create(VectorOp.create(0., 0.), VectorOp.create(5., 10.));
    let rect2 =
      RectShape.create(VectorOp.create(40., 20.), VectorOp.create(1., 1.));

    let res = RectShape.overlap(rect1, rect2);
    expect(res) === false;
  });

  test("Should detect the overlap if rects are overlapping", () => {
    let rect1 =
      RectShape.create(VectorOp.create(0., 0.), VectorOp.create(5., 10.));
    let rect2 =
      RectShape.create(VectorOp.create(1., -2.), VectorOp.create(3., 3.));

    let res = RectShape.overlap(rect1, rect2);
    expect(res) === true;
  });
});
