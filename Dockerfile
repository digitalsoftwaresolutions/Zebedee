FROM alpine
LABEL maintainer="github.com/kooroshh"
WORKDIR /zbd
RUN apk add make build-base 

RUN wget http://www.winton.org.uk/zebedee/zebedee-2.4.1A.tar.gz \
    && wget http://www.winton.org.uk/zebedee/blowfish-0.9.5a.tar.gz \
    && wget http://www.winton.org.uk/zebedee/zlib-1.2.3.tar.gz \
    && wget http://www.winton.org.uk/zebedee/bzip2-1.0.3.tar.gz \
    && tar -xvf zebedee-2.4.1A.tar.gz \
    && tar -xvf blowfish-0.9.5a.tar.gz \
    && tar -xvf zlib-1.2.3.tar.gz \
    && tar -xvf bzip2-1.0.3.tar.gz \
    && cd /zbd/bzip2-1.0.3 && make \
    && cd /zbd/zlib-1.2.3 && ./configure && make \
    && cd /zbd/blowfish-0.9.5a && make \
    && cd /zbd/zebedee-2.4.1A && make OS=linux zebedee && cp zebedee /zbd \
    && cd /zbd && rm -rf *.gz && rm -rf /zbd/zlib-1.2.3 \
    && rm -rf /zbd/bzip2-1.0.3 && rm -rf /zbd/blowfish-0.9.5a \
    && rm -rf /zbd/zebedee-2.4.1A
CMD /zbd/zebedee -d -U -s -f /zbd/server.zbd

