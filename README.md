# PCtensorflowStartup

*Note: I am not an absolute expert in Python, OpenCV or Tensorflow, this stuff is a collection of stuff I have found to make a raspberry pi work doing tensorflow lite stuff. I want to share this because I found it difficult to weed through what works and what doesn't. This is dated as of 8 May 2020 using Python version <FIGURE THIS OUT HUGH> and a raspberry pi 4 running raspbian <FIND THIS OUT HUGH>. My background is mechatronics, I'm a jack of trades but master of none! If there are any suggestions for improvements please let me know.

## 1. Project Background

This is a project I made in order to learn how to use tensorflow lite on small mobile chips such as the raspberry pi. The aim was to learn rougly how image recognition and machine learning work together, I had learned some basics in opencv from this guy Adrian Rosebrock here: https://www.pyimagesearch.com/ (I highly recommend buying some of his learning kits if you are interested in machine learning, image recognition, opencv etc. this guy sets it out really well with heaps of practical examples)

## 2. Image recognition requirements

In order to to anything with image recognition using a computer vision library such as OpenCV (https://opencv.org/) you need a model (gotta know what a face looks like in order to draw a box around it, eh?), which could be either:
  - A pretrained model such as Haar Cascade (https://docs.opencv.org/3.4/db/d28/tutorial_cascade_classifier.html), which is useful for generic face detection, but lacks                                              the specificity for discerning your face from someone else's
  - A model made using deep learning/AI/Machine learning (in my case I used tensorflow, because that seems interesting lately), which uses photos of specific items you want to detect i.e. your face, people in a crowd, someone on their phone in their car (*cough* https://www.9news.com.au/national/speed-camera-and-mobile-phone-use-fines-spike-in-nsw/1686f126-6213-44ff-b1e7-1856bb3d1e0a)

I've used pretrained models before in OpenCV (kudos to Adrian Rosebuck again, can't recommend his stuff enough) but I wanna learn more about deep learning approaches for the specificity they can provide, so here we are.

I am interested also in doing this stuff using mobile chips such as the raspberry pi, as the mobility and low power consumption may be useful for little robotics projects later on. In my instance I had a raspberry pi 4 4gb model, which was more than enough ram to get the job done (the end python script can actually run before the desktop environment loads for a little extra framerate I found). I could use a spare raspbery pi zero I got lying around, but these are VERY SLOW for any kind of OpenCV work I've tried in the past (I gave up just trying to install the dependencies and debug anything).

## 3. Reference Material
The following two articles were a major help in getting the model, finding some code and the correct dependencies which will properly run it on the raspberry pi

### 3.1 Model training
 - The tensorflow model I trained via google Colab with the help of this tutorial: https://blog.roboflow.com/how-to-train-a-tensorflow-lite-object-detection-model/
  - This uses the following Google Colab document which you must use to train the model here: https://colab.research.google.com/drive/1qXn9q6m5ug7EWJsJov6mHaotHhCUY-wG?usp=sharing
  - To use the above you must create a dataset in order to train the model in TFRecord format, which can be done using the dataset creation tools on roboflow:
  - ![image](https://user-images.githubusercontent.com/50968156/117539709-313e3f00-b04f-11eb-96b9-faed81e92415.png)
  - Note: The training process using the google GPU servers takes 6 hours! 

### 3.2 Project Template
 i. I found this guys project who had a nice tensorflow lite raspberry pi project here: https://github.com/EdjeElectronics/TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi/blob/master/Raspberry_Pi_Guide.md
 This is a good template as it runs with any kind of webcam or raspberry pi camera I've tried. There is also the option in it to use a Coral accelerator to speed up the framerate.
 ii. *Extra: This guy also has a decent tutorial on how to train Tensorflow models if you got your own beefy Windows 10 PC here: https://github.com/EdjeElectronics/TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi#part-1---how-to-train-convert-and-run-custom-tensorflow-lite-object-detection-models-on-windows-10, although I have not tried it yet!

I have made some changes to the code provided in the above project to trip a relay (or do whatever you want the raspberry pi to do once a positive facial detection has been made).

## To get the software running on your Raspberry Pi

Most of these instructions are adapted from the source provided in section 3.2 (i.)

1. Download the files from this project using

git clone https://github.com/huggy12/PCtensorflowStartup.git <REVISE HUGH>

2. change the name of the directory to something smaller using

mv TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi tflite1

3. cd tflite1
4. Configure a Python virtual environment in accordance with the instructions provided in in the link in 3.2 (i). (i.e. "sudo pip3 install virtualenv" when inside the /home/pi/tflite1 directory)
5. Activate the virtual environment using 

source tflite1-env/bin/activate

6. Install the dependencies by using the get_pi_requirements.sh file, type into the terminal:

bash get_pi_requirements.sh

7. Create a tensorflow facial recognition model in accordance with 3.1.
8. Place the model files (named as "detect.tflite" and "labelmap.txt") inside the "Sample_TFLite_model" directory included in the release files.
9. Execute the "PCTensorStartup.sh" in terminal, This automatically sets up the virtual environment from step 2. and runs the TFLite_detection_webcam.py code, you should see the video footage come up either using a USB webcam or the raspberry pi camera.
10. Alternatively type in the following terminal commands to get it running:

cd tflite1/
source tflite1-env/bin/activate *this sets up the virtual environment set up in 3.2 (i).*
python3 TFLite_detection_webcam.py --modeldir=Sample_TFLite_model/ --resolution='640x480'
