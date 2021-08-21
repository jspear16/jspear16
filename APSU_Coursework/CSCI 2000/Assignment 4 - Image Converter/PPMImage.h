#ifndef PPMIMAGE_H
#define PPMIMAGE_H
#include <vector>
#include <string>
#include <iostream>
#include <fstream>

using namespace std;

class PPMImage {
private:
	int mheight;
	int mwidth;
	vector<int> mred;
	vector<int> mgreen;
	vector<int> mblue;

public:
	PPMImage(string ppmFilename);

	void toGrayScale(string filename);
	void flipHorizontal(string filename);
	void flipVertical(string filename);
	void rotateClockwise(string filename);
	void rotateCounterClockwise(string filename);
	void doubleSize(string filename);
	void halfSize(string filename);

};

#endif PPMIMAGE_H