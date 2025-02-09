{ 
  default-user,
  ...
}: { pkgs, lib, config, ... }: {

  options = {
    auto-login-module.enable = 
      lib.mkEnableOption "enable auto-login";
  };

  config = lib.mkIf config.auto-login-module.enable {
    services = {
      displayManager = {
        autoLogin.enable = true;
	autoLogin.user = default-user;
      };
    };
  };

}
