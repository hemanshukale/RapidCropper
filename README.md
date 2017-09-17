# RapidCropper
For rapidly (manual) cropping and storing of images. Specially useful in creating samples for cascade classifier training  

Hello all,   

This is a code for rapidly making positive and negative samples of any fixed aspect ratio with arbitrary multiplier mainly for creating samples for image processing cascade training. Just move the selection rectangle by mouse or arrow keys and by simple left/right click, the selection rectangle gets stored as image in the corresponding pos / neg folder respectively.  

The code is written in **Processing**, and I also have attached executables for use in both, Ubuntu and Windows.  

What this does:  

Opens up a window, shows the full image in half the width and height of the image. Draws a selection rectangle around mouse pointer. Adjust the aspect ratio or the size of the selection rectangle, move it with mouse or keyboard. The selection rectangle is white with black outline to make it visible on almost any background.    


## Instructions to use:  


* Put the executable or processing script in the folder with raw images  
* When executed, it'll find if any 'pos' or 'neg' subfolders are present in the current folder, if yes, it'll find if any image files exist in the pos and neg folder like 'pos0001.jpeg' and 'neg0001.jpeg' in the folders, respectively. If the files exist, it'll find the largest numbered image (ex. pos0123.jpeg) and start saving cropped files in increment (ex. pos0124.jpeg onwards..)  
* The raw images are then loaded alphabetically, and a selection rectangle centered at the mouse position with a default aspect ratio of 16:9 and multiplier of 1 is shown. Press 'p' or 'n' to navigate to next or previous image, alphabetically.  
* The selection rectangle will appear, with a default ratio of 16:9 and multiplier of 1, centered at mouse pointer. Move the rectangle either by moving the mouse or by arrow keys. Use of control + arrow keys will increase the speed of movement of rectangle, almost proportional to the size of the rectangle.   
* Change the ratio of the rectangle using '+', '-', 'Shift +', 'Shift -'; proportionally increase or decrease the sizes by using '*' or '-'  
* Saves the selected area as a positive sample using Left click or as a negative sample, using Right click. In case of a mistake, press Z or X to delete the last saved positive or negative image, respectively.  




Keys:  
	For changing selection rectangle   
  
Key | Use  
------------ | -------------  
**+** |		Increases width, hence increasing aspect ratio  
**-**	|		Decreases width, hence decreasing aspect ratio  
**Shift +** |		Increases height, hence decreasing aspect ratio  
**Shift -** |	Decreases height, hence increasing aspect ratio  
__*__	|		Increases multiplier, preserving aspect ratio, proportionally to size of the rectangle  
__/__	|		Decreases multiplier, preserving aspect ratio, proportionally to size of the rectangle  
__Shift *__ | 	Increases multiplier, but at a constant rate,   
__Shift /__ |     Decreases multiplier, but at a constant rate,   
**P** 		|	Previous raw image, alphabetically  
**N** 		|	Next raw image, alphabetically  
**Z** 		|	Deletes last saved positive image  
**X** 		|	Deletes last saved negative image  
__\`__ (grave) |	Quits the script  
**Arrow keys / WASD** 	|		  Moves the selection rectangle accordingly, does not move mouse, hence centre of rectangle deviates from the mouse pointer position  
**Shift + Arrow Keys / WASD** |    Increases the speed of movement of selection rectangle  
**F** 						|	  Recentres the selection rectangle at the mouse pointer.There is a small circle at the centre of the rectangle for indication  
**Left Click or Q** 	| Saves as positive image, in pos folder, with increasing count  
**Right Click or E**	| Saves as negative image, in neg folder, with increasing count  

I have commented most of the parts of the code, Do raise an issue or let me know (**hemanshu.kale@gmail.com**) in case of any random problems / bugs

Enjoy :)
