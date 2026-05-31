# mrgnl NixOS

Read this repository from the top down:

1. `flake.nix` defines all hosts and the formatter.
2. `host/<name>/configuration.nix` selects machine layers.
3. `modules/profiles` selects system layers.
4. `modules/*` defines system behavior.
5. `home/mrgnl.nix` selects Home Manager layers.
6. `home/profiles` selects user layers.
7. `home/programs` and `home/packages` define user tools.

Daily checks live in `docs/checks.md`. Current hosts are `t14` and `i5-5060`.
