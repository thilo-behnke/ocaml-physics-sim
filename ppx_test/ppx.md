### Create PPX (dev workflow)

Generate pxx:
```
ocamlc -o ppx -I +compiler-libs ocamlcommon.cma -impl ppx_test/ppx_test.ml
```

Move folder to node_modules:
```
mv ppx_test ./node_modules
```

