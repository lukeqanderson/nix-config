{ pkgs, lib, config, ... }: {

  options = {
    systemd-boot-module.enable = 
      lib.mkEnableOption "enable systemd boot";
  };

  config = lib.mkIf config.systemd-boot-module.enable {
    boot.loader.systemd-boot.enable = true;
  };

}
