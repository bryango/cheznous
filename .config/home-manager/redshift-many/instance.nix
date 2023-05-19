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

  options.services.${moduleName} = options.services.redshift;
  config = mkIf (cfg != {}) commonOptions.config; #redshiftConfig;

}
