#!/bin/sh

#-------------------------------------------------------------------
# Início lindo
#-------------------------------------------------------------------

# Cores      
# Negrito       
BRed='\033[1;31m'            #    
BPurple='\033[1;35m'          #  
BWhite='\033[1;37m' #
BYellow='\033[1;33m'    #
    
clear
echo "             ${BWhite}*     ${BYellow},MMM8&&&.            ${BWhite}*"
echo "                  ${BYellow}MMMM88&&&&&    ${BWhite}."
echo "                 ${BYellow}MMMM88&&&&&&&"
echo "     ${BWhite}*           ${BYellow}MMM88&&&&&&&&"
echo "                 ${BYellow}MMM88&&&&&&&&"
echo "                 ${BYellow}'MMM88&&&&&&'"
echo "                   ${BYellow}'MMM8&&&'      ${BWhite}*"
echo "         ${BPurple}|\___/|"
echo "         ${BPurple})     (             ${BWhite}.              '"
echo "        ${BPurple}=\     /="
echo "          ${BPurple})${BRed}===${BPurple}(       ${BWhite}*"
echo "         ${BPurple}/     \ "
echo "         ${BPurple}|     |"
echo "        ${BPurple}/       \ "
echo "        ${BPurple}\       /"
echo "${BWhite} _/\_/\_/${BPurple}\__  _/${BWhite}_/\_/\_/\_/\_/\_/\_/\_/\_/\_"
echo "${BWhite} |  |  |  |${BPurple}( (  ${BWhite}|  |  |  |  |  |  |  |  |  |"
echo "${BWhite} |  |  |  | ${BPurple}) ) ${BWhite}|  |  |  |  |  |  |  |  |  |"
echo "${BWhite} |  |  |  |${BPurple}(_(  ${BWhite}|  |  |  |  |  |  |  |  |  |"
echo "${BWhite} |  |  |  |  |  |  |  |  |  |  |  |  |  |  |"
echo "${BWhite} |  |  |  |  |  |  |  |  |  |  |  |  |  |  |"
echo
echo "${BWhite}Autora: ${BYellow}Camila Calistro Frigéri"
echo "${BWhite}Website: ${BYellow}https://camilafrigeri.web.app\e[0m"
echo

     
#-------------------------------------------------------------------
# Aqui começa o código
#-------------------------------------------------------------------

echo "${BWhite}Inicializando...\e[0m"
echo
echo "${BWhite}Fazendo update e upgrade...\e[0m"
sudo apt-get update && sudo apt-get upgrade -y
echo
echo "${BWhite}A instalação das proxychains padrão usará TOR, prosseguir? (Enter para continuar.)\e[0m"
read confirm
echo "${BWhite}Instalando TOR e iniciando o serviço...\e[0m"
# Instalando
sudo apt-get install tor
# Inicializando
service tor start
# Verificando atividade
service tor status
echo "${BWhite}Gostaria de abrir o arquivo de configuração? (Usa NANO) [Y/N]\e[0m"
read config
if [ $config = y ]; then
nano /etc/proxychains4.conf
echo "${Bwhite}Instalação concluída! use 'proxychains firefox www.example.com'\e[0m"
else
echo "${Bwhite}Instalação concluída! use 'proxychains firefox www.example.com'\e[0m"
fi
exit 0
