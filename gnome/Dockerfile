FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

# Update and upgrade the system
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends

# Install base packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends locales sudo tzdata vim

# Setting timezone
RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Setting locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    locale-gen en_US.UTF-8

# Setting language
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Installing VNC server
RUN apt-get update
RUN apt-get install -y --no-install-recommends novnc python3-websockify python3-numpy
RUN apt-get install -y --no-install-recommends tightvncserver tigervnc-common xfonts-75dpi xfonts-100dpi xfonts-scalable

# Installing Gnome desktop
RUN apt-get install -y --no-install-recommends ubuntu-desktop-minimal
RUN apt-get install -y --no-install-recommends adwaita-icon-theme-full gnome-panel metacity

# Installing additional packages
RUN apt-get install -y --no-install-recommends cscope curl gcc gdb git global gpg make tree universal-ctags vim wget xdiskusage
RUN apt-get install -y --no-install-recommends gedit gitk gnome-terminal meld midori terminator

# Setting variables
ARG USERNAME=shanmugk
ARG DIRHOME=/home/$USERNAME
ARG DIRVNC=$DIRHOME/.vnc
ARG VNC_PASSWD=helloworld
ARG USER_PASSWD=helloworld

# Creating new user
RUN useradd -m $USERNAME -s /bin/bash
RUN usermod -aG sudo $USERNAME
RUN echo "$USERNAME:$USER_PASSWD" | chpasswd # Setting username password

# Setting VNC for user
RUN  mkdir -p $DIRVNC
COPY xstartvm /xstartvm
RUN  chmod a+x /xstartvm
COPY xstartup $DIRVNC/xstartup
RUN  touch $DIRHOME/.Xauthority
RUN  chmod a+x $DIRVNC/xstartup
RUN  chown -R $USERNAME:$USERNAME $DIRHOME/.Xauthority
RUN  echo "$VNC_PASSWD" | vncpasswd -f >> $DIRVNC/passwd && chmod 600 $DIRVNC/passwd
RUN  chown -R $USERNAME:$USERNAME $DIRVNC # Finally update the ownership to the user

# Setting environments
ENV USER  $USERNAME
ENV VNC_PORT   5901
ENV NOVNC_PORT 6901
ENV VNC_PASSWD=$VNC_PASSWD
ENV VNC_RESOLUTION 1376x720

# Setting entry point
USER    $USERNAME
WORKDIR $DIRHOME
EXPOSE  $VNC_PORT $NOVNC_PORT

# Run command
CMD ["/xstartvm"]
