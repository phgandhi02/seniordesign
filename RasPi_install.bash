# Install the Arduino IDE
cd ~
mkdir arduino
cd arduino/
wget https://downloads.arduino.cc/arduino-1.8.15-linux64.tar.xz
tar -xvf ./arduino-1.8.15-linux64.tar.xz
cd arduino-1.8.15
bash ./install.sh

# Download the Toolchain @ https://gnutoolchains.com/raspberry64/
# https://www.youtube.com/watch?v=lZvhtfUlY8Y&ab_channel=KolbanTechnicalTutorials
#https://www.deviceplus.com/raspberry-pi/how-to-run-arduino-sketches-on-raspberry-pi/