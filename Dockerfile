#FROM nginx
#RUN rm /etc/nginx/nginx.conf
#COPY conf/nginx.conf /etc/nginx/nginx.conf
#COPY conf/sites-available/ghost /etc/nginx/sites-available/ghost
#RUN mkdir /etc/nginx/sites-enabled
#RUN ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/ghost
#
#EXPOSE 80 443
#
## Is this even the right command I have no idea
#
#CMD service nginx start