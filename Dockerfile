FROM --platform=linux/arm64 ros:foxy
ENV DISPLAY=host.docker.internal:0.0


# Install some basic dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3-pip \
    git \
    openssh-server

# Install network tools
# RUN apt-get update && apt-get install -y \
#     net-tools \
#     network-manager

# Install some ROS tools
# RUN apt-get update && apt-get install -y \
#     python3-wstool \
#     python3-vcstool \
#     python3-rosdep \
#     python3-rosinstall \
#     python3-rosinstall-generator \

RUN apt upgrade -y

# Install some python packages
RUN pip3 install scipy matplotlib scikit-learn opencv-python

# Install some ROS packages
RUN apt-get install -y \
    ros-foxy-xacro \
    ros-foxy-joint-state-publisher-gui \
    ros-foxy-ament-cmake \
    python3-colcon-common-extensions

# RUN apt-get update && apt-get install -y \
#     ros-foxy-ros2-control \
#     ros-foxy-ros2-controllers \
#     ros-foxy-ros2-control-toolbox \
#     ros-foxy-ros2-control-msgs \
#     ros-foxy-ros2-control-type \
#     ros-foxy-ros2-control-nodes \
#     ros-foxy-ros2-control-test-assets \
#     ros-foxy-ros2-control-demos \
#     ros-foxy-rosbridge-server \
#     ros-foxy-ros1-bridge \
#     ros-foxy-ros2-web-bridge \
#     ros-foxy-ros2-web-bridge-msgs \
#     ros-foxy-ros2-web-bridge-launch \
#     ros-foxy-rosbridge-suite \
#     ros-foxy-rosbridge-library \
#     ros-foxy-rosbridge-msgs

# Set up the colcon workspace
RUN mkdir -p ~/ballbot_ws/src

# Build the workspace
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> /home/$USERNAME/.bashrc
#RUN /bin/bash -c '/opt/ros/foxy/setup.bash; colcon build'


# Set the entrypoint
#CMD /bin/bash -c '. /opt/ros/foxy/setup.bash; . install/setup.bash; roslaunch ballbot ballbot.launch'
