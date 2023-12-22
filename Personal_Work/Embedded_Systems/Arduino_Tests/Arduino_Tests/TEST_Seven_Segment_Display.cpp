/*  ============================================================================
 *  === TEST_Seven_Segment_Display.ino ========================================================
 *  ========================================================================= */
/** \file TEST_Seven_Segment_Display.cpp
 *
 *  \author Joseph Spear
 *
 *  \brief  Testing the HCSR04 and Seven-Segment Digital Display
 *
 *
 *   ## Description
 * 
 *  This is a test function to Work with the HCSR04 Ultrasonic Sensor.
 *  Sourced from: https://www.theengineeringprojects.com/2017/08/ultrasonic-sensor-arduino-interfacing.html
 *  June 23, 2021.
 * 
 *
 * 
 ******************************************************************************/


/* ***************************************************************************************************************************************************
 *                                           Definitions                                     
 ****************************************************************************************************************************************************/

/**
 * \def D_ONE
 * \brief Setting Arduino Pin D2 to be Pin 1 on the 7-segment display
 */
#define D_ONE 2
const int G = D_ONE;

/**
 * \def D_THREE
 * \brief Setting Arduino Pin D3 to be Pin 3 on the 7-segment display
 */
#define D_THREE  3
const int A = D_THREE;

/**
 * \def D_FOUR
 * \brief Setting Arduino Pin D4 to be Pin 4 on the 7-segment display
 */
#define D_FOUR  4
const int EFF = D_FOUR;

/**
 * \def D_FIVE
 * \brief Setting Arduino Pin D5 to be Pin 5 on the 7-segment display
 */
#define D_FIVE  5
const int right = D_FIVE;  // Need to change this when taking input into consideration/.

/**
 * \def D_SIX
 * \brief Setting Arduino Pin D6 to be Pin 6 on the 7-segment display
 */
#define D_SIX  6
const int D = D_SIX;

/**
 * \def D_SEVEN
 * \brief Setting Arduino Pin D7 to be Pin 7 on the 7-segment display
 */
#define D_SEVEN  7
const int E = D_SEVEN;

/**
 * \def D_EIGHT
 * \brief Setting Arduino Pin D8 to be Pin 8 on the 7-segment display
 */
#define D_EIGHT  8
const int C = D_EIGHT;

/**
 * \def D_NINE
 * \brief Setting Arduino Pin D9 to be Pin 9 on the 7-segment display
 */
#define D_NINE  9
const int B = D_NINE;

/**
 * \def D_TEN
 * \brief Setting Arduino Pin 10 to be Pin 10 on the 7-segment display
 */
#define D_TEN  10
const int left = D_TEN; // Need to change this when taking input into consideration.


/* ***************************************************************************************************************************************************
 *                                           Globals                                     
 ****************************************************************************************************************************************************/

// defines arduino pins numbers

/** ***********************************************************************/ /**
 *  @var trigPin
 *  \brief  The input trigger pin of the HCSR04
*******************************************************************************/
const int trigPin = 11;
/** ***********************************************************************/ /**
 *  @var echoPin
 *  \brief  The output echo pin of the HCSR04
*******************************************************************************/
const int echoPin = 12;

// defines variables
const int timer = 500;
const int refresh = 7;

// Function Declarations
int ultraSonicDistance(void);
void displayDigit(int);


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
  // Set each pin as output for the 7-Seg display 
  pinMode(A, OUTPUT);
  pinMode(B, OUTPUT);
  pinMode(C, OUTPUT);
  pinMode(right, OUTPUT);
  pinMode(D, OUTPUT);
  pinMode(E, OUTPUT);
  pinMode(EFF, OUTPUT);
  pinMode(G, OUTPUT);
  pinMode(left, OUTPUT);
}


/* ***************************************************************************************************************************************************
 *                                           Arduino Loop                                      
 ****************************************************************************************************************************************************/

void loop() {
  // Turn off both digits

  digitalWrite(right, HIGH);
  digitalWrite(left, HIGH);

  // Initialize the distances to be found by 
  /** ***********************************************************************/ /**
   *  @var distance
   *  \brief  Stores most recent distance from HCSR-04
  *******************************************************************************/
  int distance = 0;

  /** ***********************************************************************/ /**
   *  @var distanceOnes
   *  \brief  Stores the Ones digit of the most recent distance from HCSR-04
  *******************************************************************************/  
  int distanceOnes = 0;

  /** ***********************************************************************/ /**
   *  @var distanceOnes
   *  \brief  Stores the Tens digit of the most recent distance from HCSR-04
  *******************************************************************************/   
  int distanceTens = 0;


  // Get an average distance
  distance = ultraSonicDistance() * 0.3937; // * 0.3937 converts to in. * 1 is default (cm)
  
  distanceOnes = distance % 10;
  distanceTens = distance / 10;


  // Displays the ones digit
  if(distance < 10)
  {
    digitalWrite(right, LOW);
    displayDigit(distanceOnes);
    delay(refresh);
    digitalWrite(right, HIGH);
    delay(refresh);
  }

  // Displays both the ones and tens digit
  else if ((distance > 0) && (distance < 100))
  {
    digitalWrite(left, LOW);
    displayDigit(distanceTens);
    delay(refresh);
    digitalWrite(left, HIGH);
    digitalWrite(right, LOW);
    displayDigit(distanceOnes);
    delay(refresh);
  }

  // Displays _ _ because it has more than 2 digits
  else
  {
    digitalWrite(left, LOW);
    digitalWrite(right, LOW);
    displayDigit(-1);
    delay(refresh);
    digitalWrite(right, HIGH);
    digitalWrite(left, HIGH);
    delay(refresh);
  }

}


/* ***************************************************************************************************************************************************
 *                                           Functions                                      
 ****************************************************************************************************************************************************/



/** ***********************************************************************/ /**
 * \fn ultraSonicDistance
 * \brief Acquires data from the HCSR04 and converts it to a distance int
 * \param[out] distance Distance calculated from sound travel time
 * \return Distance between HCSR04 and object
*******************************************************************************/
int ultraSonicDistance(void)
{

  // Initialize variables
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

  // Calculating the distance in cm
  distance= duration*0.034/2;

  return distance;
}


/** ***********************************************************************/ /**
 * \fn displayDigit
 * \brief Takes in a base-10 number (0-9) and outputs it to a 7-segment display
 * \param[in] key The desired number to be output
 * \return Nothing
*******************************************************************************/
void displayDigit(int key){
    digitalWrite(A, LOW);
    digitalWrite(B, LOW);
    digitalWrite(C, LOW);
    digitalWrite(D, LOW);
    digitalWrite(E, LOW);
    digitalWrite(EFF, LOW);
    digitalWrite(G, LOW);

  if (key == 0)
  {
    digitalWrite(A, HIGH);
    digitalWrite(B, HIGH);
    digitalWrite(C, HIGH);
    digitalWrite(D, HIGH);
    digitalWrite(E, HIGH);
    digitalWrite(EFF, HIGH);
  }
  else if(key == 1)
  {
    digitalWrite(EFF, HIGH);
    digitalWrite(E, HIGH);
  }
  else if(key == 2)
  {
    digitalWrite(A, HIGH);
    digitalWrite(B, HIGH);
    digitalWrite(D, HIGH);
    digitalWrite(E, HIGH);
    digitalWrite(G, HIGH);
  }
  else if(key == 3)
  {
    digitalWrite(A, HIGH);
    digitalWrite(B, HIGH);
    digitalWrite(C, HIGH);
    digitalWrite(D, HIGH);
    digitalWrite(G, HIGH);
  }
  else if(key == 4)
  {
    digitalWrite(EFF, HIGH);
    digitalWrite(B, HIGH);
    digitalWrite(C, HIGH);
    digitalWrite(G, HIGH);
  }
  else if(key == 5)
  {
    digitalWrite(A, HIGH);
    digitalWrite(EFF, HIGH);
    digitalWrite(G, HIGH);
    digitalWrite(C, HIGH);
    digitalWrite(D, HIGH);
  }
  else if(key == 6)
  {
    digitalWrite(EFF, HIGH);
    digitalWrite(G, HIGH);
    digitalWrite(C, HIGH);
    digitalWrite(D, HIGH);
    digitalWrite(E, HIGH);
  }
  else if(key == 7)
  {
    digitalWrite(EFF, HIGH);
    digitalWrite(A, HIGH);
    digitalWrite(B, HIGH);
    digitalWrite(C, HIGH);
  }
  else if(key == 8)
  {
    digitalWrite(EFF, HIGH);
    digitalWrite(A, HIGH);
    digitalWrite(B, HIGH);
    digitalWrite(C, HIGH);
    digitalWrite(D, HIGH);
    digitalWrite(E, HIGH);
    digitalWrite(G, HIGH);
  }
  else if(key == 9)
  {
    digitalWrite(A, HIGH);
    digitalWrite(B, HIGH);
    digitalWrite(C, HIGH);
    digitalWrite(EFF, HIGH);
    digitalWrite(G, HIGH);
  }
  else if ((key > 0) || (key < 9))
  {
    digitalWrite(A, LOW);
    digitalWrite(B, LOW);
    digitalWrite(C, LOW);
    digitalWrite(D, HIGH);
    digitalWrite(E, LOW);
    digitalWrite(EFF, LOW);
    digitalWrite(G, LOW);
  }
}
