FROM centos

MAINTAINER Morten Trydal <trydis@hotmail.com>

RUN yum install -y \
    autoconf \
    automake \
    g++ \
    gcc \
    libtool \
    m4 \
    make \
    perl \
    wget \
    && yum clean all \
    && groupadd -r pocketmine && useradd -r -g pocketmine pocketmine \
    && mkdir /pocketmine \
    && chown -R pocketmine:pocketmine /pocketmine
    
WORKDIR /pocketmine
USER pocketmine

RUN echo $'server-name=Minecraft: PE Server\n\
server-port=19132\n\
gamemode=1\n\
max-players=20\n\
spawn-protection=16\n\
white-list=off\n\
enable-query=on\n\
enable-rcon=off\n\
rcon.password=\n\
motd=Minecraft: PE Server\n\
announce-player-achievements=on\n\
allow-flight=off\n\
spawn-animals=on\n\
spawn-mobs=on\n\
force-gamemode=off\n\
hardcore=off\n\
pvp=on\n\
difficulty=1\n\
generator-settings=\n\
level-name=world\n\
level-seed=\n\
level-type=DEFAULT\n\
auto-save=on'> ./server.properties \    
&& wget -q -O - http://get.pocketmine.net/ | bash -s - -v development

EXPOSE 19132

CMD ["./start.sh"]