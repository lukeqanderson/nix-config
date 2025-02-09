{ pkgs, lib, config, ... }: {

  options = {
    xserver-module.enable = 
      lib.mkEnableOption "enable xserver";
  };

  config = lib.mkIf config.xserver-module.enable {
    services = {
      xserver = {
        enable = true;
	xkb.layout = "us";
	xkb.variant = "";
	excludePackages = [ pkgs.xterm ];
	videoDrivers = [ "displaylink" "modesetting" ];
	displayManager.gdm = {
          enable = true;
	  wayland = true;
	};
      };
    };
  };

}
