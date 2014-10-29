FROM ubuntu:trusty

ADD v10.5_linuxx64_expc.tar.gz /cache
RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install libstdc++6:i386 libpam0g:i386 binutils libaio1 -y
RUN /cache/expc/db2_install -b /opt/ibm/db2/V10.5
RUN rm -fr /cache

RUN useradd -m db2inst1
RUN echo "db2inst1:db2inst1" | chpasswd
RUN /opt/ibm/db2/V10.5/instance/db2icrt -u db2inst1 -p 50000 db2inst1

ADD run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 50000
CMD ["/run.sh"]
