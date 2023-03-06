#!/usr/bin/bash

#-Nesse Script adicionaremos user ao serve de forma simples!
#-O objetivo é decidir número de user e que eles possam gerenciar a pr#ópria senh#a ao logar.

#-Como utilizar o script: Esse Script é necessário digitar a frente a #quantidade de user a ser criado apenas ex: "./Script 5" estarei infor#mando que 5 user devem ser criados.

read -p "Deseja criar diretórios?[S/n] " resp

x=1

case $resp in
  "S" | "s")
    read -p "Quantos diretórios deseja criar? " qd
    while [ $x -le $qd ]
    do
      read -p "Qual o nome do diretório? " nomed 
      mkdir $nomed
      x=$[ x + 1 ]
    done;;
    "N" | "n")
      echo "Sem crição de diretório";;
    *)
      echo "Opção invalida";;
esac

x=1

read -p "Criará grupo?[S/n] " resp

case $resp in
  "S" | "s")
    read -p "Quantos? " qg

    while [ $x -le $qg ]
    do
      read -p "Qual o nome do $x? " gp
      groupadd $gp
      x=$[ $x + 1 ]
    done;;
  
  "N" | "n")
    echo "Sem criação de grupo";;
  *)
    echo "Operação invalida";;
esac

x=0

read -p "Quantos user serão adcicionado? " qu

while [ $x -lt $qu ]
do
  x=$[ $x + 1 ]
  read -p "Qual o nome do $x"o" user? " nome
  tail -n5 /etc/group
  read -p "Vai adicionar os user a algum grupo?[S/n] " resp
  
  case $resp in
    "S" | "s")
      read -p "Qual o grupo ele será adcionado? " group
      useradd $nome -c "convidado$x" -m -s /bin/bash -p $(openssl passwd senha) -G $group
      passwd $nome -e
      echo "-> foi adicionado $nome ao grupo " 
      cat /etc/group | grep $group;;
    "N" | "n")
      useradd $nome -c "convidado$x" -m -s /bin/bash -p $(openssl passwd senha);;
    *)
      echo "Opção invalida!";;
  esac
done

#A senha inicial é "senha"

#O comando "-e" é utilizado sem data para que seja necessário no prime#iro login do user criado a mudança da senha.

#Em algumas versões é necessário do server pode sernecessário o parâme#tro adicional -crypt: -p $(openssl passwd -crypt senha).
