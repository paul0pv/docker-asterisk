FROM debian:bullseye
USER root
RUN apt update && apt upgrade -y
RUN apt install -y asterisk vim sngrep
COPY config/*conf /etc/asterisk/
RUN /etc/init.d/asterisk start
CMD ["/usr/sbin/asterisk", "-cvvv"]
