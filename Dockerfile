FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www/

# Selecciona la zona horaria
ENV TZ=America/Bogota

RUN apt-get update && \ 
    apt-get install -y apache2 software-properties-common && \
    apt-get update && apt-get install -y nano && \
    apt-get update && apt-get install -y redis-tools && \
    apt-get update && apt-get install -y postgresql-client && \
    add-apt-repository -y ppa:ondrej/php && apt-get update && \
    apt-get install -y php8.2-fpm php8.2-pgsql php8.2-redis && \
    apt-get install -y php8.2-mysql php8.2-mbstring php8.2-xml php8.2-gd php8.2-curl && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apt-get update && apt-get install -y git && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs

RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    chmod 700 /var/run/sshd && \
    echo 'root:tostadora' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "export VISIBLE=now" >> /etc/profile

# Init ssh service
RUN service ssh start

# Habilitamos mod_rewrite
RUN a2enmod rewrite

# Habilitamos los headers del servidor
RUN a2enmod headers

# Execute a2ensite and a2enconf
RUN a2ensite default-ssl.conf

# Execute a2enconf
RUN a2enconf php8.2-fpm

# Exponemos los puertos
EXPOSE 80 22

# Iniciamos apache2
CMD ["apache2ctl", "-D", "FOREGROUND"] && ["/usr/sbin/sshd", "-D"]