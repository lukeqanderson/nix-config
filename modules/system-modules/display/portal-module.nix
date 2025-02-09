{ pkgs, lib, config, ... }: {

  options = {
    portal-module.enable = 
      lib.mkEnableOption "enable portal modules";
  };

  config = lib.mkIf config.portal-module.enable {
    xdg = {
      autostart.enable = true;
      portal = {
        enable = true;
	extraPortals = [
          pkgs.xdg-desktop-portal
	  pkgs.xdg-desktop-portal-gtk
	];
      };
    };
  };

}
