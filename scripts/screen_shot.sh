choice=$(echo -e "   Whole screen\n   Select window\n   Select region" | rofi -dmenu)

case $choice in
  "   Whole screen")
    hyprshot -m output -o ~/Pictures/Screenshots/
  ;;
  
  "   Select window")
    hyprshot -m window -o ~/Pictures/Screenshots/
  ;;

  "   Select region")
    hyprshot -m region -o ~/Pictures/Screenshots/
  ;;
esac
