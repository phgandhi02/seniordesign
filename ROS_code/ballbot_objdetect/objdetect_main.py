import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2

class ObjectDetection(Node):
    def __init__(self):
        super().__init__('object_detection')
        self.subscription = self.create_subscription(
            Image,
            'camera/image_raw',
            self.image_callback,
            10
        )
        self.subscription  # prevent unused variable warning
        self.cv_bridge = CvBridge()

    def image_callback(self, msg):
        cv_image = self.cv_bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')

        # Object detection using OpenCV
        # Example: detecting tennis balls using color segmentation
        hsv_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2HSV)
        lower_color = (20, 100, 100)  # Lower HSV threshold for detecting tennis balls (green)
        upper_color = (30, 255, 255)  # Upper HSV threshold for detecting tennis balls (green)
        mask = cv2.inRange(hsv_image, lower_color, upper_color)
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        
        # Draw bounding boxes around detected tennis balls
        for contour in contours:
            x, y, w, h = cv2.boundingRect(contour)
            cv2.rectangle(cv_image, (x, y), (x + w, y + h), (0, 255, 0), 2)
        
        cv2.imshow('Object Detection', cv_image)
        cv2.waitKey(1)

def main(args=None):
    rclpy.init(args=args)
    object_detection = ObjectDetection()
    rclpy.spin(object_detection)
    object_detection.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()