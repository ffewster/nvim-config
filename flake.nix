{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    # This exposes your repo as a plain source tree
    lib = {
      path = self;
    };
  };
}
