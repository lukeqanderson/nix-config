{ pkgs }: 
  pkgs.writeShellApplication { 
    name = "startup"; 
    runtimeInputs = with pkgs; [
      toybox
      waybar
      networkmanager
      mako
    ];
    text = '' 
    echo "hello world" &
      # kill waybar process
      pkill waybar &
  
      # waybar
      waybar &
  
      # network manager applet
      nm-applet --indicator &
  
      # start wallpaper
      #/home/luke/.config/hypr/wallpaper.sh &
  
      # mako
      mako
    '';
  }
