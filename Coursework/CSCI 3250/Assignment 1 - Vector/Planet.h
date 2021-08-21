// Joseph Spear
// CSCI - 3250 Data Structures and Algorithms
// Assignment 1 - Planets

#pragma once
#include <string>

using namespace std;

class Planet {
private:
	string mName;
	string mMadeOf;
	int mPop;
public:
	Planet();
	Planet(string, string, int);

	string getName() const;
	string getMadeOf() const;
	int getAlienPopulation() const;

};