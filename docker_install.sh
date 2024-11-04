#!/bin/bash

# Habilita a exibição de comandos
set -x

# Remove qualquer instalação anterior do Docker
echo "Removendo instalações anteriores do Docker..."
sudo apt-get remove --purge -y docker docker-engine docker.io containerd runc

# Atualiza a lista de pacotes
echo "Atualizando a lista de pacotes..."
sudo apt-get update

# Instala pacotes necessários
echo "Instalando ca-certificates e curl..."
sudo apt-get install -y ca-certificates curl

# Cria o diretório para as chaves
echo "Criando o diretório para as chaves..."
sudo install -m 0755 -d /etc/apt/keyrings

# Adiciona a chave GPG do Docker
echo "Adicionando a chave GPG do Docker..."
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adiciona o repositório do Docker às fontes do Apt
echo "Adicionando o repositório do Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualiza a lista de pacotes novamente
echo "Atualizando a lista de pacotes novamente..."
sudo apt-get update

# Instala o Docker
echo "Instalando Docker e ferramentas relacionadas..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Testa a instalação do Docker
echo "Testando a instalação do Docker..."
sudo docker run hello-world

# Desabilita a exibição de comandos
set +x

echo "Instalação do Docker concluída com sucesso!"