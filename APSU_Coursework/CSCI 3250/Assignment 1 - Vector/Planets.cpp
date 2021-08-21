// Joseph Spear
// CSCI - 3250 Data Structures and Algorithms
// Assignment 2 - Vector

#include "Planets.h"
#include "Vector.hpp"

void Planets::addPlanet(Planet planet) {
	planets.push_back(planet);
}

int Planets::getCount() {
	return planets.size();
}

Planet Planets::getMostPopulatedPlanet() {

	int Maxpop;
	Maxpop = planets[0].getAlienPopulation();
	for (int i = 1; i < planets.size(); i++) {
		if (planets[i].getAlienPopulation() > Maxpop) {
			Maxpop = planets[i].getAlienPopulation();
		}
	}

	for (int i = 0; i < planets.size(); i++) {
		if (planets[i].getAlienPopulation() == Maxpop) {
			return planets[i];
			break;
		}
	}
}

Planet Planets::get(int i) {
	return planets[i-1];
}