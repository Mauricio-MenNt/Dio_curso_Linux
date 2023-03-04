#!/usr/bin/bash

#-Nesse Script adicionaremos user ao serve de forma simples!
#-O objetivo é decidir número de user e que eles possam gerenciar a pr#ópria senh#a ao logar.

#-Como utilizar o script: Esse Script é necessário digitar a frente a #quantidade de user a ser criado apenas ex: "./Script 5" estarei infor#mando que 5 user devem ser criados.

read -p "Deseja criar diretórios? " resp

x=1

if [ $resp != "n" ]
then
  read -p "Quantos diretórios deseja criar? " qd
  while [ $x -le $qd ]
  do
    read -p "Qual o nome do diretório? " nomed 
    mkdir $nomed
  done
fi
x=1
read -p "Criará grupo?[S/n] " resp

if [ $resp != "n" ] 
then
  read -p "Quantos? " qg

  while [ $x -le $qg ]
  do
    read -p "Qual o nome do $x? " gp
    groupadd $gp
    x=$[ $x + 1 ]
  done

else
  echo "Sem criação de grupo."
fi

x=0

read -p "Quantos user serão adcicionado? " qu

while [ $x -lt $qu ]
do
x=$[ $x + 1 ]
read -p "Qual o nome do $x"o" user? " nome
read -p "Vai adicionar os user a algum grupo?[S/n] " resp

if [ $resp != "n" ]
then
  read -p "Qual o grupo ele será adcionado? " group
  useradd $nome -c "convidado$x" -m -s /bin/bash -p $(openssl passwd senha) -g $group
  passwd $nome -e
  echo "-> foi adicionado convidado$x"

else
  useradd $nome -c "convidado$x" -m -s /bin/bash -p $(openssl passwd senha)
fi
done


#A senha inicial é "senha"

#O comando "-e" é utilizado sem data para que seja necessário no prime#iro login do user criado a mudança da senha.

#Em algumas versões é necessário do server pode sernecessário o parâme#tro adicional -crypt: -p $(openssl passwd -crypt senha).
