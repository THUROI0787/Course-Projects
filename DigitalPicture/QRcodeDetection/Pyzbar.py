import cv2
from pyzbar.pyzbar import decode

for i in range(10, 11):
    img_path = f"add/{i}.jpeg"
    img = cv2.imread(img_path)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    decoded = decode(gray)

    for d in decoded:
        x, y, w, h = d.rect
        cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 7)

    # cv2.imwrite(f"{i}.jpg", img)

cv2.waitKey(0)
cv2.destroyAllWindows()