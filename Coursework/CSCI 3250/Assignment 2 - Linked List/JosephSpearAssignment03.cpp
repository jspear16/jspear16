// Joseph Spear
// CSCI 3250 - Data Structures and Algorithms
// Assignment 3 - Linked Lists

#include <iostream>
#include "Planet.h"
#include "Planets.h"

string promptName();
string promptMadeOf();
int promptPop();

using namespace std;

int main() {
	cout << "Hello! This program will create Planets and give you information about them!" << endl;
	Planets solarSystem;

	do {
		int ans1;
		cout << "1) Add 1000 Planets to the end of the list \n" 
			<< "2) Add 1000 Planets to the beginning of the list \n3) Remove the first Planet from the list \n"
			<< "4) Remove the last Planet from the list \n5) Remove every planet from the list (You Monster!) \n"
			<< "6) Get the total Number of Planets \n7) Exit the program." << endl << endl;

		cout << "Answer: ";
		cin >> ans1;
		do {
			if (ans1 != 1 && ans1 != 2 && ans1 != 3 && ans1 != 4 && ans1 != 5
				&& ans1 != 6 && ans1 != 7) {
				cout << "You input an invalid number! Please try again.\n\n";
			}
			else if (ans1 == 1) {
				string newName, newMadeOf;
				int newPop;

				newName = promptName();
				newMadeOf = promptMadeOf();
				newPop = promptPop();

				for (int i = 0; i < 1000; i++) {
					solarSystem.addBack(Planet(newName, newMadeOf, newPop));
				}

				cout << "Your new planet has been made!\n\n";
				break;
			}
			else if (ans1 == 2) {
				string newName, newMadeOf;
				int newPop;

				newName = promptName();
				newMadeOf = promptMadeOf();
				newPop = promptPop();

				for (int i = 0; i < 1000; i++) {
					solarSystem.addFront(Planet(newName, newMadeOf, newPop));
				}

				cout << "Your new planet has been made!\n\n";
				break;
			}

			else if (ans1 == 3) {
				cout << "Goodbye first planet!\n\n";
				solarSystem.removeFront();
				break;
			}
			else if (ans1 == 4) {
				cout << "Goodbye last planet!\n\n";
				solarSystem.removeBack();
				break;
			}
			else if (ans1 == 5) {
				cout << "Are you sure you want to destroy this perfectly innocent list?\n";
				int ans2;
				cout << "Answer (1 = yes/2 = no):";
				cin >> ans2;

				if (ans2 == 1) {
					solarSystem.DESTRUCTION();
					cout << "You terrible person!\n\n";
				}
				else {
					cout << "Ok, you scared me for a minute!\n";
				}
				break;
			}
			else if (ans1 == 6) {
				cout << "The total number of planets in your solar system is " << solarSystem.getCount() << "!\n\n";
				break;
			}
			else if (ans1 == 7) {
				cout << "Good bye!\n\n";
				break;
			}
		} while (true);
		if (ans1 == 7) {
			break;
		}
	} while (true);



	system("pause");
	return 0;
}

string promptName() {
	string newName;
	cout << "What is the name of your new planet?\nPlanet Name: ";

	cin >> newName;

	return newName;
}

string promptMadeOf() {
	string newMadeOf;
	cout << "What is the material the planet is made of?\nMaterial: ";

	cin >> newMadeOf;

	return newMadeOf;
}

int promptPop() {
	int newPop;
	cout << "How many Aliens live on your planet?\nAlien Population (Integer Number): ";

	cin >> newPop;

	return newPop;
}