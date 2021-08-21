// Joseph Spear
// CSCI - 2000 Assignment 4
// This Project will create a Portable Pixmap Image
// Visual Studios 2017


#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include "PPMImage.h"

using namespace std;

int main() {
	cout << "Hello, my name is Joseph Spear and I will make a PPM thingy magigi for you." << endl;
	cout << "Please give the input image: ";
	string input;
	cin >> input;

	PPMImage Test(input);

	cout << "Cool, and what do you want to call the output image: ";
	string output;
	cin >> output;

	cout << "Sweet! What operation do you want to use on it?\n"
		<< "1) Blandify (Convert to Gray Scale)\n"
		<< "2) Flip (Flip it Horizontally)\n"
		<< "3) Flop (Flip it Vertically)\n"
		<< "4) Twist (Rotate it 90 degrees clockwise)\n"
		<< "5) Un-Twist (Rotate it 90 degrees counterclockwise)\n"
		<< "6) Biggify (Double its Size)\n"
		<< "7) Un-Biggify (Half its Size)\n";
	int choice;
	do {
		cout << "Enter Choice: ";
		cin >> choice;

		if (choice > 0 && choice < 8) {
			break;
		}
		else {
			cout << "Sorry, that is an invalid answer. Please pick again!\n";
		}
	} while (1);

	if (choice == 1) {
		Test.toGrayScale(output);
	}
	else if (choice == 2) {
		Test.flipHorizontal(output);
	}
	else if (choice == 3) {
		Test.flipVertical(output);
	}
	else if (choice == 4) {
		Test.rotateClockwise(output);
	}
	else if (choice == 5) {
		Test.rotateCounterClockwise(output);
	}
	else if (choice == 6) {
		Test.doubleSize(output);
	}
	else {
		Test.halfSize(output);
	}
	
	cout << endl << "All Done! Go check it out in the folder where this program is located.\nThank you for using the PPM thingy magigi with Joseph Spear!" << endl;

	system("pause");
}