{ time-zone }: { pkgs, lib, config, ... }: {

  options = {
    time-zone-module.enable = 
      lib.mkEnableOption "enable timezone";
  };

  config = lib.mkIf config.time-zone-module.enable {
    time.timeZone = time-zone;
  };

}
