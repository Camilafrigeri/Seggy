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
echo "${BWhite}Instalando UFW...\e[0m"
sudo apt-get install ufw
sudo ufw enable
echo
echo "${BWhite}Verificando status...\e[0m"
sudo ufw status
echo
# Para debugging use iptables -v.
IPTABLES="/sbin/iptables"
IP6TABLES="/sbin/ip6tables"
MODPROBE="/sbin/modprobe"
RMMOD="/sbin/rmmod"
ARP="/usr/sbin/arp"
SSHPORT="22"
# Opções de logging.
LOG="LOG --log-level debug --log-tcp-sequence --log-tcp-options"
LOG="$LOG --log-ip-options"
# Padrões para limitação.
RLIMIT="-m limit --limit 3/s --limit-burst 8"
# Ports sem privilégios.
PHIGH="1024:65535"
PSSH="1000:1023"
# Carrega os módulos necessários do kernel.
"$MODPROBE" ip_conntrack_ftp
"$MODPROBE" ip_conntrack_irc
# Configurações de kernel.
# Desativa IP forwarding.
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/ip_forward
# Ativa proteção contra IP Spoofing.
for i in /proc/sys/net/ipv4/conf/*/rp_filter; do echo 1 > "$i"; done
# Protege contra ataques SYN Flood.
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
# Ignora todas as solicitações de echo ICMP recebidas.
echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_all
# Ignora as solicitações de echo ICMP para transmitir.
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
# Registra pacotes com endereços impossíveis.
for i in /proc/sys/net/ipv4/conf/*/log_martians; do echo 1 > "$i"; done
# Não registra respostas inválidas para transmissão.
echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses
# Não aceita nem envie redirecionamentos ICMP.
for i in /proc/sys/net/ipv4/conf/*/accept_redirects; do echo 0 > "$i"; done
for i in /proc/sys/net/ipv4/conf/*/send_redirects; do echo 0 > "$i"; done
for i in /proc/sys/net/ipv4/conf/*/accept_source_route; do echo 0 > "$i"; done
# Desabilita roteamento multicast.
for i in /proc/sys/net/ipv4/conf/*/mc_forwarding; do echo 0 > "$i"; done
# Desativa proxy_arp.
for i in /proc/sys/net/ipv4/conf/*/proxy_arp; do echo 0 > "$i"; done
# Habilita redirecionamentos seguros, ou seja, aceita apenas redirecionamentos ICMP para gateways.
# Ajuda contra ataques MITM.
for i in /proc/sys/net/ipv4/conf/*/secure_redirects; do echo 1 > "$i"; done
# Desabilita bootp_relay
for i in /proc/sys/net/ipv4/conf/*/bootp_relay; do echo 0 > "$i"; done
# Políticas default.
# Derruba tudo por default.
"$IPTABLES" -P INPUT DROP
"$IPTABLES" -P FORWARD DROP
"$IPTABLES" -P OUTPUT DROP
# Define as cadeias das tabelas nat/mangle/raw como ACCEPT
# Nat
"$IPTABLES" -t nat -P PREROUTING ACCEPT
"$IPTABLES" -t nat -P OUTPUT ACCEPT
"$IPTABLES" -t nat -P POSTROUTING ACCEPT
# Mangle
"$IPTABLES" -t mangle -P PREROUTING ACCEPT
"$IPTABLES" -t mangle -P INPUT ACCEPT
"$IPTABLES" -t mangle -P FORWARD ACCEPT
"$IPTABLES" -t mangle -P OUTPUT ACCEPT
"$IPTABLES" -t mangle -P POSTROUTING ACCEPT
# Limpeza.
# Deleta tudo.
"$IPTABLES" -F
"$IPTABLES" -t nat -F
"$IPTABLES" -t mangle -F
"$IPTABLES" -X
"$IPTABLES" -t nat -X
"$IPTABLES" -t mangle -X
# Zera todos os pacotes e contadores.
"$IPTABLES" -Z
"$IPTABLES" -t nat -Z
"$IPTABLES" -t mangle -Z
# Desabilita completamente IPv6.
# Bloqueia todo o tráfego IPv6.
# Se o comando ip6tables estiver disponível, tenta bloquear todo o tráfego IPv6.
if test -x "$IP6TABLES"; then
# Define as políticas padrão.
# Derruba tudo.
"$IP6TABLES" -P INPUT DROP 2>/dev/null
"$IP6TABLES" -P FORWARD DROP 2>/dev/null
"$IP6TABLES" -P OUTPUT DROP 2>/dev/null
# A tabela mangle pode passar tudo.
"$IP6TABLES" -t mangle -P PREROUTING ACCEPT 2>/dev/null
"$IP6TABLES" -t mangle -P INPUT ACCEPT 2>/dev/null
"$IP6TABLES" -t mangle -P FORWARD ACCEPT 2>/dev/null
"$IP6TABLES" -t mangle -P OUTPUT ACCEPT 2>/dev/null
"$IP6TABLES" -t mangle -P POSTROUTING ACCEPT 2>/dev/null
# Apaga todas as regras.
"$IP6TABLES" -F 2>/dev/null
"$IP6TABLES" -t mangle -F 2>/dev/null
# Apaga todas as correntes.
"$IP6TABLES" -X 2>/dev/null
"$IP6TABLES" -t mangle -X 2>/dev/null
# Zera todos os pacotes e contadores.
"$IP6TABLES" -Z 2>/dev/null
"$IP6TABLES" -t mangle -Z 2>/dev/null
fi
# Correntes costumizadas definidas pelo usuário.
# Registra os pacotes, depois ACCEPT.
"$IPTABLES" -N ACCEPTLOG
"$IPTABLES" -A ACCEPTLOG -j "$LOG" "$RLIMIT" --log-prefix "ACCEPT "
"$IPTABLES" -A ACCEPTLOG -j ACCEPT
# Registra os pacotes, depois DROP.
"$IPTABLES" -N DROPLOG
"$IPTABLES" -A DROPLOG -j "$LOG" "$RLIMIT" --log-prefix "DROP "
"$IPTABLES" -A DROPLOG -j DROP
# Registra os pacotes, depois REJECT.
# Pacotes TCP são rejeitados com um reset de TCP.
"$IPTABLES" -N REJECTLOG
"$IPTABLES" -A REJECTLOG -j "$LOG" "$RLIMIT" --log-prefix "REJECT "
"$IPTABLES" -A REJECTLOG -p tcp -j REJECT --reject-with tcp-reset
"$IPTABLES" -A REJECTLOG -j REJECT
# Permite apenas RELATED ICMP.
# (Destino inalcançável, Tempo excedido e problemas de parâmetro).
"$IPTABLES" -N RELATED_ICMP
"$IPTABLES" -A RELATED_ICMP -p icmp --icmp-type destination-unreachable -j ACCEPT
"$IPTABLES" -A RELATED_ICMP -p icmp --icmp-type time-exceeded -j ACCEPT
"$IPTABLES" -A RELATED_ICMP -p icmp --icmp-type parameter-problem -j ACCEPT
"$IPTABLES" -A RELATED_ICMP -j DROPLOG
# Dificulta ainda mais o Multi-PING
"$IPTABLES"  -A INPUT -p icmp -m limit --limit 1/s --limit-burst 2 -j ACCEPT
"$IPTABLES"  -A INPUT -p icmp -m limit --limit 1/s --limit-burst 2 -j LOG --log-prefix PING-DROP:
"$IPTABLES"  -A INPUT -p icmp -j DROP
"$IPTABLES"  -A OUTPUT -p icmp -j ACCEPT
# Permite apenas as partes minimamente necessárias/recomendadas do ICMP. Bloqueia o resto.
# primeiro, descarta todos os pacotes ICMP fragmentados (quase sempre maliciosos).
"$IPTABLES" -A INPUT -p icmp --fragment -j DROPLOG
"$IPTABLES" -A OUTPUT -p icmp --fragment -j DROPLOG
"$IPTABLES" -A FORWARD -p icmp --fragment -j DROPLOG
# Permite todo o tráfego ICMP estabelecido.
"$IPTABLES" -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT "$RLIMIT"
"$IPTABLES" -A OUTPUT -p icmp -m state --state ESTABLISHED -j ACCEPT "$RLIMIT"
# Permitir algumas partes do tráfego ICMP relacionado, bloqueia o resto.
"$IPTABLES" -A INPUT -p icmp -m state --state RELATED -j RELATED_ICMP "$RLIMIT"
"$IPTABLES" -A OUTPUT -p icmp -m state --state RELATED -j RELATED_ICMP "$RLIMIT"
# Permite solicitações de echo ICMP de entrada (ping), mas apenas com taxa limitada.
"$IPTABLES" -A INPUT -p icmp --icmp-type echo-request -j ACCEPT "$RLIMIT"
# Permite solicitações de echo ICMP de saída (ping), mas apenas com taxa limitada.
"$IPTABLES" -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT "$RLIMIT"
# Derruba qualquer outro tráfego ICMP.
"$IPTABLES" -A INPUT -p icmp -j DROPLOG
"$IPTABLES" -A OUTPUT -p icmp -j DROPLOG
"$IPTABLES" -A FORWARD -p icmp -j DROPLOG
# Permite seletivamente certos tipos especiais de tráfego.
# Permite que a interface de loopback faça qualquer coisa.
"$IPTABLES" -A INPUT -i lo -j ACCEPT
"$IPTABLES" -A OUTPUT -o lo -j ACCEPT
# Permite conexões de entrada relacionadas a conexões permitidas existentes.
"$IPTABLES" -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Permite conexões de saída, exceto as inválidas.
"$IPTABLES" -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
# Miscelânia.
# Derruba SMB/CIFS/etc..
"$IPTABLES" -A INPUT -p tcp -m multiport --dports 135,137,138,139,445,1433,1434 -j DROP
"$IPTABLES" -A INPUT -p udp -m multiport --dports 135,137,138,139,445,1433,1434 -j DROP
# Elimina explicitamente o tráfego de entrada inválido.
"$IPTABLES" -A INPUT -m state --state INVALID -j DROP
# Elimina também o tráfego de saída inválido.
"$IPTABLES" -A OUTPUT -m state --state INVALID -j DROP
# Se usássemos NAT, pacotes inválidos passariam, bloquearemos de qualquer forma.
"$IPTABLES" -A FORWARD -m state --state INVALID -j DROP
# Scanners PORT (furtivos também).
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --tcp-flags ALL ALL -j DROP
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --tcp-flags ALL NONE -j DROP
# Algumas regras anti-spoofing.                                                 
"$IPTABLES" -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP 
"$IPTABLES" -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP 
"$IPTABLES" -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP 
"$IPTABLES" -N SYN_FLOOD
"$IPTABLES" -A INPUT -p tcp --syn -j SYN_FLOOD
"$IPTABLES" -A SYN_FLOOD -m limit --limit 2/s --limit-burst 6 -j RETURN
"$IPTABLES" -A SYN_FLOOD -j DROP
# Bloqueia IPs ruins conhecidos, precisa de update frequente.
# Comando: "$IPTABLES" -A INPUT -s IP-AQUI -j DROPLOG
# Elimina qualquer tráfego de IPs reservados pela IANA.
"$IPTABLES" -A INPUT -s 0.0.0.0/7 -j DROP
"$IPTABLES" -A INPUT -s 2.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 5.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 7.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 10.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 23.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 27.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 31.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 36.0.0.0/7 -j DROP
"$IPTABLES" -A INPUT -s 39.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 42.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 49.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 50.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 77.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 78.0.0.0/7 -j DROP
"$IPTABLES" -A INPUT -s 92.0.0.0/6 -j DROP
"$IPTABLES" -A INPUT -s 96.0.0.0/4 -j DROP
"$IPTABLES" -A INPUT -s 112.0.0.0/5 -j DROP
"$IPTABLES" -A INPUT -s 120.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 169.254.0.0/16 -j DROP
"$IPTABLES" -A INPUT -s 172.16.0.0/12 -j DROP
"$IPTABLES" -A INPUT -s 173.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 174.0.0.0/7 -j DROP
"$IPTABLES" -A INPUT -s 176.0.0.0/5 -j DROP
"$IPTABLES" -A INPUT -s 184.0.0.0/6 -j DROP
"$IPTABLES" -A INPUT -s 192.0.2.0/24 -j DROP
"$IPTABLES" -A INPUT -s 197.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 198.18.0.0/15 -j DROP
"$IPTABLES" -A INPUT -s 223.0.0.0/8 -j DROP
"$IPTABLES" -A INPUT -s 224.0.0.0/3 -j DROP
# Permite seletivamente certas conexões de saída, bloqueia o restante.
# Permite solicitações de DNS de saída. Poucas coisas funcionarão sem isso.
"$IPTABLES" -A OUTPUT -m state --state NEW -p udp --dport 53 -j ACCEPT
"$IPTABLES" -A OUTPUT -m state --state NEW -p tcp --dport 53 -j ACCEPT
# Permite solicitações HTTP de saída. Não criptografado, use com cuidado.
"$IPTABLES" -A OUTPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
# Permite solicitações HTTPS de saída.
"$IPTABLES" -A OUTPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT
# Permite solicitações de "envio" de saída (RFC 2476).
"$IPTABLES" -A OUTPUT -m state --state NEW -p tcp --dport 587 -j ACCEPT
# Permite solicitações POP3S de saída.
"$IPTABLES" -A OUTPUT -m state --state NEW -p tcp --dport 995 -j ACCEPT
# Permite solicitações SSH de saída.
"$IPTABLES" -A OUTPUT -m state --state NEW -p tcp --dport "$SSHPORT" -j ACCEPT
# Permite solicitações OpenVPN de saída.
"$IPTABLES" -A OUTPUT -m state --state NEW -p udp --dport 1194 -j ACCEPT
# Permite seletivamente certas conexões de entrada, bloqueia o restante.
# Permite solicitações DNS recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p udp --dport 53 -j ACCEPT
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 53 -j ACCEPT
# Permite solicitações HTTP recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
# Permite solicitações HTTPS recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT
# Permite solicitações POP3 recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 110 -j ACCEPT
# Permite solicitações IMAP4 recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 143 -j ACCEPT
# Permite solicitações POP3S recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 995 -j ACCEPT
# Permite solicitações SMTP recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 25 -j ACCEPT
# Permite solicitações SSH recebidas..
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport "$SSHPORT" -j ACCEPT
# Permite solicitações de FTP recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 21 -j ACCEPT
# Permite solicitações NNTP recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 119 -j ACCEPT
# Permite solicitações MySQL recebidas.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 3306 -j ACCEPT
# Permite solicitações de entrada de BitTorrent.
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --dport 6881 -j ACCEPT
"$IPTABLES" -A INPUT -m state --state NEW -p udp --dport 6881 -j ACCEPT
# Registra explicitamente e rejeita todo o resto.
# Use REJECT em vez de REJECTLOG se você não precisa/quer registrar.
"$IPTABLES" -A INPUT -j REJECTLOG
"$IPTABLES" -A OUTPUT -j REJECTLOG
"$IPTABLES" -A FORWARD -j REJECTLOG
# Testes (ignorar).
sudo ip6tables -A INPUT -p tcp --dport "$SSHPORT" -s HOST_IPV6_IP -j ACCEPT
sudo ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo ip6tables -A INPUT -p tcp --dport 21 -j ACCEPT
sudo ip6tables -A INPUT -p tcp --dport 25 -j ACCEPT
sudo ip6tables -L -n --line-numbers
sudo ip6tables -D INPUT -p tcp --dport 21 -j ACCEPT
echo
echo "${BWhite}Pronto! Saindo...\e[0m"
exit 0
