choice=$(echo -e "   Lock\n   Logout\n󰤄   Suspend\n   Reboot\n   Shut down" | rofi -dmenu)
case $choice in
  "   Lock")
    hyprlock
  ;;
  
  "   Logout")
    kill -9 -1
  ;;

  "󰤄   Suspend")
    systemctl suspend
  ;;

  "   Reboot")
    systemctl reboot
  ;;

  "   Shut down")
    systemctl poweroff
  ;;
esac
