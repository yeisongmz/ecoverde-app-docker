FROM centos/httpd
LABEL maintainer="Yeison Gimenez <yeisongimz@gmail.com>"

RUN mkdir -p /var/www/ecologia-verde/
RUN chown -R apache:apache /var/www/ecologia-verde
# copiar app
COPY ./app/ecologia-verde-front/ /var/www/ecologia-verde/

RUN chown -R apache:apache /etc/httpd/ 
# copiar archivo ecologia.conf
#RUN mkdir -p /etc/httpd/sites-availables
COPY ./ecologia.conf /etc/httpd/sites-enabled/
#RUN mkdir -p /etc/httpd/sites-enabled
# crear enlace
#RUN ln -s /etc/httpd/sites-availables/ecologia.conf /etc/httpd/sites-enabled/ecologia.conf
#RUN rm -rf /var/www/html/index.html
# copiar archivo httpd.conf
COPY ./my-httpd.conf /etc/httpd/conf/httpd.conf