{ config, lib, ... }:

with lib;

let

  baseModule = "redshift-many";
  mainSection = "redshift";

  instanceConfigs = config.services.${baseModule};
  instanceNames = attrNames instanceConfigs;

in {

  imports = map (import ./instance.nix baseModule mainSection) instanceNames;

  options.services.${baseModule} = mkOption {
    default = { };
    example = literalExpression ''
      {
        internal = {
          temperature.day = 3200;
          temperature.night = 3200;
          settings.randr.crtc = 0;
        };
      };
    '';
    type = with types; attrsOf (submodule {

      ## extending redshift options
      options = options.services.redshift;
    });
    description = ''
      The configuration for many redshift instances.
    '';
  };

}
