open Jest;
open ListExtModule;

describe("ListExtModule", () => {
  open Expect;
  open! Expect.Operators;

  test("Should take the first n elements of a list as specified.", () => {
    let list = [4, 5, 2, 66, 2];

    let sub_list = ListExt.take(list, 2);
    let expected = [4, 5];

    expect(sub_list) == expected;
  });
});
