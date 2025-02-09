{ host-name }: { pkgs, lib, config, ... }: {

  options = {
    networking-module.enable = 
      lib.mkEnableOption "enable networking";
  };

  config = lib.mkIf config.networking-module.enable {
    networking = {
      hostName = host-name;
      networkmanager = {
        enable = true;
      };
      firewall = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      networkmanager
      networkmanagerapplet
    ];

  };
}
