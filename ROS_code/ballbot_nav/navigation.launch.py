# navigation.launch.py

import os
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    # Get the path to the navigation configuration files
    nav_config_dir = os.path.join(
        os.path.dirname(__file__), '..', 'config'
    )

    # Launch the navigation stack
    return LaunchDescription([
        Node(
            package='nav2_bringup',
            executable='bringup',
            name='navigation',
            output='screen',
            parameters=[
                os.path.join(nav_config_dir, 'base_local_planner_params.yaml'),
                os.path.join(nav_config_dir, 'costmap_params.yaml'),
                os.path.join(nav_config_dir, 'local_costmap_params.yaml'),
                os.path.join(nav_config_dir, 'global_costmap_params.yaml')
            ]
        )
    ])
