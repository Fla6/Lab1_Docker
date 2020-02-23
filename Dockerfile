FROM amazonlinux

WORKDIR /home/lab1

COPY ./lab1.sh /home/lab1

ENTRYPOINT ./lab1.sh