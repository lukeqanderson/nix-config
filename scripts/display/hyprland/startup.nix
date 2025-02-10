{ pkgs }: {
  pkgs.writeShellApplication = { 
    name = "startup" 
    runtimeInputs = with pkgs; [
      toybox
      waybar
      nm-applet
      mako
  ];
  text = '' 
    # kill waybar process
    pkill waybar &
  
    # waybar
    waybar &
  
    # network manager applet
    nm-applet --indicator &
  
    # start wallpaper
    /home/luke/.config/hypr/wallpaper.sh &
  
    # mako
    mako
    ''
  };
}
