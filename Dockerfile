FROM osrf/ros:humble-desktop-full

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
RUN pip3 install numpy scipy matplotlib scikit-learn opencv-python

# Install some ROS packages
RUN apt-get install -y \
    ros-humble-rosbridge-suite \
    ros-humble-rosbridge-library \
    ros-humble-rosbridge-msgs

# Set up the catkin workspace
RUN mkdir -p ballbot_ws/src
WORKDIR ballbot_ws/src

# Clone the ballbot repository
# Replace 'your-repo-url' with the URL of your repository
RUN git clone your-repo-url .

WORKDIR /ballbot_ws

# Install the dependencies
RUN rosdep update && rosdep install --from-paths src --ignore-src -r -y

# Build the workspace
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> /home/$USERNAME/.bashrc \
RUN /bin/bash -c '. /opt/ros/humble/setup.bash; colcon build'

# Set the entrypoint
CMD /bin/bash -c '. /opt/ros/humble/setup.bash; . install/setup.bash; roslaunch ballbot ballbot.launch'