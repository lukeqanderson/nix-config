{ 
  luks-link,
  luks-disk-link,
  ...
}: { pkgs, lib, config, ... }: {

  options = {
    luks-module.enable = 
      lib.mkEnableOption "enable xserver";
  };

  config = lib.mkIf config.luks-module.enable {
    boot = {
      initrd.luks.devices.luks-link.device = luks-disk-link;
    };
  };

}
