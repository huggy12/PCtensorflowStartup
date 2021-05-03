#!/bin/bash

cd tflite1/
source tflite1-env/bin/activate
python3 TFLite_detection_webcam.py --modeldir=Sample_TFLite_model/ --resolution='640x480'
