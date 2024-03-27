# Setup Depth camera
mkdir -p ~/ballbot_ws/src
cd ~/ballbot_ws/src
echo 'eval "$(register-python-argcomplete3 ros2)"' >> ~/.bashrc
echo 'eval "$(register-python-argcomplete3 colcon)"' >> ~/.bashrc
git clone https://github.com/orbbec/OrbbecSDK_ROS2.git

# assume you have sourced ROS environment, same below
sudo apt install -y libgflags-dev nlohmann-json3-dev libgoogle-glog-dev ros-$ROS_DISTRO-image-transport ros-$ROS_DISTRO-image-publisher ros-$ROS_DISTRO-camera-info-manager
cd ~/ballbot_ws/src/OrbbecSDK_ROS2/orbbec_camera/scripts
bash install_udev_rules.sh
udevadm control --reload-rules && sudo udevadm trigger
cd ~/ballbot_ws

colcon build --event-handlers  console_direct+  --cmake-args  -DCMAKE_BUILD_TYPE=Release