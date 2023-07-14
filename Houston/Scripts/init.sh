#!/bin/bash

rm -R /root/.pyenv

# # pyenv dependencies
apt-get install python3 python3-pip zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev libreadline-dev -y
curl https://pyenv.run | bash 

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc  
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc  
echo ' eval "$(pyenv init -)"' >> ~/.bashrc 

export PATH="root/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

pyenv install 2.7.18

# # Switch to python 2.7
pyenv global 2.7.18

# # msploitego dependencies on python 2.7
pip install deprecated python-libnmap==0.7.0 NmapParser psycopg2  
apt-get install libpq-dev -y

# # Switch back to global python
pyenv global system

# # Change python path
cd /msploitego/src/msploitego/transforms 
# exec /root/change_python_version.sh

# Start SSH session
ssh start &&

# Start VNC session
(Xvfb :1 -screen 0 1920x1080x24 &) && # Start frame buffer with 24 bit color depth
(sleep 5 && x11vnc -display :1 -ncache 10 -forever -usepw -shared -rfbport 5901 -bg ) && # Wait for the framebuffer to start and then start the  vnc
xfce4-session # Start desktop session
