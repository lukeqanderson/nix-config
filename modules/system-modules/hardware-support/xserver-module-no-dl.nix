{ pkgs, lib, config, ... }: {

  options = {
    xserver-module-no-dl.enable = 
      lib.mkEnableOption "enable xserver without display link";
  };

  config = lib.mkIf config.xserver-module-no-dl.enable {
    services = {
      xserver = {
        enable = true;
	xkb.layout = "us";
	xkb.variant = "";
	excludePackages = [ pkgs.xterm ];
	videoDrivers = [ "modesetting" ];
	displayManager.gdm = {
          enable = true;
	  wayland = true;
	};
      };
    };
  };

}
