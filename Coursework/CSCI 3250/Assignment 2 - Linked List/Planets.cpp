// Joseph Spear
// CSCI 3250 - Data Structures and Algorithms
// Assignment 3 - Linked Lists

#include "Planets.h"
#include "LinkedList.hpp"

void Planets::addBack(Planet planet) {
	planets.push_back(planet);
}

void Planets::addFront(Planet planet) {
	planets.push_front(planet);
}

int Planets::getCount() {
	return planets.size();
}

void Planets::removeFront() {
	planets.pop_front();
}

void Planets::removeBack() {
	planets.pop_back();
}

void Planets::DESTRUCTION() {
	planets.~LinkedList();
}