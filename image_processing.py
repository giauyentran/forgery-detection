import cv2

for i in range(1,28):
    img = cv2.imread(f'{i}.tif')
    img_stretch = cv2.resize(img, (1251, 728))
    cv2.imwrite(f'processed{i}.tif', img_stretch)

