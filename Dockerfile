FROM nginx:latest

RUN sed -i 's/nginx/ aurevoir les amis/g' /usr/share/nginx/html/index.html

EXPOSE 80 

CMD ["nginx", "-g", "daemon off;"]
