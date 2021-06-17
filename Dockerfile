FROM ubuntu
MAINTAINER Rakshitha <rakshithapapu7@gmail.com>
RUN apt-get update -y
RUN apt-get install nginx -y
COPY index.html /var/www/html/
COPY bootstrap.css /var/www/html/
COPY bootstrap.min.css /var/www/html/
COPY rakshitha.JPG /var/www/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]