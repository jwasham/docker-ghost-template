FROM nginx
RUN rm /etc/nginx/nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/sites-available/ghost /etc/nginx/sites-available/ghost
RUN mkdir /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/ghost

#COPY content/index.html /usr/share/nginx/html/index.html

EXPOSE 80 443
