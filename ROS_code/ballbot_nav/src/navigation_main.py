import rclpy
from rclpy.node import Node
from geometry_msgs.msg import PoseStamped
from nav2_msgs.action import NavigateToPose
import action_msgs.msg

class NavigationController(Node):
    def __init__(self):
        super().__init__('navigation_controller')
        self.navigation_client = self.create_client(NavigateToPose, 'navigate_to_pose')
        while not self.navigation_client.wait_for_service(timeout_sec=1.0):
            self.get_logger().info('Navigation service not available, waiting...')
        self.navigation_request = NavigateToPose.Request()

    def send_goal(self, goal_pose):
        self.navigation_request.pose.header.frame_id = 'map'
        self.navigation_request.pose.pose.position.x = goal_pose.position.x
        self.navigation_request.pose.pose.position.y = goal_pose.position.y
        self.navigation_request.pose.pose.position.z = goal_pose.position.z
        self.navigation_request.pose.pose.orientation.x = goal_pose.orientation.x
        self.navigation_request.pose.pose.orientation.y = goal_pose.orientation.y
        self.navigation_request.pose.pose.orientation.z = goal_pose.orientation.z
        self.navigation_request.pose.pose.orientation.w = goal_pose.orientation.w

        self.navigation_future = self.navigation_client.call_async(self.navigation_request)
        self.navigation_future.add_done_callback(self.navigation_callback)

    def navigation_callback(self, future):
        try:
            response = future.result()
            if response.result == action_msgs.msg.GoalStatus.STATUS_SUCCEEDED:
                self.get_logger().info('Navigation successful!')
            else:
                self.get_logger().error('Navigation failed!')
        except Exception as e:
            self.get_logger().error(f'Navigation request failed: {str(e)}')

def main(args=None):
    rclpy.init(args=args)
    nav_controller = NavigationController()
    
    # Example goal pose
    goal_pose = PoseStamped()
    goal_pose.header.frame_id = 'map'
    goal_pose.pose.position.x = 1.0
    goal_pose.pose.position.y = 2.0
    goal_pose.pose.position.z = 0.0
    goal_pose.pose.orientation.x = 0.0
    goal_pose.pose.orientation.y = 0.0
    goal_pose.pose.orientation.z = 0.0
    goal_pose.pose.orientation.w = 1.0

    nav_controller.send_goal(goal_pose.pose)

    rclpy.spin(nav_controller)
    nav_controller.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
