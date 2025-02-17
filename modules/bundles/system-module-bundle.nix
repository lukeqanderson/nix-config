{ 
  # user defined parameters
  default-user,
  host-name,
  time-zone,
  locale,
  luks-link,
  luks-disk-link,
  ...
}: { pkgs, lib, ... }: {
  imports = [
    ../system-modules/connectivity/bluetooth-module.nix
    ../system-modules/hardware-support/xserver-module.nix
    ../system-modules/display/portal-module.nix
    ../system-modules/startup/systemd-boot-module.nix
    ../system-modules/editors/nixvim-module.nix
    ( import ../system-modules/startup/auto-login-module.nix { default-user = default-user; } )
    ( import ../system-modules/connectivity/networking-module.nix { host-name = host-name; } )
    ( import ../system-modules/locale/time-zone-module.nix { time-zone = time-zone; } )
    ( import ../system-modules/locale/locale-module.nix { locale = locale; } )
    ( import ../system-modules/hardware-support/luks-module.nix { 
        luks-link = luks-link;
	luks-disk-link = luks-disk-link;
      } 
    )
  ];
}
