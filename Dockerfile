FROM osrf/ros:foxy-desktop
ENV DISPLAY=host.docker.internal:0.0
# Install some basic dependencies
RUN apt-get update && apt-get install -y \
    curl \
    snap \
    python3-pip \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    python3-vcstool \
    git \
    ros-foxy-rosbridge-server \
    openssh-server \
    wget

RUN apt upgrade -y


# # Install Visual Studio Code
# RUN apt update
# RUN apt install software-properties-common apt-transport-https wget
# RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
# RUN sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# RUN apt install code

# Install some python packages
RUN pip3 install scipy matplotlib scikit-learn opencv-python


# Install some ROS packages
RUN apt-get install -y \
    ros-foxy-rosbridge-suite \
    ros-foxy-rosbridge-library \
    ros-foxy-rosbridge-msgs \
    ros-foxy-xacro \
    ros-foxy-joint-state-publisher-gui

# Set up the colcon workspace
RUN mkdir -p ~/ballbot_ws/src

# Build the workspace
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> /home/$USERNAME/.bashrc
RUN /bin/bash -c '/opt/ros/foxy/setup.bash; colcon build'

RUN apt install ros-foxy-ament-cmake
#RUN apt install ros-foxy-ament-cmake-clang-format

# Set the entrypoint
#CMD /bin/bash -c '. /opt/ros/foxy/setup.bash; . install/setup.bash; roslaunch ballbot ballbot.launch'
