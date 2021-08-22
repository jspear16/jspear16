/**
 *  Joseph Spear
 *  12 July 2021
 *  Project to Produce a basic Radar image using the SG90 Servo Motor and HCSR04 Sensors
 * 
 */

// Includes
#include<Servo.h>


// Definitions

/**
 *  \def SAMPLESIZE
 *  \brief This is the amount of steps the servo will go through from start to finish of sweep
 */
#define SAMPLESIZE 120

/**
 * \def TRIGPIN
 * \brief The Trig Pin on the HCSR04 Ultrasonic Sensor
 */
#define TRIGPIN 11

/**
 * \def ECHOPIN
 * \brief The Echo Pin on the HCSR04 Ultrasonic Sensor
 */
#define ECHOPIN 12

/**
 * \def SERVOPIN
 * \brief The PWM Servo Pin on the SG90 Microservo Ultrasonic Sensor
 */
#define SERVOPIN 10

/**
 *  \var GS90_Servo
 *  \brief This is the Servo object related to the GS90 Micro servo
 */
Servo GS90_servo;

/**
 *  \var pos
 *  \brif Variable to store the position of the Servo
 */

int pos = 0;

/**
 * \var distance
 * \brief Distance calculated by the HCSR04 Ultrasonic Sensor
 */
 
int distance = 0;
int distHistory[SAMPLESIZE];
int avgDistHistory = 0;


void setup() {
  // Starts the serial communication
  Serial.begin(9600); 
  // Sets the trigPin as an Output
  pinMode(trigPin, OUTPUT);
  // Sets the echoPin as an Input 
  pinMode(echoPin, INPUT);
  // Set the servo to servoPin
  GS90_servo.attach(servoPin);

  pos = GS90_servo.read();
  while(pos > 0)
  {
    pos--;
    GS90_servo.write(pos);
    delay(60);
  }
  

  if (ultraSonicDistance() > 0)
  {
    distance = ultraSonicDistance();
    for(int i = 0; i < 10; i++)
    {
      distHistory[i] = distance;
      avgDistHistory += distance;
    }
    avgDistHistory = avgDistHistory/10;

  }

  
}

void loop() {
  // Sweeping forward ------------------------------------------
  
  for (pos = 30; pos < 150; pos++)
  {
    // Write the new position to the Servo
    GS90_servo.write(pos);
    delay(15);    
    
    // Recieve incoming HCSR04 distance and Write to Serial Port 
    distance = ultraSonicDistance();
    if (distance == 0)
    {
      distance = avgDistHistory;
    }
    
    Serial.print(pos);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");

    distHistory[pos%10] = distance;
    for(int i = 0; i < 10; i++)
    {
      avgDistHistory += distHistory[i];
    }
    avgDistHistory = avgDistHistory/10;
  }

  // Sweeping backwards ----------------------------------------
  for (pos = 150; pos > 30; pos--)
  {
    // Write the new position to the Servo
    GS90_servo.write(pos);
    delay(15);
    
    // Recieve incoming HCSR04 distance and Write to Serial Port 
    distance = ultraSonicDistance();
    if (distance == 0)
    {
      distance = avgDistHistory;
    }
    
    Serial.print(pos);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");

    distHistory[pos%10] = distance;
    for(int i = 0; i < 10; i++)
    {
      avgDistHistory += distHistory[i];
    }
    avgDistHistory = avgDistHistory/10;
  }  
 
}

/* ******************************************************************************************************
 *                                             Functions                                                *
 ********************************************************************************************************/


/**
 *  \fn Init_Sample_Size
 *  \brief A simple function to initialize the entire History array to be 0
 */
void Init_Sample_Size() 
{
  
}


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
  duration = pulseIn(echoPin, HIGH, 200000);

  // Calculating the distance in cm
  distance= duration*0.034/2;

  return distance;
}
