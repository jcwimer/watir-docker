FROM ruby:2.5.1

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable
#RUN apt-get remove -y google-chrome-stable
#RUN wget -O /tmp/chrome.deb http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_73.0.3683.75-1_amd64.deb && dpkg -i /tmp/chrome.deb && rm /tmp/chrome.deb

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# install xvfb
RUN apt-get install -yqq xvfb

# set display port and dbus env to avoid hanging
ENV DISPLAY=:99
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

RUN gem install watir webdrivers nokogiri

COPY entrypoint.sh /root/entrypoint.sh

RUN mkdir /app
WORKDIR /app

ENTRYPOINT ["/root/entrypoint.sh"]
