HKUST COMP 5421 Spring 2014 Computer Vision Project 1
Intelligent Scissor
==========================================================================

Setup Matlab Mex environment first. 
Then in command line box, enter 

mex costPath.cpp

==========================================================================

Main task

In iScissor.m, change input image name in second line. 
Then in command line box, enter

iScissor

Setting first seed position by clicking mouse on image, a red point will be drawn.
Then the contour mask can be selected by moving mouse inside graph. The following seeds will have relatively small size, compared with the first seed.
Closing contour by clicking near the first seed point (within 10 pixel). A contour mask figure will be generated in second figure file and a mask with original image filled inside will be generated in third figure.
Figure with mask and mask itself can be saved by Matlab save function.

==========================================================================

Debug mode
a) pixel node
img = imread(‘cs5421.png’);

img = pixelMode(img);

imshow(img);


b) cost graph
img = imread(‘cs5421.png’);

node = setNodeStruct(img);

displayCostGraph(node, img);


c) path tree
img = imread(‘cs5421.png’);

node = setNodeStruct(img);

preNode = costPath(node,141,179, 4, 5);

( 141*149 pixels for input image, [4, 5] is seed location )

displayPathTree(preNode);


d) min path
As a function in main task.

==========================================================================

other UI functions

a, b) zoom in/out Provided by Matlab

c) first seed
By first mouse clicking on image to setup

d) following seed
By following mouse clicking on image

e, f) finish and close contour Clicking near the first seed
