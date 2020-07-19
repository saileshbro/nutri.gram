import tesserocr
from PIL import Image
from os import path

PATH = path.abspath('./tessdata')

print(tesserocr.tesseract_version())
print(tesserocr.get_languages(PATH))
image = Image.open('images/threshold_cropped.jpg')
print(tesserocr.image_to_text(image, path=PATH))
