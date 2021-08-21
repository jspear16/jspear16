// Joseph Spear
// CSCI - 2000 Assignment 2
// Making circles, lemniscate, and rose.
// Visual Studios 2017

#include <iostream>
#include <cmath>
#include <string>
#include <fstream>

using namespace std;

int main() {
	cout << "Hello, my name is Joseph Spear, and I will Stitch some curves for you." << endl;   // Intro
	cout << "This is for the first image." << endl << "----------------------------" << endl;
	// The following blocks of code ask for various inputs and then check to see if the statement is valid, asking again if input is invalid. \\

	for (int i = 1; i <= 3; i++) {
		cout << endl << "First, please input an integer that represents the number of points that will be used (Greater than 3): ";
		int n;
		do {
			cin >> n;
			if (n <= 3) {
				cout << "I'm sorry, I don't understand that, please try again: ";
			}
			else {
				break;
			}
		} while (1); // This code checks user input for the number of points and continues to ask until a proper integer is given.

		cout << "Next, please input an integer that represents the number of times to go around the shape (Greater than 0): ";
		int r;
		do {
			cin >> r;
			if (r <= 0) {
				cout << "I'm sorry, I don't understand that, please try again: ";
			}
			else {
				break;
			}
		} while (1); // This code checks user input for the repetitions and continues to ask until a proper integer is given.

		cout << "Next, please input the multiplier for the second point (Greater than 0): ";
		double k;
		do {
			cin >> k;
			if (k <= 0) {
				cout << "I'm sorry, I don't understand that, please try again: ";
			}
			else {
				break;
			}
		} while (1); // This code checks user input for the multiplier and continues to ask until a proper double is given.

		cout << "Next, please input the type of curve you want (circle, lemniscate, or rose): ";
		string curve;
		do {
			cin >> curve;
			if (curve != "circle" && curve != "lemniscate" && curve != "rose") {
				cout << curve;
				cout << "I'm sorry, I don't understand that, please try again: ";
			}
			else {
				break;
			}
		} while (1); // This code checks user input for the type of curve and continues to ask until a proper string is given.

		cout << "Next, please input thickness of the line segments (Greater than or equal to 0.05): ";
		double lineThick;
		do {
			cin >> lineThick;
			if (lineThick < 0.05) {
				cout << "I'm sorry, I don't understand that, please try again: ";
			}
			else {
				break;
			}
		} while (1); // This code checks user input for the line thickness and continues to ask until a proper double is given.

		cout << "Next, please input the type of color of the lines (red, blue, black, orange, green, pink, or brown): ";
		string color;
		do {
			cin >> color;
			if (color != "red" && color != "blue" && color != "black" && color != "orange" && color != "green" && color != "pink" && color != "brown") {
				cout << "I'm sorry, I don't understand that, please try again: ";
			}
			else {
				break;
			}
		} while (1); // This code checks user input for the color and continues to ask until a proper string is given.

		cout << "Next, please input whether or not points will be shown on the figure (red, blue, black, none): ";
		string point;
		do {
			cin >> point;
			if (point != "red" && point != "blue" && point != "black" && point != "none") {
				cout << "I'm sorry, I don't understand that, please try again: ";
			}
			else {
				break;
			}
		} while (1); // This code checks user input for the point and continues to ask until a proper string is given.

		// cout << endl << endl << n << endl << reps << endl << k << endl << curve << endl << lineThick << endl << color << endl << point << endl;
		// Test to see if all the values came through properly. ^^^

		// Constant variables which are going to be used later.
		const int height = 800;
		const int width = 800;
		const int cx = 400;
		const int cy = 400;
		const int radius = 390;
		const double pi = 3.14159265359;

		if (curve == "circle") {

			ofstream curve;                                      // Builds the code for the Circle Curve.
			curve.open("curve.svg");
			curve << "<svg xmlns='http://www.w3.org/2000/svg' width='" << width << "' height='" << height << "' version='1.1'>" << endl;


			int reps = 1;
			do {                                             // Plots the first line and then checks if their are more repetitions it should use.
				for (int N = 1; N <= n; N++) {

					// Declaring initial and final points of the line
					double x1 = radius * cos(reps*N*((2 * pi) / (n))) + cx;
					double y1 = radius * sin(reps*N*((2 * pi) / (n))) + cy;

					double x2 = radius * cos(reps*k * N * ((2 * pi) / (n))) + cx;
					double y2 = radius * sin(reps*k * N * ((2 * pi) / (n))) + cy;

					// cout << "N = " << N << endl << x1 << endl << y1 << endl << x2 << endl << y2 << endl << endl;
					// This Test was used to make sure the coordinates are calculated correctly. ^^^^

					curve << "<line x1='" << x1 << "' y1='" << y1 << "' x2='" << x2 << "' y2='" << y2 << "' stroke='" << color << "' stroke-width='" << lineThick << "' />" << endl;
					curve << "<circle cx='" << x1 << "' cy='" << y1 << "' r='2' stroke='black' stroke-width='0' fill='" << point << "' />" << endl;

				}
				reps++;
			} while (reps <= r);
			curve << "</svg>" << endl;
			curve.close();
		}

		else if (curve == "lemniscate") {

			ofstream curve;                        // Builds the code for the lemniscate Curve.
			curve.open("curve.svg");
			curve << "<svg xmlns='http://www.w3.org/2000/svg' width='" << width << "' height='" << height << "' version='1.1'>" << endl;


			int reps = 1;
			do {                                  // Plots the first line and then checks if their are more repetitions it should use.
				for (int N = 1; N <= n; N++) {

					// Declaring initial and final points of the line
					double x1 = (radius*cos(reps*N*((2 * pi) / (n)))) / (1 + pow(sin(reps*N*((2 * pi) / (n))), 2)) + cx;
					double y1 = (radius*cos(reps*N*((2 * pi) / (n)))*sin(reps*N*((2 * pi) / (n)))) / (1 + pow(sin(reps*N*((2 * pi) / (n))), 2)) + cy;

					double x2 = (radius*cos(reps*N*k*((2 * pi) / (n)))) / (1 + pow(sin(reps*N*k*((2 * pi) / (n))), 2)) + cx;
					double y2 = (radius*cos(reps*N*k*((2 * pi) / (n)))*sin(reps*N*k*((2 * pi) / (n)))) / (1 + pow(sin(reps*N*k*((2 * pi) / (n))), 2)) + cy;

					// cout << "N = " << N << endl << x1 << endl << y1 << endl << x2 << endl << y2 << endl << endl;
					// This Test was used to make sure the coordinates are calculated correctly. ^^^^

					curve << "<line x1='" << x1 << "' y1='" << y1 << "' x2='" << x2 << "' y2='" << y2 << "' stroke='" << color << "' stroke-width='" << lineThick << "' />" << endl;
					curve << "<circle cx='" << x1 << "' cy='" << y1 << "' r='2' stroke='black' stroke-width='0' fill='" << point << "' />" << endl;

				}
				reps++;
			} while (reps <= r);
			curve << "</svg>" << endl;
			curve.close();
		}

		else {

			ofstream curve;                     // Builds the code for the Rose Curve.
			curve.open("curve.svg");
			curve << "<svg xmlns='http://www.w3.org/2000/svg' width='" << width << "' height='" << height << "' version='1.1'>" << endl;


			int reps = 1;
			do {                                           // Plots the first line and then checks if their are more repetitions it should use.
				for (int N = 1; N <= n; N++) {

					// Declaring initial and final points of the line
					double x1 = radius * cos(reps * 8 * N*((2 * pi) / (n)))*cos(reps*N*((2 * pi) / (n))) + cx;
					double y1 = radius * cos(reps * 8 * N*((2 * pi) / (n)))*sin(reps*N*((2 * pi) / (n))) + cy;

					double x2 = radius * cos(reps * 8 * k * N * ((2 * pi) / (n)))* cos(reps*k * N * ((2 * pi) / (n))) + cx;
					double y2 = radius * cos(reps * 8 * k * N * ((2 * pi) / (n)))*sin(reps*k * N * ((2 * pi) / (n))) + cy;

					// cout << "N = " << N << endl << x1 << endl << y1 << endl << x2 << endl << y2 << endl << endl;
					// This Test was used to make sure the coordinates are calculated correctly. ^^^^

					curve << "<line x1='" << x1 << "' y1='" << y1 << "' x2='" << x2 << "' y2='" << y2 << "' stroke='" << color << "' stroke-width='" << lineThick << "' />" << endl;
					curve << "<circle cx='" << x1 << "' cy='" << y1 << "' r='2' stroke='black' stroke-width='0' fill='" << point << "' />" << endl;

				}
				reps++;
			} while (reps <= r);
			curve << "</svg>" << endl;
			curve.close();
		}

		cout << endl << "Your image was created!" << endl << endl;    // Confirmation that the SVG file was created.

		// Indicator to help show which image you are creating.
		if (i == 1) {
			cout << "Reminder, your next image will overwrite the previous one!" << endl;
			cout << "This is for the second image." << endl << "----------------------------" << endl;
		}
		else if (i == 2) {
			cout << "Reminder, your next image will overwrite the previous one!" << endl;
			cout << "This is for the third image." << endl << "----------------------------" << endl;
		}
	}
	cout << "Thank you for stitching curves with Joseph Spear!" << endl;   // Conclusion
	system("pause");
	return 0;
}