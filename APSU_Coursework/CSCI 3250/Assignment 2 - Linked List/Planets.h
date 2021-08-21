// Joseph Spear
// CSCI 3250 - Data Structures and Algorithms
// Assignment 3 - Linked Lists

#pragma once
#include "LinkedList.hpp"
#include "Planet.h"

class Planets {
private:
	LinkedList<Planet> planets;
public:
	void addBack(Planet);
	void addFront(Planet);
	void removeBack();
	void removeFront();
	void DESTRUCTION();
	int getCount();

};