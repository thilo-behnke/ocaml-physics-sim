open Jest;
open MathModule;

describe("MathFloat", () => {
  open Expect;
  open! Expect.Operators;

  test("Divide", () => {
    let f1 = 50.;
    let f2 = 10.;

    let res = MathFloat.div(f1, f2);

    expect(res) === 5.;
  });
});
