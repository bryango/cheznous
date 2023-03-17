{
  packageOverrides = pkgs: with pkgs; {
    gimp-with-plugins = gimp-with-plugins.override {
      plugins = with gimpPlugins; [ resynthesizer ];
    };
    gimp = gimp.override {
      withPython = true;
    };
  };
}
