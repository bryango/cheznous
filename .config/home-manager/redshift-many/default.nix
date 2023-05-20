{ config, options, lib, pkgs, modulesPath, ... }:

with lib;

let

  baseModuleName = "redshift-many";
  xdgConfigHome = config.xdg.configHome;
  cfg = config.services.${baseModuleName};
  opts = options.services.redshift;

in

let

  instance = import ./instance.nix;

  mergeConfig = item: mkMerge (
    mapAttrsToList (
      instanceName: instanceConfig:
        getAttrFromPath item (instance {
          inherit instanceName instanceConfig xdgConfigHome;
          inherit lib pkgs modulesPath;
        })
    ) cfg
  );

in {

  config = {
    xdg.configFile = mergeConfig ["config" "xdg" "configFile"];
    # systemd = mergeConfig ["config" "systemd"];
  };

  options.services.${baseModuleName} = mkOption {
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

      ## inheriting redshift options
      options = recursiveUpdate opts {

        ## extending options
        temperature.always = mkOption {
          type = types.nullOr types.int;
          default = null;
          description = ''
            Colour temperature to use for day _and_ night, between
            <literal>1000</literal> and <literal>25000</literal> K.
          '';
        };
      };

    });
    description = ''
      The configuration for many redshift instances.
    '';
  };

}
