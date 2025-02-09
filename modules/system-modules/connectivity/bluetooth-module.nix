{ pkgs, lib, config, ... }: {

  options = {
    bluetooth-module.enable = 
      lib.mkEnableOption "enable bluetooth";
  };

  config = lib.mkIf config.bluetooth-module.enable {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

    services = {
      blueman = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      bluez
      bluez-tools
    ];

  };

}
