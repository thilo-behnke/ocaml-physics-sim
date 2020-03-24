open Asttypes
open Parsetree
open Ast_mapper
let test_mapper argv =
  {
    default_mapper with
    expr =
      (fun mapper ->
         fun expr ->
           match expr with
           | {
               pexp_desc = ((Pexp_extension
                 ({ txt = "test" }, pstr)))
               } ->
               Ast_helper.Exp.constant (Pconst_string ("1", None))
           | other -> default_mapper.expr mapper other)
  }
let () = register "ppx_test" test_mapper
