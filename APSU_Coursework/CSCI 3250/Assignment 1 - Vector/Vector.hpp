// Joseph Spear
// CSCI - 3250 Data Structures and Algorithms
// Assignment 1 - Planets

#pragma once // missing this

template <class T>
class Vector {
private:
	T* mData;
	int mCapacity;
	int mSize;

	void resizeArray(int);
public:
	Vector() {
		mSize = 0;
		mCapacity = 10;
		mData = new T[10];
	}
	Vector(const Vector& object) { // forgot the word object here
		mData = new T[object.mCapacity];
		mCapacity = object.mCapacity;
		mSize = object.mSize;

		for (int i = 0; i < mSize; i++) {
			mData[i] = object.mData[i];
		}
	}

	int size();
	void push_back(const T);
	T& operator[](int);      // Write
	const T& operator[](int) const; // Read
};

//template <class T>
//T Vector<T>::Vector() {
//	mSize = 0;
//	mCapacity = 10;
//	mData = new T[10];
//}

//template <class T>
//Vector<T>::Vector(const Vector& object) {
//
//	mData = new T[object.mCapacity];
//	mCapacity = object.mCapacity;
//	mSize = object.mSize;
//
//	for (int i = 0; i < mSize; i++) {
//		mData[i] = object.mData[i];
//	}
//}

template <class T>
int Vector<T>::size() {
	return mSize;
}

template <class T>
void Vector<T>::resizeArray(int size) {
	T* mDataNew = new T[2 * size];
	for (int i = 0; i < size; i++) {
		mDataNew[i] = mData[i];
	}
	delete[] mData;
	mData = mDataNew;
	mCapacity = 2 * size;
}

template <class T>
void Vector<T>::push_back(const T value) {
	if (mSize >= mCapacity) {
		resizeArray(mCapacity);
	}

	mData[mSize] = value;
	mSize++;
}

template <class T>
T& Vector<T>::operator[](int index) {
	return mData[index];
}

template <class T>
const T& Vector<T>::operator[](int index) const {
	return mData[index];
}