#!/bin/bash

# Habilita a exibição de comandos


# Códigos de cor
GREEN='\033[0;32m'
NC='\033[0m' # Sem cor

# Remove qualquer instalação anterior do Docker e do Docker Compose
echo -e "${GREEN}Removendo instalações anteriores do Docker e Docker Compose...${NC}"
sudo apt-get remove --purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker docker-engine docker.io containerd runc docker-compose
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Atualiza a lista de pacotes
echo -e "${GREEN}Atualizando a lista de pacotes...${NC}"
sudo apt-get update

# Instala pacotes necessários
echo -e "${GREEN}Instalando ca-certificates e curl...${NC}"
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Cria o diretório para as chaves
echo -e "${GREEN}Criando o diretório para as chaves...${NC}"
sudo install -m 0755 -d /etc/apt/keyrings

# Adiciona a chave GPG do Docker
echo -e "${GREEN}Adicionando a chave GPG do Docker...${NC}"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adiciona o repositório do Docker às fontes do Apt
echo -e "${GREEN}Adicionando o repositório do Docker...${NC}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualiza a lista de pacotes novamente
echo -e "${GREEN}Atualizando a lista de pacotes novamente...${NC}"
sudo apt-get update

# Instala o Docker
echo -e "${GREEN}Instalando Docker e ferramentas relacionadas...${NC}"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adiciona usuário ao grupo docker
echo -e "${GREEN}Adicionando usuário ao grupo docker...${NC}"
sudo usermod -a -G docker $USER

# Testa a instalação do Docker com sudo
echo -e "${GREEN}Testando a instalação do Docker...${NC}"
sudo docker run hello-world || echo -e "${GREEN}Caso encontre problemas, relogue e tente novamente.${NC}"

echo -e "${GREEN}Instalação do Docker concluída com sucesso!${NC}"

# Instrução para relogar
echo -e "${GREEN}Para aplicar as mudanças no grupo docker você precisa relogar da sua sessão.${NC}"


# Desabilita a exibição de comandos

echo -e "${GREEN}Instalação do Docker concluída com sucesso!${NC}"
