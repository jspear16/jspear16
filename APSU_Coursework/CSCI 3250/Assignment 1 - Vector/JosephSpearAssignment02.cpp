// Joseph Spear
// CSCI - 3250 Data Structures and Algorithms
// Assignment 2 - Vector

#include <iostream>
#include "Planet.h"
#include "Planets.h"

using namespace std;

string promptName();
string promptMadeOf();
int promptPop();

int main() {

	cout << "Hello! This program will create Planets and give you information about them!" << endl;
	Planets solarSystem;

	do {
		int ans1;
		cout << "What would you like to do? \n 1) Add a Planet \n 2) Show the number of planets you already have? \n"
			<< " 3) Get the most populated Planet? \n 4) Get a specific Planets information? \n 5) Exit the program." << endl << endl;

		do {
			cout << "Answer: ";
			cin >> ans1;
			if (ans1 != 1 && ans1 != 2 && ans1 != 3 && ans1 != 4 && ans1 != 5) {
				cout << "You input an invalid number! Please try again.\n\n";
			}
			else if (ans1 == 1) {
				string newName, newMadeOf;
				int newPop;

				newName = promptName();
				newMadeOf = promptMadeOf();
				newPop = promptPop();

				solarSystem.addPlanet(Planet(newName, newMadeOf, newPop));

				cout << "Your new planet has been made!\n\n";
				break;
			}
			else if (ans1 == 2) {
				if (solarSystem.getCount() == 0) {
					cout << "There are no planets in your list." << endl;
				}
				else {
					cout << "There are " << solarSystem.getCount() << " planets in your solar system!\n\n";
				}

				break;
			}
			else if (ans1 == 3) {
				if (solarSystem.getCount() == 0) {
					cout << "There are no planets in your list." << endl;
				}
				else {
					cout << "The planet with the largest population is\nName: "
						<< solarSystem.getMostPopulatedPlanet().getName() << "\nMaterial: "
						<< solarSystem.getMostPopulatedPlanet().getMadeOf() << "\nPopulation: "
						<< solarSystem.getMostPopulatedPlanet().getAlienPopulation() << endl;
				}

				break;
			}
			else if (ans1 == 4) {
				int ans2;
				if (solarSystem.getCount() == 0) {
					cout << "There are no planets in your list." << endl;
				}
				else {
					cout << "There are " << solarSystem.getCount() << " planets in your solar system.\nPlease pick a number between 1 and " <<
						solarSystem.getCount() << " to indicate which planet you want to learn more of.\nAnswer: ";

					cin >> ans2;

					cout << "Name: " << solarSystem.get(ans2).getName() << endl;
					cout << "Material: " << solarSystem.get(ans2).getMadeOf() << endl;
					cout << "Alien Population: " << solarSystem.get(ans2).getAlienPopulation() << endl;
				}

				break;
			}
			else if (ans1 == 5) {
				cout << "Good bye!\n\n";
				break;
			}
		} while (true);
		if (ans1 == 5) {
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