// Joseph Spear
// CSCI 3250 - Data Structures and Algorithms
// Assignment 3 - Linked List

#include "Planet.h"
#include <iostream>
using namespace std;

Planet::Planet() {

}

Planet::Planet(string name, string madeOf, int pop) {
	if (name == "" || madeOf == "" || pop < 0) {
		cout << "This is an invalid Planet." << endl;
	}
	else {
		mName = name;
		mMadeOf = madeOf;
		mPop = pop;
	}
}

string Planet::getName() const {
	return mName;
}

string Planet::getMadeOf() const {
	return mMadeOf;
}

int Planet::getAlienPopulation() const {
	return mPop;
}