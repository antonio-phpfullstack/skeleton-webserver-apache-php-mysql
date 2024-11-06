FROM httpd:2.4


# Caso o nome do grupo do usuário da sua máquina local seja diferente do nome do usuário acrescente mais uma variável de ambiente
# e localize onde essa variável esta sendo usada, abaixo nesse mesmo arquivo, e faça as devidas modificações
# Altere a variável de ambiente abaixo para o nome de usuário do seu Linux, ex: user=antonio
ARG user=seu_usuario_linux
ARG uid=1000


# Instalação das dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    vim \
    iputils-ping


# Instalação do Node.js e npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs


# Limpa o cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Cria um novo usuário do sistema, especificando grupos e identificador (UID), e define seu diretório inicial.
RUN useradd -G www-data,root -u $uid -d /home/$user $user


# Define o proprietário do diretório /var/www
RUN chown $user:$user /usr/local/apache2/htdocs


# Define o diretório de trabalho no contêiner onde todos os comandos subsequentes serão executados
WORKDIR /usr/local/apache2/htdocs

