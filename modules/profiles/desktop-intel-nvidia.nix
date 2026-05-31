{ ... }:

{
  imports = [
    ./base.nix
    ./graphical.nix

    ../hardware/gpu/intel.nix
    ../hardware/gpu/nvidia.nix
  ];
}
