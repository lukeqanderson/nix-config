{ pkgs, lib, inputs, config, nixvimLib, ... }: {

  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];
  options = {
    nixvim-module.enable = 
      lib.mkEnableOption "enable nixvim modules";
  };

  config = lib.mkIf config.nixvim-module.enable {
    programs.nixvim = {
      enable = true;
      colorschemes.gruvbox.enable = true;
    };
  };

}
