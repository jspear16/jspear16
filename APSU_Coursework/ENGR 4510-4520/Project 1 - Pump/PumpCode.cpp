// Joseph Spear
// Program for Pump Project - Engineering Design 1
// This code is used to determine various pieces of information at different times. While the code was not used in the report, 
// it was useful in figuring out information related to the angle and angular velocity of the gear and connecting rod.


#include <iostream>
#include<cmath>

using namespace std;

int main() {

	double omega, pi = 4.0*atan(1), v, diam, rad, theta, len;

	double MaxOmega = 0;
	double Iters[4];
	
	for (int lengthItr = 1; lengthItr < 10; lengthItr++) {
		for (int radiusItr = 1; radiusItr < 10; radiusItr++) {
			for (int pisDiamItr = 1; pisDiamItr < 10; pisDiamItr++) {
				for (int thetaItr = 1; thetaItr < 90; thetaItr++) {
					diam = pisDiamItr / 20.0;
					rad = radiusItr / 10.0;
					theta = thetaItr * pi / 180.0;
					len = lengthItr / 4.0;

					v = (0.2981 * pi * pow(0.0232156, 2) / 4) / (pi * pow(diam, 2) / 4);
					omega = -v / (rad * sin(theta) + (pow(rad, 2) * sin(theta) * cos(theta)) / sqrt(pow(len, 2) - pow(rad * sin(theta), 2)));

					if (abs(omega) > MaxOmega) {
						MaxOmega = abs(omega);
						Iters[0] = len;
						Iters[1] = rad;
						Iters[2] = diam;
						Iters[3] = theta;
						cout << "\n========================New Max!========================\n";
					}

					//cout << "Linkage Length = " << len << "\t Gear Radius = " << rad << "\t Piston Diameter = " << diam << "\t Theta (degrees) = " << theta * 180 / pi << "\t\t Angular Velocity = " << omega << endl;
				}			
			}
		}
		cout << "Length Itter is " << lengthItr << endl;
	}

	cout << "Max Omega = " << MaxOmega << "\nLength = " << Iters[0] << "\nRadius = " << Iters[1] << "\nDiameter = " << Iters[2] << "\nTheta = " << Iters[3] * 180 / pi << endl;

	system("pause");
	return 0;
}