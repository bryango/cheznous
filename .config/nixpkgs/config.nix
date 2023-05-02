{
  packageOverrides = pkgs: with pkgs; {

    # specify user mods
    gimp-with-plugins = gimp-with-plugins.override {
      plugins = with gimpPlugins; [ resynthesizer ];
    };
    gimp = gimp.override {
      withPython = true;
    };

    # declare user packages
    userPackages = buildEnv {
      name = "user-packages";
      paths = [
        nix-tree
        nixfmt
        gimp-with-plugins
        circumflex  # Hacker News terminal
      ];
    };
    # ... this doesn't work with `nix-env -ibA`
    # ... i.e. no binary cache for now...
  };

  allowUnfree = true;
  # allowBroken = true;

  permittedInsecurePackages = [
    "python-2.7.18.6"
    "python-2.7.18.6-env"
  ];
}
