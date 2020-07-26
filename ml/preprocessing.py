import os
import cv2
import numpy as np
import imutils
from helpers.transform import four_point_transform

ratio = None


def load_image(imgPath):
    if not os.path.exists(imgPath):
        return None, None
    global ratio
    image = cv2.imread(imgPath)
    ratio = image.shape[0]/500.0
    orig = image.copy()
    image = imutils.resize(image, height=500)
    return image, orig


def wrap_transform(image, orig):
    global ratio
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (5, 5), 1)
    edged = cv2.Canny(gray, 75, 200)
    cnts = cv2.findContours(edged.copy(), cv2.RETR_LIST,
                            cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    cnts = sorted(cnts, key=cv2.contourArea, reverse=True)[:3]
    screenCnt = None
    for i, c in enumerate(cnts):
        peri = cv2.arcLength(c, True)
        approx = cv2.approxPolyDP(c, 0.02*peri, True)
        if len(approx) == 4:
            screenCnt = approx
            break
    if screenCnt is not None:
        warped = four_point_transform(orig, screenCnt.reshape(4, 2)*ratio)
        warped = cv2.cvtColor(warped, cv2.COLOR_BGR2GRAY)
        T = cv2.adaptiveThreshold(
            warped, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 13, 9)
        return T, warped
    else:
        return None, None


if __name__ == "__main__":
    resized, original = load_image(
        './images/labels_2_cropped.jpg')

    if(resized is not None):
        T, warped = wrap_transform(resized, original)
        if T is not None:
            cv2.imwrite('./images/threshold_cropped.jpg', T)
            cv2.imwrite('./images/WARPED_cropped.jpg',  imutils.resize(warped, height=500))
            cv2.imshow("Threshold", imutils.resize(T, height=500))
            cv2.imshow("Warped", imutils.resize(warped, height=500))
            cv2.waitKey(0)
        else:
            print("T is none")
    else:
        print("Image doesnot exist")
