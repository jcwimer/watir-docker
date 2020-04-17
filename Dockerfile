FROM ruby:2.5.1

# install Chromium
RUN apt-get update
# stretch uses chromium package not chromium-browser
RUN apt-get install chromium=73.0* -y

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/2.46/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# install xvfb
RUN apt-get install -yqq xvfb

# set display port and dbus env to avoid hanging
ENV DISPLAY=:99
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN gem install watir webdrivers nokogiri
RUN gem install watir-performance -v 0.6.4
COPY entrypoint.sh /root/entrypoint.sh

RUN mkdir /app
WORKDIR /app

RUN chmod a+x /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]
