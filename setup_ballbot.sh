#!/bin/bash

# Update package lists
sudo apt update
sudo apt upgrade -y

# Install packages
sudo apt install -y openssh-server git v4l-utils python3-serial python3-pip raspi-config net-tools
sudo ufw allow ssh

# Install ROS Foxy
locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update

sudo apt upgrade

sudo apt install ros-foxy-desktop python3-argcomplete


# Install additional ROS packages
sudo apt install -y ros-foxy-v4l2-camera

# Install colcon and rosdep
sudo apt install -y python3-colcon-common-extensions python3-rosdep

# Initialize rosdep
sudo rosdep init
rosdep update

# make sure to source the ROS setup script
source /opt/ros/foxy/setup.bash
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
echo "source ~/ballbot_robot_ws/install/setup.bash" >> ~/.bashrc

# Install additional Python packages
pip3 install pyserial

# Create a new workspace
mkdir -p ~/ballbot_robot_ws/src
cd ~/ballbot_robot_ws/src
git clone https://github.com/phgandhi02/articubot_one.git
git clone https://github.com/phgandhi02/ball_tracker.git
git clone https://github.com/joshnewans/diffdrive_arduino.git
git clone https://github.com/joshnewans/serial_motor_demo.git
git clone https://github.com/joshnewans/serial.git

cd ~/ballbot_robot_ws
colcon build --symlink-install

# make sure to source the ROS workspace setup script
source ~/ballbot_robot_ws/install/setup.bash

