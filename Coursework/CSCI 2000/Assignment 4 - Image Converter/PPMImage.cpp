#include "PPMImage.h"


PPMImage::PPMImage(string ppmFilename) {
	ifstream datain;
	datain.open(ppmFilename);

	string ppmHeader;
	datain >> ppmHeader;

	int height, width;
	datain >> width >> height;

	mheight = height;
	mwidth = width;

	int randomthing;
	datain >> randomthing;

	int r, g, b;
	for (int row = 0; row < height; row++) {
		for (int col = 0; col < width; col++) {
			datain >> r >> g >> b;
			mred.push_back(r);
			mgreen.push_back(g);
			mblue.push_back(b);
		}
	}


	datain.close();
}

void PPMImage::toGrayScale(string filename) {
	ofstream dataout;
	dataout.open(filename);

	dataout << "P3\n" << mwidth << ' ' << mheight << endl << "255" << endl;

	for (int row = 0; row < mheight; row++) {
		for (int col = 0; col < mwidth; col++) {
			int i = row * mwidth + col;

			int grayValue = 0.21 * mred[i]
				+ 0.72 * mgreen[i]
				+ 0.07 * mblue[i];

			dataout << grayValue << " "
				<< grayValue << " "
				<< grayValue
				<< endl;
		}
	}



	dataout.close();
}
void PPMImage::flipHorizontal(string filename) {
	ofstream dataout;
	dataout.open(filename);

	dataout << "P3\n" << mwidth << ' ' << mheight << endl << "255" << endl;

	for (int row = mheight - 1; row >= 0; row--) {
		for (int col = 0; col < mwidth; col++) {
			int i = row * mwidth + col;
			dataout << mred[i] << " "
				<< mgreen[i] << " "
				<< mblue[i]
				<< endl;
		}
	}



	dataout.close();
}
void PPMImage::flipVertical(string filename) {
	ofstream dataout;
	dataout.open(filename);

	dataout << "P3\n" << mwidth << ' ' << mheight << endl << "255" << endl;

	for (int row = 0; row < mheight; row++) {
		for (int col = mwidth - 1; col >= 0; col--) {
			int i = row * mwidth + col;
			dataout << mred[i] << " "
				<< mgreen[i] << " "
				<< mblue[i]
				<< endl;
		}
	}



	dataout.close();
}
void PPMImage::rotateClockwise(string filename) {
	ofstream dataout;
	dataout.open(filename);

	dataout << "P3\n" << mheight << ' ' << mwidth << endl << "255" << endl;

	for (int row = mwidth - 1; row >= 0; row--) {
		for (int col = 0; col < mheight; col++) {
			int i = col * mwidth + row;
			dataout << mred[i] << " "
				<< mgreen[i] << " "
				<< mblue[i]
				<< endl;
		}
	}



	dataout.close();
}
void PPMImage::rotateCounterClockwise(string filename) {
	ofstream dataout;
	dataout.open(filename);

	dataout << "P3\n" << mheight << ' ' << mwidth << endl << "255" << endl;

	for (int row = 0; row < mwidth; row++) {
		for (int col = mheight - 1; col >= 0; col--) {
			int i = col * mwidth + row;
			dataout << mred[i] << " "
				<< mgreen[i] << " "
				<< mblue[i]
				<< endl;
		}
	}



	dataout.close();
}
void PPMImage::doubleSize(string filename) {
	ofstream dataout;
	dataout.open(filename);

	dataout << "P3\n" << 2 * mwidth << ' ' << 2 * mheight << endl << "255" << endl;

	for (int row = 0; row < 2 * mheight; row++) {
		for (int col = 0; col < 2 * mwidth; col++) {
			int row1 = (row / 2);
			int col1 = (col / 2);
			int i = row1 * (mwidth)+col1;
			dataout << mred[i] << " "
				<< mgreen[i] << " "
				<< mblue[i]
				<< endl;
		}
	}



	dataout.close();
}
void PPMImage::halfSize(string filename) {
	ofstream dataout;
	dataout.open(filename);

	dataout << "P3\n" << mwidth / 2 << ' ' << mheight / 2 << endl << "255" << endl;

	for (int row = 0; row < mheight / 2; row++) {
		for (int col = 0; col < mwidth / 2; col++) {
			int row1 = (row * 2);
			int col1 = (col * 2);
			int i = row1 * (mwidth)+col1;
			dataout << mred[i] << " "
				<< mgreen[i] << " "
				<< mblue[i]
				<< endl;
		}
	}



	dataout.close();
}