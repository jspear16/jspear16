//Joseph Spear
//CSCI 3250 - Data Structures and Algorithms
//Assignment 4 - Stacks

#include <iostream>
#include <string>
#include "InfixToPrefix.hpp"

using namespace std;

int main() {
	string expression;
	int ans;

	do {
		cout << "Please enter the infix math Expression:  ";
		cin >> expression;

		InfixToPrefix conversion(expression);

		cout << "Infix: " << expression << endl;
		cout << "Preifx: " << conversion.toPrefix() << endl << endl;
		cout << "Would you like to try again? Yes = 1, No = 2\n";

		cout << "Answer: ";
		cin >> ans;
		cout << endl;
	} while (ans == 1);

	cout << "See you later!" << endl << endl;

	system("pause");
	return 0;
}