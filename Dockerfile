FROM ubuntu:latest

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools -y
RUN apt-get install build-essential -y
RUN apt-get install -y sqlite3 libsqlite3-dev

EXPOSE 33333

WORKDIR /root/
RUN mkdir server
WORKDIR /root/server/
COPY data.db /root/server
COPY *.cpp /root/server/
COPY *.h /root/server/
COPY *.pro /root/server/
COPY . /root/server


RUN qmake server.pro
RUN make

ENTRYPOINT ["./server"]