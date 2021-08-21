// Joseph Spear
// CSCI - 2000 Assignment 3
// Program to plot shapes onto gnuplot
// Visual Studios 2017

#include <iostream>
#include <cmath>
#include <string>
#include <vector>
#include <fstream>
using namespace std;

// Global Constants
const double PI = 3.14159265359;
const double E = 2.718281828459;
const string GNUPLOT = "C:\\Users\\Spear\\OneDrive\\Desktop\\gnuplot\\bin\\gnuplot.exe";
const string DISPLAY_CMD = "start";


// Function Prototypes
int getCurve();
string getCurveColor();
string getPngFileName();
int getNumPoints();
void circle(vector<double> &, vector<double> &, int, double);
void butterfly(vector<double> &, vector<double> &, int);
void epicycloid(vector<double> &, vector<double> &, int, double, double);
void hypotrochoid(vector<double> &, vector<double> &, int, double, double, double);
void hypocycloid(vector<double> &, vector<double> &, int, double, double);
void writeAndDisplayData(vector<double>, vector<double>, int, string, string);

int main() {
	cout << "DISCLAIMER: This code requires gnuplot to be installed. Path to the gnuplot folder was hard-coded for my machine, and therefore, new images would require changing the gnuplot path in the source code." << endl << endl;
	cout << "Hello, my name is Joseph Spear, and I will produce certain codes onto a file using gnuplot." << endl; // Introduction
	
	// These functions are used to get all the initial needed information from the user
	int curve = getCurve();
	string color =getCurveColor();
	string PnG = getPngFileName();
	int NumPoints = getNumPoints();

	// Coordinates to be passed into the function defining the points of the shape.
	vector<double> Xvec;
	vector<double> Yvec;

	// This else-if chain is determined from the function getCurve and will create the shape the user asked from getCurve. Any additional requriements for a shape...
	// ... are asked in these statements before calling the function for the shape.
	if (curve == 1) {
		double r;
		do {
			cout << "Please input the radius of the circle (Greater than 0): ";
			cin >> r;
			if (r > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		circle(Xvec, Yvec, NumPoints, r);
	}
	else if (curve == 2) {
		double R,r;
		do {
			cout << "Please input the radius of the small circle (Greater than 0): ";
			cin >> r;
			if (r > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		do {
			cout << "Please input the radius of the Figure (Greater than 0): ";
			cin >> R;
			if (R > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		cout << endl;
		epicycloid(Xvec, Yvec, NumPoints, R, r);

	}
	else if (curve == 3) {
		double R, r, d;
		do {
			cout << "Please input the radius of the small circle (Greater than 0): ";
			cin >> r;
			if (r > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		do {
			cout << "Please input the radius of the Figure (Greater than 0): ";
			cin >> R;
			if (R > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		do {
			cout << "Please input the radius of the diameter (Greater than 0): ";
			cin >> d;
			if (d > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		cout << endl;
		hypotrochoid(Xvec, Yvec, NumPoints, R, r, d);
	}
	else if (curve == 4) {
		double R, r;
		do {
			cout << "Please input the radius of the small circle (Greater than 0): ";
			cin >> r;
			if (r > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		do {
			cout << "Please input the radius of the Figure (Greater than 0): ";
			cin >> R;
			if (R > 0) {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);

		cout << endl;
		hypocycloid(Xvec, Yvec, NumPoints, R, r);
	}
	else {
		butterfly(Xvec, Yvec, NumPoints);
	}

	// Calls the function to actually create and display the new graph.
	writeAndDisplayData(Xvec, Yvec, NumPoints, color, PnG);

	cout << "Thank you for making shapes with Joseph Spear!" << endl;
	system("pause");
	return 0;
}

// Function Declarations

// Ask the user for which type of shape, returning the integer value picked by user.
int getCurve() {
	cout << "Which type of graph would you like to make?" << endl;
	cout << "1) Circle \n2) Epicycloid \n3) Hypotrochoid \n4) Hypocycloid \n5) Butterfly \n";
	int curve;
	do {
		cout << "Choice: ";
		cin >> curve;
		cout << endl;
		if (curve > 0 && curve < 6) {
			break;
		}
		else {
			cout << "Sorry, that is an invalid answer, please pick again." << endl;
		}
	} while (1);
	return curve;
}

// Ask the user for the color of the shape which is then used in the function writeAndDisplayData
string getCurveColor() {
		string color;
		do {
			cout << "Enter the curve color of your choice (red, blue, green, black): ";
			cin >> color;
			cout << endl;
			if (color == "red" || color == "blue" || color == "green" || color == "black") {
				break;
			}
			else {
				cout << "Sorry, that is an invalid answer, please pick again." << endl;
			}
		} while (1);
		return color;
}

// Ask the user for the name of the png that will be created from this program, passed to the function writeAndDisplayData
string getPngFileName() {
	cout << "Please input the name of the Png file you will be creating: ";
	
	string PnG;
	cin >> PnG;
	string FileName = PnG + ".png"; // Dr. Nicholson said this was ok.

	cout << endl;
	return FileName;
}

// Ask for the number of points to plot which will be passed into writeAndDisplayData
int getNumPoints() {
	int NumPoints;
	do {
		cout << "Please give me the number of points you would like to use to create your graph (Greater than 1): ";
		cin >> NumPoints;
		if (NumPoints >= 2) {
			break;
		}
		else {
			cout << "Sorry, that is an invalid answer, please pick again." << endl;
		}
	} while (1);
	cout << endl;
	return NumPoints;
}


	// Function Declarations for shapes

// For each of the shape functions, the x and y vectors are passed by reference into the function to allow for them to be plotted by the gnuplot program.
void circle(vector<double> & xvar, vector<double> & yvar, int NumPointsvar, double rvar) {
	for (int i = 0; i < NumPointsvar; i++) {
		double theta = i * 2 * PI / NumPointsvar;
		xvar.push_back(rvar*cos(theta));
	}

	for (int i = 0; i < NumPointsvar; i++) {
		double theta = i * 2 * PI / NumPointsvar;
		yvar.push_back(rvar*sin(theta));
	}
}

void butterfly(vector<double> & xvar, vector<double> & yvar, int NumPointsvar) {
	double argument = 0;
	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = sin(theta)*(pow(E, cos(theta)) - 2 * cos(4 * theta) - pow(sin((theta / 12)), 5));
		xvar.push_back(argument);
	}

	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = cos(theta)*(pow(E, cos(theta)) - 2 * cos(4 * theta) - pow(sin((theta / 12)), 5));
		yvar.push_back(argument);
	}
}

void epicycloid(vector<double> & xvar, vector<double> & yvar, int NumPointsvar, double Rvar, double rvar) {
	double argument = 0;
	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = (Rvar + rvar)*cos(theta) - rvar * cos((theta*(Rvar + rvar)) / rvar);
		xvar.push_back(argument);
	}

	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = (Rvar + rvar)*sin(theta) - rvar * sin((theta*(Rvar + rvar)) / rvar);
		yvar.push_back(argument);
	}
}

void hypotrochoid(vector<double> & xvar, vector<double> & yvar, int NumPointsvar, double Rvar, double rvar, double dvar) {
	double argument = 0;
	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = (Rvar - rvar)*cos(theta) + dvar * cos((theta*(Rvar - rvar)) / rvar);
		xvar.push_back(argument);
	}

	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = (Rvar - rvar)*sin(theta) - dvar * sin((theta*(Rvar - rvar)) / rvar);
		yvar.push_back(argument);
	}
}

void hypocycloid(vector<double> & xvar, vector<double> & yvar, int NumPointsvar, double Rvar, double rvar) {
	double argument = 0;
	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = (Rvar - rvar)*cos(theta) + rvar * cos((theta*(Rvar - rvar)) / rvar);
		xvar.push_back(argument);
	}

	for (int i = 0; i < NumPointsvar; i++) {
		double theta = 2 * i * PI / 180;
		argument = (Rvar - rvar)*sin(theta) - rvar * sin((theta*(Rvar - rvar)) / rvar);
		yvar.push_back(argument);
	}
}

	// Inputing into gnuplot
void writeAndDisplayData(vector<double> xvar, vector<double> yvar, int NumPointsvar, string colorvar, string PnGvar) {

	// The data is given to data.dat which the gnuplot program will read in order for it to plot.
	ofstream data;
	data.open("data.dat");
		for (int i = 0; i < NumPointsvar; i++) {
			data << xvar[i] << " " << yvar[i] << endl;
		}

		data.close();

	// This sets all of the settings such as the color, png name, etc. which gnuplot will then read and plot.
	ofstream plotdata;
	plotdata.open("plot.gnuplot");

	plotdata << "set terminal png size 640, 640 background '#FFFFFF'" << endl;
	plotdata << "set key off" << endl;
	plotdata << "set output '" << PnGvar << "'" << endl << endl;

	plotdata << "set style line 1 linetype rgb '" << colorvar << "'" << endl;
	plotdata << "plot 'data.dat' with lines linestyle 1" << endl;

	plotdata.close();

	// Using the command window to plot and display the newly created graph from gnuplot.
	string plotCmd = GNUPLOT + " plot.gnuplot";
	system(plotCmd.c_str());

	string filename = PnGvar;
	string displayCmd = DISPLAY_CMD + " " + filename;
	system(displayCmd.c_str());
}
