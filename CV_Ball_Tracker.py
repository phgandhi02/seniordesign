import numpy as np
import cv2 as cv
from functions import list_ports

available_ports,working_ports,non_working_ports = list_ports()
print(working_ports)
cameraPort = int(input())

videoCapture = cv.VideoCapture(cameraPort)
prevCircle = None
dist = lambda x1, y1, x2, y2: (x1-x2)**2+(y1-y2)**2

while True:
    ret, frame = videoCapture.read()
    if not ret: break
    #cv.imshow('frame',frame) #this simply shows the videoCapture frame
    
    grayFrame = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
    #original = frame.copy()
    # image = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    # lower = np.array([22, 93, 0], dtype="uint8")
    # upper = np.array([45, 255, 255], dtype="uint8")
    # mask = cv2.inRange(image, lower, upper)

    # cnts = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    blurFrame = cv.GaussianBlur(grayFrame, (17,17), 0) 
    #as the tuple in GaussianBlur has larger numbers then it will be more blurred and smaller numbers is less.

    #cv.imshow('blurFrame',blurFrame)
    circles = cv.HoughCircles(blurFrame, cv.HOUGH_GRADIENT, 1.2, 100, 
                              param1=100, param2=50, minRadius=10, maxRadius=400)
    
    if circles is not None:
        circles = np.uint16(np.around(circles))
        chosen = None
        for i in circles[0,:]:
            if chosen is None: chosen = i
            if prevCircle is not None:
                if dist(chosen[0],chosen[1],prevCircle[0],prevCircle[1]) <= dist(i[0],i[1],prevCircle[0],prevCircle[1]):
                    chosen = i
        cv.circle(frame, (chosen[0],chosen[1]),1,(0,100,100),3)
        cv.circle(frame, (chosen[0],chosen[1]), chosen[2],(255,0,255),3)
        prevCircle = chosen           
    
    cv.imshow('circles',frame)

    if cv.waitKey(1) & 0xFF == ord('q'): break

videoCapture.release()
cv.destroyAllWindows()