# PCtensorflowStartup

*Note: I am not an absolute expert in Python, OpenCV or Tensorflow, this stuff is a collection of stuff I have found to make a raspberry pi work doing tensorflow lite stuff. I want to share this because I found it difficult to weed through what works and what doesn't. This is dated as of 8 May 2020 using Python version 3.7.3 and a raspberry pi 4 running raspbian 10 (buster). My background is mechatronics, I'm a jack of trades but master of none! If there are any suggestions for improvements please let me know.*

## 1. Project Background - Booting a desktop PC using a Raspberry Pi 4, Tensorflow lite and OpenCV

This program simply turns on a PC upon detection of the users face via USB/raspberry pi camera and tensorflow lite! This is a project I made in order to learn how to use tensorflow lite on small mobile chips such as the raspberry pi. The aim was to learn rougly how image recognition and machine learning work together, I had learned some basics in opencv from this guy Adrian Rosebrock here: https://www.pyimagesearch.com/ (I highly recommend buying some of his learning kits if you are interested in machine learning, image recognition, opencv etc. this guy sets it out really well with heaps of practical examples)
![image](https://user-images.githubusercontent.com/50968156/117960372-445b5280-b360-11eb-80e3-f35163c3ec3e.png)
![image](https://user-images.githubusercontent.com/50968156/117795166-44405180-b291-11eb-9f83-6ce0bb8aa7fd.png)
![Screenshot 2021-05-12 194011](https://user-images.githubusercontent.com/50968156/117957236-348e3f00-b35d-11eb-8635-9f704903658f.png)
![Screenshot 2021-05-12 194134](https://user-images.githubusercontent.com/50968156/117957302-45d74b80-b35d-11eb-945f-01ded91bbe27.png)



## 2. Image recognition requirements

In order to to anything with image recognition using a computer vision library such as [OpenCV](https://opencv.org/) you need a model (gotta know what a face looks like in order to draw a box around it, eh?), which could be either:
  - A pretrained model such as [Haar Cascade](https://docs.opencv.org/3.4/db/d28/tutorial_cascade_classifier.html), which is useful for generic face detection, but lacks                                              the specificity for discerning your face from someone else's
  - A model made using deep learning/AI/Machine learning (in my case I used tensorflow, because that seems interesting lately), which uses photos of specific items you want to detect i.e. your face, people in a crowd, someone on their phone in their car [*cough*](https://www.9news.com.au/national/speed-camera-and-mobile-phone-use-fines-spike-in-nsw/1686f126-6213-44ff-b1e7-1856bb3d1e0a)

I've used pretrained models before in OpenCV (kudos to Adrian Rosebuck again, can't recommend his stuff enough) but I wanna learn more about deep learning approaches for the specificity they can provide, so here we are.

I am interested also in doing this stuff using mobile chips such as the raspberry pi, as the mobility and low power consumption may be useful for little robotics projects later on. In my instance I had a raspberry pi 4 4gb model, which was more than enough ram to get the job done. I could use a spare raspbery pi zero I got lying around, but these are VERY SLOW for any kind of OpenCV work I've tried in the past (I gave up just trying to install the dependencies and debug anything).

## 3. Reference Material
The following two articles were a major help in getting the model, finding some code and the correct dependencies which will properly run it on the raspberry pi

### 3.1 Model training
 - The tensorflow model I trained via google Colab with the help of this tutorial: https://blog.roboflow.com/how-to-train-a-tensorflow-lite-object-detection-model/
  - This uses the following Google Colab document which you must use to train the model here: https://colab.research.google.com/drive/1qXn9q6m5ug7EWJsJov6mHaotHhCUY-wG?usp=sharing
  - To use the above you must create a dataset in order to train the model in TFRecord format, which can be done using the dataset creation tools on roboflow:
  - ![image](https://user-images.githubusercontent.com/50968156/117539709-313e3f00-b04f-11eb-96b9-faed81e92415.png)
  - Note: The training process using the google GPU servers takes 6 hours! I have included a default model that may work with your face (it was an initial model that seems to trigger on a variety of faces in addition to mine :P)

### 3.2 Project Template
i. I found this guys project who had a nice tensorflow lite raspberry pi project here: https://github.com/EdjeElectronics/TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi/blob/master/Raspberry_Pi_Guide.md
 This is a good template as it runs with any kind of webcam or raspberry pi camera I've tried. There is also the option in it to use a Coral accelerator to speed up the framerate.
 
ii. *Extra: This guy also has a decent tutorial on how to train Tensorflow models if you got your own beefy Windows 10 PC [here](https://github.com/EdjeElectronics/TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi#part-1---how-to-train-convert-and-run-custom-tensorflow-lite-object-detection-models-on-windows-10), although I have not tried it yet!*

I have made some changes to the code provided in the above project to trip a relay (or do whatever you want the raspberry pi to do once a positive facial detection has been made).

## 4.1 To get the software running on your Raspberry Pi

Most of these instructions are adapted from the source provided in [section 3.2 (i)](https://github.com/huggy12/PCtensorflowStartup/blob/main/README.md#32-project-template)

Before getting started, make sure the camera is enabled in (Preferences > Raspberry Pi configuration) 
![image](https://user-images.githubusercontent.com/50968156/117952760-cd6e8b80-b358-11eb-9bf4-83173e959c19.png)

and update everything using 
```
sudo apt-get update
sudo apt-get dist-upgrade
```
1. Download the files from this project usingthe following in terminal:
```
git clone https://github.com/huggy12/PCtensorflowStartup.git
```
2. Change the name of the directory to something smaller using
```
mv PCtensorflowStartup tflite1
```
3. Go into the newly renamed project directory typing the following into terminal:
```
cd tflite1
```
4. Configure a Python virtual environment in accordance with the instructions provided in in the link in 3.2 (i):
```
sudo pip3 install virtualenv
```
5. Create the Virtual environment using:
```
python3 -m venv tflite1-env
```
6. Activate the virtual environment using 
```
source tflite1-env/bin/activate
```
7. Install the dependencies by using the get_pi_requirements.sh file, type into the terminal:
```
bash get_pi_requirements.sh
```
8. Install RPi.GPIO to control the GPIO pins:
```
pip3 install RPi.GPIO
```
9. Create a tensorflow facial recognition model in accordance with [Section 3.1](https://github.com/huggy12/PCtensorflowStartup/blob/main/README.md#31-model-training) via Google Colab or if you've got a beefy PC, maybe try doing it on your own PC via instructions in [Section 3.2 ii](https://github.com/huggy12/PCtensorflowStartup/blob/main/README.md#32-project-template). I have included a default model in the project file list which was one of my first models, it seems to trigger on a variety of faces including mine (gotta use HEAPS of images to train these models :P)
10. Place the model files (named as "detect.tflite" and "labelmap.txt") inside the "Sample_TFLite_model" directory included in the release files.
11. Make the startup script executable:
```
sudo chmod +x PCTensorStartup.sh
```
12. Double click the "PCTensorStartup.sh" and select the terminal option or type ```./PCTensorStartup.sh``` in terminal, This automatically sets up the virtual environment from step 2. and runs the TFLite_detection_webcam.py code, you should see the video footage come up either using a USB webcam or the raspberry pi camera.
13. Alternatively type in the following terminal commands to get it running:
```
cd /home/pi/tflite1/
source tflite1-env/bin/activate
python3 TFLite_detection_webcam.py --modeldir=Sample_TFLite_model/ --resolution='640x480'
```

Press q from the video window to exit the video

## 4.1.1 Input arguments

The following arguments can be entered after the *python3 TFLite_detection_webcam.py* command above to alter the behaviour of the program:
```
--modeldir
Folder the .tflite file is located in

--graph
Name of the .tflite file, if different than detect.tflite

--labels
Name of the labelmap file, if different than labelmap.txt

--threshold
Minimum confidence threshold for displaying detected objects, lowering this value may trigger false detections
                    default=0.95
--resolution
Desired webcam resolution in WxH. If the webcam does not support the resolution entered, errors may occur.
                    default='1280x720'
--edgetpu
For using Coral Edge TPU Accelerator to speed up detection
                    action='store_true' (if you want to use it)
--turnoffdelay
desired delay for automatically turning off the PC
                    default='120' (Roughly seconds)
```
## 4.2 To get it running automatically on startup of the Pi

To get the project running automatically on startup after booting into the desktop environment we will use [systemd](https://learn.sparkfun.com/tutorials/how-to-run-a-raspberry-pi-program-on-startup#method-3-systemd) (I've had bugs occur when booting the program too early using the autostart method):
```
sudo nano /lib/systemd/system/TFlite1.service
```
then add:
```
[Unit]
Description=TFlite Service

[Service]
Environment=DISPLAY=:0
Environment=XAUTHORITY=/home/pi/.Xauthority
ExecStart=/home/pi/tflite1/PCTensorStartup.sh   
Restart=always
RestartSec=10s
KillMode=process
TimeoutSec=infinity

[Install]
WantedBy=graphical.target
```
save using ctrl X, Y, enter, then
```
sudo systemctl daemon-reload

sudo systemctl enable TFlite1.service

sudo reboot
```
This will attempt to run the program after booting into desktop, if the process fails for whatever reason it will retry opening it. 

This means if you want to disable it you will have to do the following:
```
sudo systemctl disable TFlite1.service
sudo rm /lib/systemd/system/TFlite1.service
sudo systemctl daemon-reload
```

## 4.3 Using a relay to switch on a PC

The python script this runs outputs to a relay on GPIO 17, I was using a generic arduino style relay switch which you can find [here](https://www.aliexpress.com/item/32797029405.html?albpd=en32797029405&acnt=708-803-3821&aff_platform=aaf&albpg=489474619664&netw=u&albcp=11482541945&sk=UneMJZVf&trgt=489474619664&terminal_id=badffc2294d34a41a2128327185e9f24&tmLog=new_Detail&needSmbHouyi=false&albbt=Google_7_shopping&src=google&crea=en32797029405&aff_fcid=0c1bdf1cc5ca48e6b18d467fcf6552b6-1620727279997-08307-UneMJZVf&gclid=CjwKCAjw1uiEBhBzEiwAO9B_HXfmOg-cX1Jcih_FQSEMN-_TZpbumsAci1OLcFhIdmLIy73Q-VC5bRoCtQYQAvD_BwE&albag=112620152352&aff_fsk=UneMJZVf&albch=shopping&albagn=888888&isSmbAutoCall=false&aff_trace_key=0c1bdf1cc5ca48e6b18d467fcf6552b6-1620727279997-08307-UneMJZVf&device=c&gclsrc=aw.ds), although this could be tweaked to run something else on the GPIO pins when triggered (up to your imagination).

The wiring for the relay connections are as follows:
![image](https://user-images.githubusercontent.com/50968156/117796825-c4b38200-b292-11eb-832e-0879788552c3.png)
![image](https://user-images.githubusercontent.com/50968156/117960221-2130a300-b360-11eb-9e79-0c3713f137dd.png)


With the wires going to the item, depending on what it is you want to turn on (in my case, my desktop PC) you will want to connect the NO (normally open) terminals to the computer power button pins. To enable the use of my PC power button switch, I connected it in parallel to the raspberry pi relay output:
![image](https://user-images.githubusercontent.com/50968156/117799225-37bdf800-b295-11eb-99cd-6290bae357ec.png)
![image](https://user-images.githubusercontent.com/50968156/117799300-4dcbb880-b295-11eb-9d3d-dbb4f2b2d47f.png)

Make sure the wires are long enough to connect to the relay!

