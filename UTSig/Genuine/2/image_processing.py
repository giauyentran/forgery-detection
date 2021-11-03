import cv2

img = cv2.imread('test.png')
cv2.imwrite('car.png', img)
#img_stretch = cv2.resize(img, (1251, 728))
#cv2.imwrite('processed1.tif', img_stretch)

