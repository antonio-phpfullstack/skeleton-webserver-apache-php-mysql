FROM httpd:2.4


# Variáveis de ambiente para definição do usuário e grupo do linux.
# Os valores vêm do arquivo .env na raiz do projeto
ARG USUARIO
ARG GRUPO
ARG UID
ARG GID


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


# Cria um novo usuário do sistema e define o diretório inicial.
RUN groupadd -g $GID $GRUPO && \
    useradd -m -u $UID -g $GRUPO -G www-data,root -d /home/$USUARIO $USUARIO


# Define o proprietário e grupo do diretório /usr/local/apache2/htdocs
# Esse é o diretório do webserver do apache
RUN chown $USUARIO:$GRUPO /usr/local/apache2/htdocs


# Define o diretório de trabalho no contêiner onde todos os comandos subsequentes serão executados
WORKDIR /usr/local/apache2/htdocs