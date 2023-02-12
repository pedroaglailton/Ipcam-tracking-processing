import ipcapture.*;
import gab.opencv.*;
import java.awt.*;

OpenCV opencv;
IPCapture video;
IPCapture directionlefth;
IPCapture directionupRight;
IPCapture directionup;
IPCapture directiondown;
IPCapture directionlefths;
IPCapture directionRights;
IPCapture directionups;
IPCapture directiondowns;
IPCapture center;

void setup() {
  size(640, 480);
  http://ipcamera:81/videostream.asf?usr=admin&pwd=admin
  video = new IPCapture(this, "http://admin:admin@123@192.168.0.100:80/ISAPI/Streaming/channels/102/httpPreview");
  directionlefth = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=4&onestep=1", "admin", "888888");
  directionupRight = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=6&onestep=1", "admin", "888888");
  directionup = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=0&onestep=1", "admin", "888888");
  directiondown = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=2&onestep=1", "admin", "888888");
  directionlefths = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=7&onestep=1", "admin", "888888");
  directionRights = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=5&onestep=1", "admin", "888888");
  directionups = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=1&onestep=1", "admin", "888888");
  directiondowns = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=3&onestep=1", "admin", "888888");
  center = new IPCapture(this, "http://192.168.25.124:81/decoder_control.cgi?command=25", "admin", "888888");
  
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  
}

void draw() {
  if (video.isAvailable()) {
  video.read();
  opencv.loadImage(video);
  image(video, 0, 0 );

  noFill();
  stroke(255, 0, 0); 
// rect(30, 20, 400, 100);
  strokeWeight(1);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    
    if(faces[i].x  < 213){
     println("Left");
    if (directionlefth.isAvailable() == true); 
     directionlefth.start();
     if (directionlefths.isAvailable() == true); 
     directionlefths.start();
     
   } 
        
   if(faces[i].x  > 426){
    println("Right"); 
    if (directionupRight.isAvailable() == true); 
    directionupRight.start();
    if (directionRights.isAvailable() == true); 
     directionRights.start();
   }
   
  
  if(faces[i].y  > 160){
    println("Bottom"); 
    if (directiondown.isAvailable() == true);
    directiondown.start();
    if (directiondowns.isAvailable() == true);
    directiondowns.start();
    
   }

  if(faces[i].y < 160){
   println("Top"); 
   if (directionup.isAvailable() == true);
    directionup.start();
     if (directionups.isAvailable() == true);
    directionups.start();
    
  }
  if ((faces[i].x < 320) && (faces[i].y  > 1)){
    println("center"); 
   if (center.isAvailable() == true);
    directionup.start();
        
  }
 }
}

}
void keyPressed() {
  if (key == ' ') {
    if (video.isAlive()) video.stop();
    else video.start();
  }
}

