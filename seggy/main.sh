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

echo "${BWhite}Bem vindo(a)! Qual configuração gostaria de aplicar?\e[0m"
echo "${BRed} [1] Firewall\e[0m"
echo "${BRed} [2] Proxychains\e[0m"
echo "${BRed} [3] Gerador de senhas\e[0m" 
read opt
if [ $opt = 1 ]; then
echo "${BWhite}Inicializando o firewall...\e[0m"
cd itens
chmod +x *
sudo ./firewall.sh
elif [ $opt = 2 ]; then
echo "${BWhite}Inicializando proxychains...\e[0m"
cd itens
chmod +x *
sudo ./proxychains.sh
elif [ $opt = 3 ]; then
cd itens
chmod +x *
sudo bash senhas.sh
else
echo "${BWhite}Opção inválida.\e[0m"
fi
exit 0
