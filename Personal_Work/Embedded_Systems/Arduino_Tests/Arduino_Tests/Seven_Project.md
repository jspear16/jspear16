@page Seven_Project Seven Segment Display Project
@author Joseph Spear

This was a project done for the purposes of training at VKIS. It is based around the file TEST_Seven_Segment_Display.cpp .

This documentation includes the following:
1. Information on the TEST_Seven_Segment_Display.ino file 
	1. Converted to .cpp for now
2. Documentation on how to set up the circuitry

The primary difference between this file and the LCD Display file is the display which is used. This file is configured for an Arduino setup which will match the pins 
to the ARKLED SN420362N Display.

**Front of the Display:**

![Seven Segment Display](/home/jspear/Desktop/Projects/Arduino_Tests/Doc_Images/Seven_Seg.jpg)


### Some Arduino Pin Hookups

|Arduino Pin |External Connection  |
|--- | --- |
|D2|Display Pin 1 (G)|
|D3|Display Pin 3 (A)|
|D4|Display Pin 4 (F)|
|D5|Display Pin 5 (Right)|
|D6|Display Pin 6 (D)|
|D7|Display Pin 7 (E)|
|D8|Display Pin 8 (C)|
|D9|Display Pin 9 (B)|
|D10|Display Pin 10 (Left)|
|D11|Trig|
|D12|Echo|

**Pin Diagram of the Display:**

![Seven Segment Display Diagram](/home/jspear/Desktop/Projects/Arduino_Tests/Doc_Images/7_Seg_Display_Diagram.jpg)




### Example Circuit Layout

![LCD Layout](/home/jspear/Desktop/Projects/Arduino_Tests/Doc_Images/Seven_Layout.png)

Note that there should be a 220 Ohm Resistor between the Arduino Pin and the Seven-Segment Display Pins 1,3,4,6,7,8, and 9 to protect from high voltage damage.

@see TEST_Seven_Segment_Display.cpp
