FROM resin/rpi-raspbian:jessie-20160831

ENV VERSION 0.5.2

# Install requirements
RUN apt-get update && \
    apt-get install \
        git \
        zlib1g \
        gnupg2 \
        openssl \
        python-pip \
        python-jinja2 \
        python-libxml2 \
        python-libxslt1 \
        python-lxml \
        ca-certificates

# Get Mailpile from github
RUN git clone https://github.com/mailpile/Mailpile.git \
        --branch $VERSION --single-branch --depth=1

WORKDIR /Mailpile

# Install missing requirements
RUN pip install -r requirements.txt

# Initial Mailpile setup
RUN ./mp setup

CMD ./mp --www=0.0.0.0:33411 --wait
EXPOSE 33411

VOLUME /mailpile-data/.local/share/Mailpile
VOLUME /mailpile-data/.gnupg
