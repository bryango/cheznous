## adapted from `redshift.nix`

baseModule: mainSection: instance:

## ^^^ given `instance`
## ... generate a module for `imports`

{ config, lib, pkgs, modulesPath, ... }:

with lib;

let
  ## input config:
  cfg = config.services.${baseModule}.${instance};

  ## output config:
  moduleName = "${baseModule}-${instance}";
in

let

  ## pre-process `temperature.always`
  config.services.${moduleName} =
    if cfg.temperature ? always
    then recursiveUpdate cfg {

      ## same temp for day and night
      temperature = with cfg.temperature; {
        day = always;
        night = always;
      };

      ## required, but doesn't matter
      ## ... so just take Beijing:
      longitude = "116.4";
      latitude = "39.9";

      ## no need to fade
      settings.redshift.fade = 0;

    } else cfg;

  optionsInputs = {
    inherit config lib pkgs;
    inherit moduleName mainSection;

    programName = "Redshift";
    defaultPackage = pkgs.redshift;
    examplePackage = "pkgs.redshift";
    mainExecutable = "redshift";
    appletExecutable = "redshift-gtk";
    xdgConfigFilePath = "redshift/${instance}.conf";
    serviceDocumentation = "http://jonls.dk/redshift/";
  };

  commonOptions = import (
    modulesPath + "/services/redshift-gammastep/lib/options.nix"
  ) optionsInputs;

in {
  # inherit (commonOptions) imports;

  options.services.${moduleName} = options.services.redshift;

  config =
    let
      ## no systemd service
      redshiftConfig = builtins.removeAttrs commonOptions.config [ "systemd" ];
    in
      mkIf (cfg != {}) redshiftConfig;

}
