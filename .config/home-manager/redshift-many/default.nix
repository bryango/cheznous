# { config, lib, pkgs, modulesPath, ... }:
{ config, lib, ... }:
# { lib, ... }:

with lib;

let

  baseModule = "redshift-many";

  ## default config
  mainSection = "redshift";
  userDefaults = {
    enable = true;
    settings.${mainSection} = {
      adjustment-method = "randr";
    };
  };

  instanceConfigs = config.services.${baseModule};
  instanceNames = attrNames instanceConfigs;

in {

  imports = map (import ./instance.nix baseModule mainSection) instanceNames;

  options.services.${baseModule} = mkOption {
    default = { };
    example = literalExpression ''
      {
        internal = {
          temperature.always = 3200;
          settings.randr.crtc = 0;
        };
      };
    '';
    type = with types; attrsOf (submodule {

      ## extending redshift options
      options = recursiveUpdate options.services.redshift {

        temperature.always = mkOption {
          type = types.nullOr types.int;
          default = null;
          description = ''
            Colour temperature to use for day _and_ night, between
            <literal>1000</literal> and <literal>25000</literal> K.
          '';
        };

        settings.default = userDefaults.settings;
        enable.default = userDefaults.enable;

      };
    });
    description = ''
      The configuration for many redshift instances.
    '';
  };

}
