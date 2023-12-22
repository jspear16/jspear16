/*  ============================================================================
 *  === TEST_LCD_Display.ino ========================================================
 *  ========================================================================= */
/** \file TEST_LCD_Display.cpp
 *  
 *  \author Joseph Spear
 *
 *  \brief  Tesing the HCSR04, Peizo Buzzer, and the SD1602H LCD Display
 *  
 *   ## Description
 *
 *  Random LCD Tests to get used to it.
 *  Also will use HCSR04 Ultrasonic Sensors
 *  June 28, 2021
 *  
 *
 *  
 ******************************************************************************/


// Include the LiquidCrystal library
#include <LiquidCrystal.h>


/* ***************************************************************************************************************************************************
 *                                           Globals                                     
 ****************************************************************************************************************************************************/

// Initialization of pins and timing constants

/** ***********************************************************************/ /**
 *  @var trigPin
 *  \brief  The input trigger pin of the HCSR04
*******************************************************************************/
const int trigPin = 9;
/** ***********************************************************************/ /**
 *  @var echoPin
 *  \brief  The output echo pin of the HCSR04
*******************************************************************************/
const int echoPin = 10;
/** ***********************************************************************/ /**
 *  @var buzzer
 *  \brief  The pin for the piezo buzzer
*******************************************************************************/
const int buzzer = 6;
/** ***********************************************************************/ /**
 *  @var PIR_Sensor
 *  \brief  The pin for the Inferred Sensor. Currently unutilized.
*******************************************************************************/
const int PIR_Sensor= 8; // Inferred sensor

const int refresh = 7;
const int timer = 500;

/** ***********************************************************************/ /**
 *  @var rs
 *  \brief  The Register Select for the LCD Screen
*******************************************************************************/
const int rs = 12;
/** ***********************************************************************/ /**
 *  @var en
 *  \brief  The Enable for the LCD Screen
*******************************************************************************/
const int en = 11;
/** ***********************************************************************/ /**
 *  @var d4
 *  \brief  The fifth binary digit for the LCD Screen
*******************************************************************************/
const int d4 = 5;
/** ***********************************************************************/ /**
 *  @var d5
 *  \brief  The sixth binary digit for the LCD Screen
*******************************************************************************/
const int d5 = 4;
/** ***********************************************************************/ /**
 *  @var d6
 *  \brief  The seventh binary digit for the LCD Screen
*******************************************************************************/
const int d6 = 3;
/** ***********************************************************************/ /**
 *  @var d7
 *  \brief  The eighth binary digit for the LCD Screen
*******************************************************************************/
const int d7 = 2;


/** ***********************************************************************/ /**
 *  @fn lcd
 *  \brief  The LiquidCrystal object from the LiquidCrystal Library which initializes the LCD screen to opeate based on the input pins.
*******************************************************************************/
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

int ultraSonicDistance(void);


/* ***************************************************************************************************************************************************
 *                                           Arduino Setup                                      
 ****************************************************************************************************************************************************/


void setup() {
  // Starts the serial communication
  Serial.begin(9600); 
  // Sets the trigPin as an Output
  pinMode(trigPin, OUTPUT);
  // Sets the echoPin as an Input 
  pinMode(echoPin, INPUT);
  
  pinMode(buzzer, OUTPUT);
  pinMode(PIR_Sensor, INPUT);
  pinMode(13, OUTPUT);

  
  // Set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  
   
  // Print message to screen
  lcd.setCursor(0,0);
  
  lcd.print("Distance to obj:");
}

void loop() {

  /** ***********************************************************************/ /**
   *  @var sense
   *  \brief  Stores most recent Inferred Sensor data (On/Off)
  *******************************************************************************/
  int sense = digitalRead(PIR_Sensor);

  /** ***********************************************************************/ /**
   *  @var distance
   *  \brief  Stores most recent distance from HCSR-04
  *******************************************************************************/  
  int distance = ultraSonicDistance();
  
  /** ***********************************************************************/ /**
   *  @var distance
   *  \brief  Stores most recent distance from HCSR-04 in Inches
  *******************************************************************************/  
  int distanceIN = distance * 0.3937;

  // When the inferred sensor has a value, turn on the LED and turn on the buzzer. Turn off otherwise
  if (sense != 0)
  {
    digitalWrite(13, HIGH);
    tone(buzzer, 900);
  }
  else
  {
    digitalWrite(13, LOW);
    noTone(buzzer);
  }


 // Displaying distance to the LCD Screen

  // Show distance in cm
  lcd.setCursor(0,1);
  lcd.print(distance);
  lcd.setCursor(4,1);
  lcd.print("cm");

  if(distance < 100)
  {
    lcd.setCursor(2,1);
    lcd.print(" ");

    if(distance < 10)
    {
    lcd.setCursor(1,1);
    lcd.print(" ");
    }
  }

  lcd.setCursor(7,1);
  lcd.print("<>");

  // Show distance in in
  lcd.setCursor(10,1);
  lcd.print(distanceIN);
  lcd.setCursor(14,1);
  lcd.print("in");

  if(distanceIN < 100)
  {
    lcd.setCursor(12,1);
    lcd.print(" ");
    
    if(distanceIN < 10)
    {
      lcd.setCursor(11,1);
      lcd.print(" ");
    }
  }  
  tone(6, distance*10);
}


/* ***************************************************************************************************************************************************
 *                                           Functions                                      
 ****************************************************************************************************************************************************/




int ultraSonicDistance(void)
{

  long duration = 0;
  int distance = 0;
  // Clears the trigPin
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);

  // Calculating the distance
  distance= duration*0.034/2;

  return distance;
}
