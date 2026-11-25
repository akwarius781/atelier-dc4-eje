#!/bin/bash
# Atelier DC4 – diffuse l'application sur le réseau local (Wi-Fi / Ethernet)
cd "$(dirname "$0")"
PORT=8080
IP=$(ipconfig getifaddr en0 2>/dev/null); [ -z "$IP" ] && IP=$(ipconfig getifaddr en1 2>/dev/null)
[ -z "$IP" ] && IP=$(ifconfig | awk '/inet / && $2!="127.0.0.1"{print $2; exit}')
clear
echo "=============================================="
echo "   ATELIER DC4 – Application en ligne"
echo "=============================================="
echo
echo "  Sur ce Mac        : http://localhost:$PORT"
echo "  Pour les étudiants: http://$IP:$PORT"
echo
echo "  (Les étudiants doivent être sur le même Wi-Fi.)"
echo "  Laissez cette fenêtre ouverte pendant l'atelier."
echo "  Pour arrêter : fermez la fenêtre ou Ctrl + C."
echo "=============================================="
( sleep 1; open "http://localhost:$PORT" ) &
if /usr/bin/xcrun --find python3 >/dev/null 2>&1 || [ -x /opt/homebrew/bin/python3 ] || [ -x /usr/local/bin/python3 ]; then
  exec python3 -m http.server $PORT --bind 0.0.0.0
elif command -v ruby >/dev/null 2>&1; then
  exec ruby -run -e httpd . -p $PORT --bind-address=0.0.0.0
else
  echo; echo "Python 3 est nécessaire. Une fenêtre va proposer de l'installer :"
  echo "acceptez, puis relancez ce fichier."; python3 --version
  read -r -p "Appuyez sur Entrée pour fermer."
fi
