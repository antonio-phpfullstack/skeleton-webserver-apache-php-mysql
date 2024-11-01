FROM php:8.3-apache


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
    iputils-ping \
    default-mysql-client 


# Limpa o cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Instalação das extensões PHP
RUN docker-php-ext-install pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    sockets \
    zip \
    soap \
    xml  


# Utilize a configuração de produção padrão. Para qualquer necessidade altere esse arquivo
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini


# Copia o executável do Composer diretamente da imagem oficial para o contêiner.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


# Cria um novo usuário do sistema, especificando grupos e identificador (UID), e define seu diretório inicial.
# Cria um usuário no sistema para executar comandos do Composer e do Artisan
RUN useradd -G www-data,root -u $uid -d /home/$user $user


# Cria um diretório .composer na pasta do usuário
# Cria o diretório do Composer para o usuário e define as permissões apropriadas
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user


# Instalação do redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis


# Instalação do xdebug
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug


#Deleta a configuração padrão do apache para substituir as permissões do usuário e grupo do apache
RUN  rm /etc/apache2/envvars 
COPY ./docker/apache/envvars /etc/apache2/envvars


# As linhas abaixo configuram o diretório raiz do Apache dentro do contêiner para que o servidor web aponte para o diretório /var/www/public
# O diretório raiz do contêiner(WORKDIR) é /var/www. Mas estou colocando o diretório do apache para /var/www/public
# Já estou pensando em aplicações tipo Moodle ou framework Laravel que é essa a boa prática.
# Caso venha a ser outro diretório altere de /var/www/public para /var/www/html ou /var/www
# Criação de uma variável de ambiente APACHE_DOCUMENT_ROOT com o valor /var/www/public
ENV APACHE_DOCUMENT_ROOT=/var/www/public
# Esse abaixo comando usa sed (uma ferramenta de edição de texto) para substituir todas as ocorrências de /var/www/html pelo valor de 
# ${APACHE_DOCUMENT_ROOT} (ou seja, /var/www/public) nos arquivos de configuração padrão do Apache localizados em 
# /etc/apache2/sites-available/*.conf. Isso ajusta o diretório padrão dos sites configurados para apontarem para o novo diretório (/var/www/public).
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
# Esse comando faz uma substituição semelhante, mas agora em outros arquivos de configuração, incluindo /etc/apache2/apache2.conf e qualquer 
# configuração adicional em /etc/apache2/conf-available/*.conf. Ele ajusta quaisquer referências ao caminho /var/www/ para garantir que o novo 
# diretório raiz (/var/www/public) seja utilizado em todo o Apache.
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


# Habilita o módulo mod_rewrite para reescrita de URLs e o módulo mod_headers para permitir cabeçalhos extras configurados no .htaccess, 
# como Access-Control-Allow-Origin, que permite o compartilhamento de recursos entre origens (CORS).
RUN a2enmod rewrite headers


# Define o proprietário do diretório /var/www
RUN chown $user:$user /var/www


# Define o diretório de trabalho no contêiner onde todos os comandos subsequentes serão executados
WORKDIR /var/www


# Define o usuário padrão para executar os próximos comandos no contêiner
USER $user
