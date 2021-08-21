// Joseph Spear
// CSCI - 3250 Data Structures and Algorithms
// Assignment 1 - Planets

#pragma once
#include "Vector.hpp"
#include "Planet.h"

class Planets {
private:
	Vector<Planet> planets;
public:
	void addPlanet(Planet);
	int getCount();
	Planet getMostPopulatedPlanet();
	Planet get(int i);
};