![Nginx1.8](https://img.shields.io/badge/nginx-1.8-brightgreen.svg) ![PHP5.6](https://img.shields.io/badge/php-5.6-brightgreen.svg)

### an image with nginx,php,git,composer,ssh,supervisor and  about 1.222G size

>nginx 1.8  
>git-2.6.3  
>composer  
>ssh  
>supervisor  
>php5.6
>>extension  
>>>amqp   
>>>zmq    
>>>memcached  
>>>redis  
>>>mcrypt  
>>>mongo  
>>>ssh2  
>>>yaf  
>>>xhprof  
>>>swoole  
>>>msgpack  
>>>...

## full of php extension
```
[PHP Modules]
amqp
bcmath
bz2
calendar
Core
ctype
curl
date
dom
ereg
exif
fileinfo
filter
ftp
gd
gettext
gmp
hash
iconv
igbinary
imagick
json
ldap
libxml
mbstring
mcrypt
memcached
mhash
mongo
msgpack
mysql
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
redis
Reflection
session
shmop
SimpleXML
sockets
SPL
sqlite3
ssh2
standard
swoole
sysvmsg
sysvsem
sysvshm
tokenizer
wddx
xdebug
xhprof
xml
xmlreader
xmlwriter
xsl
yaf
Zend OPcache
zip
zlib
zmq

[Zend Modules]
Xdebug
Zend OPcache
```
###tree
>docker  
>>bash  
>>>init-bashrc.sh  
>>>setting-lnmp.sh
>>
>>config  
>>>nginx`put your nginx config here`  
>>>php-fpm`put your php.ini、php-fpm.conf blah blah here`  
>>>ssh-key`put your id_rsa,id_rsa_pub,know_hosts,config here,then you can use git in container`  
>>>supervisord`put your supervisord file here`  
>>>crontab.sample`just sample`  
>>>supervisord.conf`here is your supervisord.conf`
>>
>>logs  
>>website    
>
>Dockerfile  
>README.md  





