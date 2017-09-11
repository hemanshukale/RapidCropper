/**
  
This is a code for rapidly making positive and negative samples of any fixed aspect ratio 
with arbitrary multiplier mainly for creating samples for image processing cascade training. 
Just move the selection rectangle by mouse or arrow keys and by simple left/right click, 
the selection rectangle gets stored as image in the corresponding pos / neg folder respectively.

  for additional instructions, visit: https://github.com/hemanshukale
 */

//import java.util.Date;

PImage img;  // Declare variable "a" of type PImage
int num = 10, den = 10; // numerator and denominator 
float multi = 1 , numf = 16, denf = 9;// multiplier for num and den

int cou = 0;
boolean moul = false, mour = false, q = false, e = false, f = false;
boolean pl = false, mi = false, sh = false, mu = false, di  = false;
boolean up = false, dn = false, le = false, ri = false, con = false;
boolean  n = false, p  = false, z  = false, x  = false, qu  = false;
boolean  w = false, a  = false, s  = false, d  = false;
int curr = 0;
long last = 0;
ArrayList<String> fil = new ArrayList<String>(); //Creating arraylist.
int pos_count = 0 , neg_count = 0; 
float kx = 0, ky = 0;
int wscr = 0 , hscr = 0 ;
int maxSize = 2; // reciprocal of max how much fraction of screen will the height or width of window occupy  
int ratio = 1;   // how many times the image should be scaled down to get it undew maxSize

boolean imagesPresent = false ; // prints error message if no images found in the directory

void setup() {
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  wscr = displayWidth;  hscr = displayHeight; // screen res
  println("Stats- " + wscr + "\t" + hscr); 
  
  String path = sketchPath();
  println(path);
  println("Listing all filenames in a directory: ");
  String[] filenames = listFileNames(path);
  if (filenames != null) println(filenames);
  String[] posnames = listFileNames(path+"/pos");

  String[] negnames = listFileNames(path+"/neg");
  
  int tem = 0 ;
  
  // next two for loops are to identify the numbered images and to register the largest count
  if (posnames != null) 
   {
   println(posnames);
  for ( int i = 0 ; i < posnames.length ; i++)
  {
   String temp = posnames[i];
    if  (isImage(temp))
   {
     //if (posnames[i].contains("[0-9]+"))    
     if (temp.matches(".*\\d+.*"))
     {
     int jj = Integer.parseInt(temp.replaceAll("[^0-9]", ""));
     //println(jj);
     if(jj > tem) tem = jj;
     }
     else println("no int in " + temp);
   }
  }
  pos_count = tem;
  tem = 0;
   }
   
   if (negnames != null)
{
  println(negnames);
  for ( int i = 0 ; i < negnames.length ; i++)
  {
   String temp = negnames[i];
   if  (isImage(temp))
   {
     //if (negnames[i].contains("[0-9]+"))
       if (temp.matches(".*\\d+.*")) // regex 
       {
        int jj = Integer.parseInt(temp.replaceAll("[^0-9]", "")); //regex
        //println(jj);
        if(jj > tem) tem = jj;  
       }
       else println("no int in " + negnames[i]);
   }
  }
  neg_count = tem;
}
  println("pos- " + pos_count + " neg- " + neg_count);
  
  // next loop identifies the raw images in the current folder
  // and loads them in the sketch
  
   File[] files = listFiles(path);
  for (int i = 0; i < files.length; i++) {
    File f = files[i];
    if (!f.isDirectory()) 
    {
    String ab = f.getName();
      if (isImage(ab) )
      {
        println("Name: " + ab);
        fil.add(ab);
      }
    }
  }
  if (fil != null && fil.size() > 0 )  imagesPresent = true;
  
  if (imagesPresent)
  {
    String im1 = fil.get(curr); 
  img = loadImage(im1);  // Load the image into the program 
  surface.setSize(683, 384);
  ratio = 1 ;
  
  while (true) // adjust the size of the window, keepingratio constant, 
  // such that, the window never occupies more than half the screen width or height
  // you can change increase or decrease the relative size
   {
     if (img.width/ratio <= wscr / maxSize && img.height/ratio <= hscr / maxSize ) break;
     ratio++;
   }
   println("ratio is " + ratio);
   surface.setSize(img.width/ratio, 10+img.height/ratio);
  //surface.setSize(img.width/2, 10+img.height/2);
  println("loaded " + im1);
  
  println("list is " + fil);
  }
  else 
  {
    surface.setSize(480, 360);
  }
  
  last = millis();
  frameRate(60); // default framerate of 60fps, increase for higher responsiveness 
                 // or decrease if using too much memory or processing power 
}

void draw() {
  background(0);
  if (imagesPresent) { 
  image(img, 0, 0, img.width/ratio, img.height/ratio); // starts image from 0,0 

  //scale(0.5);
  float dev = 0.2;
  if (sh) dev *= (4+multi);
  if (up || w) ky -= dev;
  if (dn || s) ky += dev;
  if (le || a) kx -= dev;
  if (ri || d) kx += dev;
  
    if (f) { kx = 0 ; ky = 0 ; d = false;}
  int mx = mouseX + int(kx), my = mouseY + int(ky);
  

  if ((moul || q) && millis() - last > 200) // for saving positive images, with 200ms debounce
  {
    //String poc = getstr(++pos_count);
    PImage partialSave = get((int)(mx-num*multi), (int)(my-den*multi),(int)(2*num*multi), (int)(2*den*multi));
    print("Pos Stored " + (mx-den) + " " + (my-num) + " "+ (mx+den) + " "+ (my+num) + "\n"  );
    String pocs = "pos/pos"+ getstr(++pos_count) + ".jpeg";
    println(pocs);
    println(partialSave.width+ "\t" + partialSave.height);
    partialSave.save(pocs);
    moul = false;
    last = millis();  
  }
  if ((mour || e ) && millis() - last > 200) // for saving negative images, with 200ms debounce
  {
    //String noc = getstr(++neg_count);
    PImage partialSave = get((int)(mx-num*multi), (int)(my-den*multi),(int)(2*num*multi), (int)(2*den*multi));
    print("Neg Stored " + (mx-den) + " " + (my-num) + " "+ (mx+den) + " "+ (my+num) + "\n"  );
    String nocs = "neg/neg" + getstr(++neg_count) + ".jpeg";
    println(nocs);
    println(partialSave.width+ "\t" + partialSave.height);
    partialSave.save(nocs);
    mour = false;
    last = millis();
  }
 
      // next few lines of code are for drawing the selection rectangle and its center
  noFill();
  strokeWeight(3);
  rect((int)(mx-num*multi), (int)(my-den*multi),(int)(2*num*multi), (int)(2*den*multi)); // selection rectangle
  ellipse(mx,my,3,3); 
  stroke(255,255,255);  strokeWeight(1);
  ellipse(mx,my,1,1);
  rect((int)(mx-num*multi), (int)(my-den*multi),(int)(2*num*multi), (int)(2*den*multi)); // selection rectangle
  stroke(0,0,0);
  strokeWeight(2);


  if (mu) // for increasing multiplier 
  {
  if (sh) multi += 0.04; // at a constant speed
  else    multi += 0.05*multi/2; // speed proportional to size of rectangle
  }
  if (di) // for decreasing multiplier
  {
  if (sh) multi -= 0.04; // at a constant speed
  else    multi -= 0.05*multi/2;  // speed proportional to size of rectangle
  }
  
  // displaying text ->
  // displays multiplier, numerator & denominator sizes, centre of rectangle (x,y) respecively
  text(multi, 1, img.height/ratio + 9); 
  text(num,  61, img.height/ratio + 9); 
  text(den,  91, img.height/ratio + 9); 
  text(mx,  140, img.height/ratio + 9);
  text(my,  170, img.height/ratio + 9);
  if (millis() - last < 500) text("Saved", 210,img.height/ratio + 9);  

  if (z) // deletes last saved positive image
  {
      String pocs = sketchPath() + "/pos/pos" + getstr(pos_count--) + ".jpeg";
      File to_del = new File(pocs);
      if (to_del.exists()) {to_del.delete(); println("Deleted " + pocs);}
      else println("Not found " + pocs);
      z = false;
  }
  if (x) // deletes last saved negative image
  {
      String nocs = sketchPath() + "/neg/neg" + getstr(neg_count--) + ".jpeg";
      File to_del = new File(nocs);
      if (to_del.exists()) {to_del.delete(); println("Deleted " + nocs);}
      else println("Not found " + nocs);
      x = false;
  }
   
  if (n) // loads next image, alphabetically
  {
   if ( curr < fil.size()-1) 
   {
   //curr ++;
   String im1 = fil.get(++curr); 
   img = loadImage(im1);  // Load the image into the program 
   boolean cond = false;
   
   ratio = 1;
   while (true)
   {
     if (img.width/ratio <= wscr / maxSize && img.height/ratio <= hscr / maxSize ) break;
     ratio++;
   }
   println("ratio is "+ ratio);
   surface.setSize(img.width/ratio, 10+img.height/ratio);
   println("loaded " + im1);
   }
   n = false;
  }
  if (p)  // loads previous image, alphabetically
  {
   if ( curr <= fil.size() && curr > 0 )
   {
   //curr --;
   String im1 = fil.get(--curr); 
   img = loadImage(im1);  // Load the image into the program 
   //surface.setSize(683, 384);
   
   ratio = 1;
   while (true)
   {
     if (img.width/ratio <= wscr / maxSize && img.height/ratio <= hscr / maxSize ) break;
     ratio++;
   }
   println("ratio is "+ ratio);
   surface.setSize(img.width/ratio, 10+img.height/ratio);

   //surface.setSize(img.width/2, 10+img.height/2);
   println("loaded " + im1);
   } 
   p = false;
  }
  
  if (pl) // for changing aspect ratio
  {
   if (sh)  denf += 0.2; // when shift is pressed, increases denominator, decreasing aspect ratio 
   else     numf += 0.2; // when shift is not pressed, increases numerator, decreasing aspect ratio
  }
  if (mi)
  {
   if (sh)  denf -= 0.2; // when shift is pressed, decreases denominator, decreasing aspect ratio
   else     numf -= 0.2; // when shift is not pressed, decreases numerator, decreasing aspect ratio
  }
  num = (int) (numf + 0.5);
  den = (int) (denf + 0.5); 
  } // if iimagesPresent ends
  else
  {
    
    text("no raw images present in the current folder" , 150,190);  
    
  }
  
  
  if (qu)  exit();
   
}


String getstr(int number) // convert the count into string for saving of cropped images
{
  String numm = "";  
      if (number < 10    && number >= 0   ) numm = "0000" + Integer.toString(number);
 else if (number < 100   && number >= 10  ) numm = "000" + Integer.toString(number);
 else if (number < 1000  && number >= 100 ) numm = "00" + Integer.toString(number);
 else if (number < 10000 && number >= 1000) numm = "0" + Integer.toString(number);
 else    numm = Integer.toString(number);
 return numm;
}

void mousePressed()
{
     if (mouseButton == LEFT)  moul = true;
else if (mouseButton == RIGHT) mour = true; 
}


String[] listFileNames(String dir) { //lists file names
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list of all files in a directory and all subdirectories
ArrayList<File> listFilesRecursive(String dir) {
   ArrayList<File> fileList = new ArrayList<File>(); 
   recurseDir(fileList,dir);
   return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a,subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}

boolean isImage( String nam) //checks if the file is an image by looking at extensions
{
  boolean ret = false;
   String []imm = {".jpeg" , ".jpg", ".png", ".gif", ".tga" };
   for (int i = 0 ; i < imm.length ; i++)
   {
    if (nam.indexOf(imm[i]) != -1 )
    {
     ret = true;
     break;
    }
   }
  return ret;
}

  void keyPressed()
  {
    switch (keyCode)
  {
   case LEFT  : {le = true;} break; case RIGHT  :  {ri  = true;} break;
   case UP    : {up = true;} break; case DOWN   :  {dn  = true;} break;
   case SHIFT : {sh = true;} break; case CONTROL:  {con = true;} break; 
  }
    switch (key)
     {
      case '+' : {pl = true;} break;  case '-' : {mi = true;} break;
      case '*' : {mu = true;} break;  case '/' : {di = true;} break;
      case 'n' : { n = true;} break;  case 'N' : { n = true;} break;
      case 'p' : { p = true;} break;  case 'P' : { p = true;} break;
      case 'z' : { z = true;} break;  case 'Z' : { z = true;} break;
      case 'x' : { x = true;} break;  case 'X' : { x = true;} break;
      case 'f' : { f = true;} break;  case 'F' : { f = true;} break;
      case 'q' : { q = true;} break;  case 'Q' : { q = true;} break;
      case 'e' : { e = true;} break;  case 'E' : { e = true;} break;
      case 'a' : { a = true;} break;  case 'A' : { a = true;} break;  
      case 'w' : { w = true;} break;  case 'W' : { w = true;} break;
      case 's' : { s = true;} break;  case 'S' : { s = true;} break;
      case 'd' : { d = true;} break;  case 'D' : { d = true;} break;
      case '`' : {qu = true;} break;
      
     }
  }

void keyReleased()
 {

    switch (keyCode)
 {
  
 case LEFT  : {le = false;} break; case RIGHT   : {ri  = false;} break;
 case DOWN  : {dn = false;} break; case UP      : {up  = false;} break;
 case SHIFT : {sh = false;} break; case CONTROL : {con = false;} break;
 }
      switch (key)
   {
     case '+' : {pl = false;} break;  case '-' : {mi = false;} break;
     case '*' : {mu = false;} break;  case '/' : {di = false;} break;
     case 'n' : { n = false;} break;  case 'N' : { n = false;} break;
     case 'p' : { p = false;} break;  case 'P' : { p = false;} break;
     case 'z' : { z = false;} break;  case 'Z' : { z = false;} break;
     case 'x' : { x = false;} break;  case 'X' : { x = false;} break;
     case 'w' : { w = false;} break;  case 'W' : { w = false;} break;
     case 'a' : { a = false;} break;  case 'A' : { a = false;} break;
     case 's' : { s = false;} break;  case 'S' : { s = false;} break;
     case 'd' : { d = false;} break;  case 'D' : { d = false;} break;
     case 'q' : { q = false;} break;  case 'Q' : { q = false;} break;
     case 'e' : { e = false;} break;  case 'E' : { e = false;} break;     
     case 'f' : { f = false;} break;  case 'F' : { f = false;} break;     
   }

 }