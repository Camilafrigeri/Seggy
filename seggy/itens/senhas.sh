#!/bin/bash

echo "Instalando ccrypt..."
sudo apt-get install ccrypt
echo 
echo "Por favor, coloque abaixo o tamanho de sua senha:"
read PASS_LENGTH
# Validando o input
if ! [[ $PASS_LENGTH =~ ^[0-9]+$ ]]; then
echo "Erro: Insira um número válido."
exit 1
fi
# Variável que armazena as senhas
passwords=()
# Número de senhas geradas
for p in $(seq 1 5);
do
passwords+=("$(openssl rand -base64 48 | cut -c1-$PASS_LENGTH )")
done
# Mostra as senhas
echo "Aqui estão as senhas geradas:"
echo
printf "%s\n" "${passwords[@]}"
