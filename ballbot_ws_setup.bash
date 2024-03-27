# Clone the ballbot repository
mkdir -p ~/ballbot_ws/src
cd ~/ballbot_ws/src
git clone https://github.com/phgandhi02/ball_tracker.git
git clone https://github.com/phgandhi02/articubot_one.git

colcon build --symlink-install
# Install the workspace dependencies
rosdep update
rosdep install --from-paths src --ignore-src -y -r