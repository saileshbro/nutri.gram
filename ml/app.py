from flask import Flask, request
import os


import json
import numpy as np
import imutils
import cv2
import preprocessing
import textDetection
from preprocessing import load_image,wrap_transform
from textDetection import load_and_resize, detectTexts,readText,matchText

app = Flask(__name__)

tessdata_path = './tessdata'
# tessdata_path = './tessdata'

@app.route('/')
def index():
    return "Hello world!!!"

@app.route('/upload',methods=["POST"])
def upload_image():
    if request.method == "POST":
        print(request.files)
        f = request.files['image']
        path = './uploads/'+f.filename
        f.save(path)
        #Preprocessing tasks
        resized, original = load_image(path)

        if(resized is not None):
            T, warped = wrap_transform(resized, original)
 
            if T is not None:
                keyval = detectTexts(T)
                print(keyval)
                return dict(
                    status='success',
                    data=keyval,
                    msg='success',
                    code='200'
                )
            else:
                keyval = detectTexts(resized)
                print(keyval)
                if(bool(keyval)):
                    return dict(
                        status='success',
                        data=keyval,
                        msg='success',
                        code='200'
                    )
                else:
                    return dict(
                        status='failed',
                        data=keyval,
                        msg='failed',
                        code='400'
                    )
            
        else:
            return dict(
                status='failed',
                msg="Image not found",
                code='400',
                data={}
            )
             