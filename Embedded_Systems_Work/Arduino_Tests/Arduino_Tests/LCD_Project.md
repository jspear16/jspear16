@page LCD_Project LCD Project
@author Joseph Spear

This was a project done for the purposes of training at VKIS. It is based around the file TEST_LCD_Display.cpp .

This documentation includes the following:
1. Information on the TEST_LCD_Display.ino file 
	1. Converted to .cpp for now
2. Documentation on how to set up the circuitry

The primary difference between this file and the Seven-Segment Display file is the display which is used. This file is configured for an Arduino setup which will match the pins 
to the SD1602H LCD Display Screen

**Front of the LCD:**

![Front](/home/jspear/Desktop/Projects/Arduino_Tests/Doc_Images/LCD_Front.jpg)



**Back of the LCD:**

![Back](/home/jspear/Desktop/Projects/Arduino_Tests/Doc_Images/LCD_Back.jpg)



### Some Arduino Pin Hookups

|Arduino Pin |External Connection  |
|--- | --- |
|D2|LCD Pin 14|
|D3|LCD Pin 13|
|D4|LCD Pin 12|
|D5|LCD Pin 11|
|D6|Buzzer|
|D9|HCSR04 Trig|
|D10|HCSR04 Echo|
|D11|LCD Pin 6|
|D12|LCD Pin 4|

### All LCD Pin Hookups

|LCD Pin |External Connection  |
|--- | --- |
|LCD Pin 1|GND|
|LCD Pin 2|5V|
|LCD Pin 3|Potentiometer Ouput|
|LCD Pin 4|Arduino D12|
|LCD Pin 5|GND|
|LCD Pin 6|Arduino D11|
|LCD Pin 7|**NONE**|
|LCD Pin 8|**NONE**|
|LCD Pin 9|**NONE**|
|LCD Pin 10|**NONE**|
|LCD Pin 11|Arduino D5|
|LCD Pin 12|Arduino D4|
|LCD Pin 13|Arduino D3|
|LCD Pin 14|Arduino D2|
|LCD Pin 15|**NONE**|
|LCD Pin 16|**NONE**|


**Potentiometer Output -> LCD Pin 3**
- This is for changing the LCD Display brightness.


### Example Circuit Layout

![LCD Layout](/home/jspear/Desktop/Projects/Arduino_Tests/Doc_Images/LCD_Layout.png)



@see TEST_LCD_Display.cpp
