{ pkgs }: 
  pkgs.writeShellApplication { 
    name = "animated-wallpaper"; 
    runtimeInputs = with pkgs; [
      mpvpaper
      hyprland
    ];
    text = '' 
      # kill existing animated wallpaper processes
      pkill mpvpaper &

      # gets list of monitors, checks if vertical or horizontal, sets accordingly
      monitor_name=''$(hyprctl monitors all | grep "Monitor" | awk '{print $2}')
      monitor_description=''$(hyprctl monitors all | grep "description" | grep -oP "(?<=description: ).*")

      # remove any empty lines and whitespace
      monitor_name=''$(echo "$monitor_name" | sed '/^''$/d; s/^[ ''\t]*//; s/[ ''\t]*''$//')
      monitor_description=''$(echo "$monitor_description" | sed '/^''$/d; s/^[ ''\t]*//; s/[ ''\t]*''$//')

      monitor_name_arr=()
      monitor_desc_arr=()

      while read -r line; do
        monitor_name_arr+=("''$line")
      done <<< "''$monitor_name"

      while read -r line; do
        monitor_desc_arr+=("''$line")
      done <<< "''$monitor_description"

      length=''${#monitor_name_arr[@]}

      wallpaper_path=/home/luke/Wallpapers/
      vertical_wallpaper=space.mp4
      horizontal_wallpaper=winter.mp4
      for (( i=0; i<length; i++ )); do
        if [ "''${monitor_name_arr[i]}" = "eDP-1" ]; then
	  mpvpaper -o "no-audio --loop" "''${monitor_name_arr[i]}" "''${wallpaper_path}''${horizontal_wallpaper}" &
	  sleep 0.5
	elif xrandr | grep -e "^''${monitor_name_arr[i]} " | grep -e "right (" -e "left ("; then
	  mpvpaper -o "no-audio --loop" "''${monitor_desc_arr[i]}" "''${wallpaper_path}''${vertical_wallpaper}" &
	else
	  mpvpaper -o "no-audio --loop" "''${monitor_desc_arr[i]}" "''${wallpaper_path}''${horizontal_wallpaper}" &
	fi
      done
    '';
  }
