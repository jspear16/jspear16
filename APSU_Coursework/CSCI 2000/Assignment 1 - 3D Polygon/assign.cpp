// Joseph Spear
// A Program to Calculate Information on Polygons
// CSCI - 2000 Assignment 1
// Visual Studios 2017

#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;

int main() {

	// Intro. Will only occure once.
	cout << "Hola! My name is Joseph Spear, and I will calculate the Surface Area and Volume of various 3-d polygons." << endl;
	bool  big_loop = true;

	// This While loop is for the entire program to be restarted. Used for doing it more than once.

	while (big_loop == true) {

		int ans1;
		double const pi = 3.14159265359;
		bool loop1 = true;

		cout << fixed << setprecision(4); // Set to display to the 4th decimal point for whole program.

		// Ask User for a choice. Will redo if value is invalid.
		while (loop1 == true) {
			cout << "Which 3-d Polygon would you like for me to analyze? (Pick 1-4)" << endl << endl 
				<< " 1 - Octahedron" << endl
				<< " 2 - Right Circular Cone" << endl
				<< " 3 - Sphere" << endl
				<< " 4 - Cube" << endl;
			cout << "Answer: ";
			cin >> ans1;
			cout << endl;

			// Repeat if invalid input.
			if (ans1 <= 0 || ans1 > 4) {
				cout << "Sorry, I don't understand that. Can you repeat your answer?" << endl; 
			}
			else {
				loop1 = false;
			}
		}

		// The following if-else chain is for the outputs of ans1. \\

		// ------------------------ Octahedron ------------------------------

		if (ans1 == 1) {
			cout << "You picked an Octahedron." << endl;
			int loop2 = true;
			int ans2;

			while (loop2 == true) {
				cout << "Would you like me to calculate Surface Area, Volume, or both? (Pick 1-3)" << endl << endl;   // Ask for a choice.
				cout << " 1 - Surface Area" << endl
					<< " 2 - Volume" << endl
					<< " 3 - Both Surface Area and Volume" << endl;
				cout << "Answer: ";
				cin >> ans2;
				cout << endl;

				// Check if input is invalid
				if (ans2 <= 0 || ans2 > 3) {
					cout << "Sorry, I don't understand that. Can you repeat your answer?" << endl;
				}
				else {
					loop2 = false;
				}
			}
				cout << "Can you give me the length of one of the sides of the Octahedron in inches? "; // Asking for Length
				double length;
				cout << "Length: ";
				cin >> length;
				double Vol = (sqrt(2)*pow(length, 3)) / 3; // Calculating Volume
				double SA = 2 * sqrt(3)*pow(length, 2);   // Calculating Surface Area

				if (ans2 == 1) {
					cout << "The Surface Area of this Octahedron is: " << SA << " in^2" << endl << endl; // Display Surface Area
				}
				else if (ans2 == 2) {
					cout << "The Volume of this Octahedron is: " << Vol << " in^3" << endl << endl; // Display Volume
				}
				else if (ans2 == 3) {
					cout << "The Surface Area of this Octahedron is: " << SA << " in^2" << " and the Volume is " << Vol << " in^3" << endl << endl; // Display Volume and Surface Area
				}
			
		}

		// ------------------------ Cone ------------------------------

		else if (ans1 == 2) {
			cout << "You picked a Right Circular Cone" << endl;
			int loop2 = true;
			int ans2;

			while (loop2 == true) {
				cout << "Would you like me to calculate Surface Area, Volume, or both? (Pick 1-3)" << endl << endl;   // Ask for a choice.
				cout << " 1 - Surface Area" << endl
					<< " 2 - Volume" << endl
					<< " 3 - Both Surface Area and Volume" << endl;
				cout << "Answer: ";
				cin >> ans2;
				cout << endl;

				// Check if input is invalid
				if (ans2 <= 0 || ans2 > 3) {
					cout << "Sorry, I don't understand that. Can you repeat your answer?" << endl;
				}
				else {
					loop2 = false;
				}
			}
				cout << "Can you give me the radius of the cone and the height in inches? "; // Asking for radius and height
				double radius, height;
				cout << "Radius: ";
				cin >> radius;
				cout << "Height: ";
				cin >> height;
				double Vol = pi * pow(radius, 2)*(height / 3); // Calculating Volume
				double SA = pi * radius*(radius + sqrt(pow(height, 2) + pow(radius, 2)));   // Calculating Surface Area

				if (ans2 == 1) {
					cout << "The Surface Area of this Right Circular Cone is: " << SA << " in^2" << endl << endl; // Display Surface Area
				}
				else if (ans2 == 2) {
					cout << "The Volume of this Right Circular Cone is: " << Vol << " in^3" << endl << endl; // Display Volume
				}
				else if (ans2 == 3) {
					cout << "The Surface Area of this Right Circular Cone is: " << SA << " in^2" << " and the Volume is " << Vol << " in^3" << endl << endl; // Display Volume and Surface Area
				}
			
		}

		// ------------------------ Sphere ------------------------------

		else if (ans1 == 3) {
			cout << "You picked a Sphere" << endl;
			int loop2 = true;
			int ans2;

			while (loop2 == true) {
				cout << "Would you like me to calculate Surface Area, Volume, or both? (Pick 1-3)" << endl << endl;   // Ask for a choice.
				cout << " 1 - Surface Area" << endl
					<< " 2 - Volume" << endl
					<< " 3 - Both Surface Area and Volume" << endl;
				cout << "Answer: ";
				cin >> ans2;
				cout << endl;

				// Check if input is invalid
				if (ans2 <= 0 || ans2 > 3) {
					cout << "Sorry, I don't understand that. Can you repeat your answer?" << endl;
				}
				else {
					loop2 = false;
				}
			}
				cout << "Can you give me the radius of the sphere in inches? "; // Asking for radius
				double radius;
				cout << "Radius: ";
				cin >> radius;
				double Vol = (4 / 3)*pi*pow(radius, 3); // Calculating Volume
				double SA = 4 * pi*pow(radius, 2);   // Calculating Surface Area

				if (ans2 == 1) {
					cout << "The Surface Area of this Sphere is: " << SA << " in^2" << endl << endl; // Display Surface Area
				}
				else if (ans2 == 2) {
					cout << "The Volume of this Sphere is: " << Vol << " in^3" << endl << endl; // Display Volume
				}
				else if (ans2 == 3) {
					cout << "The Surface Area of this Sphere is: " << SA << " in^2" << " and the Volume is " << Vol << " in^3" << endl << endl; // Display Volume and Surface Area
				}
			
		}

		// ------------------------ Cube ------------------------------

		else {
			cout << "You picked a Cube" << endl;
			int loop2 = true;
			int ans2;

			while (loop2 == true) {
				cout << "Would you like me to calculate Surface Area, Volume, or both? (Pick 1-3)" << endl << endl;   // Ask for a choice.
				cout << " 1 - Surface Area" << endl
					<< " 2 - Volume" << endl
					<< " 3 - Both Surface Area and Volume" << endl;
				cout << "Answer: ";
				cin >> ans2;
				cout << endl;

				// Check if input is invalid
				if (ans2 <= 0 || ans2 > 3) {
					cout << "Sorry, I don't understand that. Can you repeat your answer?" << endl;
				}
				else {
					loop2 = false;
				}
			}
				cout << "Can you give me the length of one of the sides of the Cube in inches? "; // Asking for Length
				double length;
				cout << "Length: ";
				cin >> length;
				double Vol = (sqrt(2)*pow(length, 3)) / 3; // Calculating Volume
				double SA = 2 * sqrt(3)*pow(length, 2);   // Calculating Surface Area

				if (ans2 == 1) {
					cout << "The Surface Area of this Cube is: " << SA << " in^2" << endl << endl; // Display Surface Area
				}
				else if (ans2 == 2) {
					cout << "The Volume of this Cube is: " << Vol << " in^3" << endl << endl; // Display Volume
				}
				else if (ans2 == 3) {
					cout << "The Surface Area of this Cube is: " << SA << " in^2" << " and the Volume is " << Vol << " in^3" << endl << endl; // Display Volume and Surface Area
				}
			
		}

		// --------------Ask to try again ---------------\\

		cout << "Would you like to do another 3-d Polygon? (1 - Yes, 2 - No): ";
		int ans3;
		int loop3 = true;
		cin >> ans3;
		while (loop3 == true) {

			// Check if input is invalid
			if (ans3 <= 0 || ans3 > 2) {
				cout << "Sorry, I don't understand that. Can you repeat your answer?" << endl;
			}
			else {
				loop3 = false;
			}
		}

		// This will end the program instead of repeat.
		if (ans3 == 2) {
			cout << "Ok, thank you for calculating polygons with Joseph Spear!" << endl << endl;
			big_loop = false;
		}

		// This repeats the program.
		else {
			cout << "Ok cool!" << endl << endl;
		}
	}
	system("pause");
	return 0;
}