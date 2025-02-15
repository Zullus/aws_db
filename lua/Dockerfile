FROM ubuntu:latest
RUN apt-get -y update && apt-get -y install lua5.1 luarocks lua-socket lua-sec
RUN apt-get -y install mysql-server mysql-client
WORKDIR /app
COPY . .
RUN luarocks install luasql-mysql
CMD ["lua", "aws-db.lua"]