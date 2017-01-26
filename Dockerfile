FROM centos:centos6
MAINTAINER ethan liao<ethanliao924@gmail.com>

ENV SSH_PASSWORD=P@ssw0rd

# Copy files for setting
ADD . /opt/

# Install base tool wget vim tar
RUN yum -y install wget vim tar telnet ntpdate && \
    # Install develop tool
    yum -y groupinstall development && \
    # Install SSH Service
    yum install -y openssh-server passwd && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "${SSH_PASSWORD}" | passwd "root" --stdin && \
    # Install crontab service
    yum -y install vixie-cron crontabs && \
    # Install Git need package
    yum -y install curl-devel expat-devel gettext-devel devel zlib-devel perl-devel && \
    # Install php-fpm (https://webtatic.com/packages/php56/
    # Installing PHP
    rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6 && \
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm && \
    rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && \
    yum install -y php56w php56w-fpm php56w-mbstring php56w-xml php56w-gd php56w-dom php56w-pdo php56w-mysqlnd php56w-process php56w-pear php56w-cli php56w-xml php56w-curl php56w-pecl-memcached php56w-devel php56w-pecl-redis install php56w-pecl-imagick php56w-opcache php56w-pecl-xdebug php56w-bcmath php56w-ldap && \
    # Install php-mssql,mcrypt
    yum -y install php56w-mcrypt && \
    #the others php extension
    #swoole
    cd ~/ && \
    wget https://pecl.php.net/get/swoole-1.9.0.tgz --no-check-certificate && \
    tar zxvf swoole-1.9.0.tgz && \
    cd swoole-1.9.0 && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    echo extension=/usr/lib64/php/modules/swoole.so > /etc/php.d/swoole.ini && \

    #amqp
    cd ~/ && \
    wget https://github.com/alanxz/rabbitmq-c/releases/download/v0.8.0/rabbitmq-c-0.8.0.tar.gz --no-check-certificate && \
    wget http://pecl.php.net/get/amqp-1.6.1.tgz --no-check-certificate && \
    tar zxvf rabbitmq-c-0.8.0.tar.gz && \
    tar zxvf amqp-1.6.1.tgz && \
    cd rabbitmq-c-0.8.0 && \
    ./configure --prefix=/usr/local/rabbitmq-c-0.8.0 && \
    make && make install && \
    cd ~/ && \
    cd amqp-1.6.1 && \
    phpize && \
    ./configure --with-librabbitmq-dir=/usr/local/rabbitmq-c-0.8.0/ && \
    make && make install && \
    echo extension=/usr/lib64/php/modules/amqp.so > /etc/php.d/amqp.ini && \

    #msgpack
    pecl install msgpack-0.5.4 && \
    echo extension=/usr/lib64/php/modules/msgpack.so > /etc/php.d/msgpack.ini && \

    #mongo
    pecl install mongo-1.5.6 && \
    echo extension=/usr/lib64/php/modules/mongo.so > /etc/php.d/mongo.ini && \

    #ssh2
    cd ~/ && \
    yum install -y openssl openssl-devel && \
    wget https://libssh2.org/download/libssh2-1.8.0.tar.gz --no-check-certificate && \
    tar zxvf libssh2-1.8.0.tar.gz && \
    cd libssh2-1.8.0 && \
    ./configure --prefix=/usr/local/libssh2-1.8.0 && \
    make && make install && \
    cd ~/ && \
    wget https://pecl.php.net/get/ssh2-0.13.tgz --no-check-certificate && \
    tar zxvf ssh2-0.13.tgz && \
    cd ssh2-0.13 && \
    phpize && \
    ./configure --with-ssh2=/usr/local/libssh2-1.8.0/ && \
    make && make install && \
    echo extension=/usr/lib64/php/modules/ssh2.so > /etc/php.d/ssh2.ini && \

    #zmq
    cd ~/ && \
    wget https://github.com/zeromq/libzmq/releases/download/v4.2.1/zeromq-4.2.1.tar.gz --no-check-certificate && \
    tar zxvf zeromq-4.2.1.tar.gz && \
    cd zeromq-4.2.1 && \
    ./configure --prefix=/usr/local/zeromq-4.2.1 && \
    make && make install && \
    cd ~/ && \
    wget https://pecl.php.net/get/zmq-1.1.3.tgz --no-check-certificate && \
    tar zxvf zmq-1.1.3.tgz && \
    cd zmq-1.1.3 && \
    phpize && \
    ./configure --with-zmq=/usr/local/zeromq-4.2.1 && \
    make && make install && \
    echo extension=/usr/lib64/php/modules/zmq.so > /etc/php.d/zmq.ini && \

    #xhprof
    cd ~/ && \
    pecl install xhprof-0.9.4 && \
    echo extension=/usr/lib64/php/modules/xhprof.so > /etc/php.d/xhprof.ini && \

    #yaf
    cd ~/ && \
    pecl install yaf-2.3.5 && \
    echo extension=/usr/lib64/php/modules/yaf.so > /etc/php.d/yaf.ini && \

    # Install nginx
    rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6 && \
    rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm && \
    yum -y update nginx-release-centos && \
    cp -p /etc/yum.repos.d/nginx.repo /etc/yum.repos.d/nginx.repo.backup && \
    sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/nginx.repo && \
    yum -y --enablerepo=nginx install nginx && \
    # Setting composer
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
    # Install supervisor
    yum -y install python-setuptools && \
    easy_install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf && \
    # Install Git
    cd ~/ && \
    wget https://www.kernel.org/pub/software/scm/git/git-2.6.3.tar.gz && \
    tar zxf ./git-2.6.3.tar.gz && \
    cd ./git-2.6.3 && \
    ./configure && make && make install && \
    rm -rf ~/git-2.6.3* && \
    # Create /root/.bashrc
    chmod 755 /opt/docker/bash/init-bashrc.sh && echo "/opt/docker/bash/init-bashrc.sh" >> /root/.bashrc && \
    echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc && \
    # Setting php,nginx
    chmod 755 /opt/docker/bash/setting-lnmp.sh && bash /opt/docker/bash/setting-lnmp.sh && \
    # Setting DateTime Zone
    cp -p /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Setup default path
WORKDIR /home

# Private expose
EXPOSE 22 80 8080

# Start run shell
CMD ["bash"]