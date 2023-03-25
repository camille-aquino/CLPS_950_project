# CLPS_950_project
CLPS 950 Counting Action Potentials project with Stella and Camille

1) gif link: ![]count-ap-demo.gif

2) Google Drive link with pictures and videos showing time spent not logged in Github: 
    https://drive.google.com/drive/folders/1RoBAhOnRgS7-IORo3AsXXf_qOfwIjcMx?usp=sharing 

3) Time Log: https://docs.google.com/spreadsheets/d/1eT0TXo4IE9vzKNaXQ-iais-oJyzy6L-3NmV3Vc8ubiw/edit?usp=sharing 

PROJECT DESCRIPTION: ectopic action potential signal determination project

Data -- abf format (Patch Clamp Data from Clampfit) 
We used a code (cloned the github repository) to load abf format  ("abfload")
files into matlab. This returned a 3 dimensional table of values, which we then needed to
size() and to plot to figure out the meaning of each dimension. 

Goal: to differentiate and count those APs

Methods:
1. go by membrane potential height, and only count the events that make it 
    past a Vm  threshold ----- coded by Stella
2. plot the derivative of the Vm curve and spot (clusters of) zeros, then 
    tell Matlab that a certain amount makes up an AP ----- coded by Camille

Notes about not logging hours from beginning of project: 
- Stella was trying to edit another person's repository by accident for a while 
- We also just generally couldn't figure out Github for the first 2 days (took
    vlogs to record our time when we worked, see Google Drive)
