// Joseph Spear
// CSCI 3250 - Data Structures and Algorithms
// Assignment 3 - Linked Lists

#ifndef LinkedList_HPP
#define LinkedList_HPP
#include <iostream>

using namespace std;

template<typename T>
class LinkedList {
private:
	template<typename T>
	struct Node {
		T mData;
		Node<T>* next;
		Node<T>* prev;

	};

	Node<T>* mHead;          // Data Members
	Node<T>* mTail;
	int mSize;

	void clear();
	void copy(const LinkedList& list);
	bool checkForEmptyList();
public:
	LinkedList();                  // Constructor
	LinkedList(const LinkedList&);   // Copy Constructor

	~LinkedList();				   // Destructor

	bool isEmpty();
	LinkedList& operator=(const LinkedList&);   // Operator Overload of =
	int size() const;
	void push_back(const T);
	void push_front(const T);
	T pop_back();
	T pop_front();


};


// Private Member Functions

template<typename T>
void LinkedList<T>::clear() {
	while (mHead != nullptr) {
		pop_front();
	}
}

template<typename T>
void LinkedList<T>::copy(const LinkedList& oldList) {
	clear();
	mSize = oldList.mSize;

	Node<T>* newNode = oldList.mHead;

	if (!newNode) {
		return;
	}

	mTail = mHead = new Node<T>{ oldList.mHead->data, nullptr, nullptr };

	while (newNode->next) {
		newNode = newNode->next;
		mTail = mTail->next = new Node<T>{ newNode->data,nullptr,mTail };
	}
}

template<typename T>
bool LinkedList<T>::checkForEmptyList() {
	if (mSize == 0) {
		return true;
	}
	else {
		return false;
	}
}

// Public Member Functions

	//Constructors / Destructors-----------------------------------------

template<typename T>
LinkedList<T>::LinkedList() {
	mHead = nullptr;
	mTail = nullptr;
	mSize = 0;
}

template<typename T>
LinkedList<T>::LinkedList(const LinkedList& oldList) {
	copy(oldList);
}

template<typename T>
LinkedList<T>::~LinkedList() {
	while (mSize > 0) {
		clear();
	}
}

	// Other Member Functions---------------------------------

template<typename T>
bool LinkedList<T>::isEmpty() {
	return checkForEmptyList();
}

template<typename T>
LinkedList<T>& LinkedList<T>::operator=(const LinkedList& oldList) {
	clear();
	mSize = oldList.mSize;

	Node<T>* temp = oldList.mHead;

	if (!temp) {
		return;
	}

	mTail = mHead = new Node<T>{ oldList.mHead->data, nullptr, nullptr };

	while (temp->next) {
		temp = temp->next;
		mTail = mTail->next = new Node<T>{ temp->data,nullptr,mTail };
	}
	return *this;
}

template<typename T>
int LinkedList<T>::size() const {
	return mSize;
}

template<typename T>
void LinkedList<T>::push_back(const T data) {
	Node<T>* newNode = new Node<T>;
	newNode->mData = data;
	newNode->next = nullptr;
	newNode->prev = nullptr;

	if (checkForEmptyList()) {
		mHead = newNode;
		mTail = newNode;

	}

	else {
		newNode->prev = mTail;
		newNode->mData = data;
		mTail->next = newNode;
		mTail = newNode;

		//mHead->next = newNode;

	}
	mSize++;
}

template<typename T>
void LinkedList<T>::push_front(const T data) {
	Node<T>* newNode = new Node<T>;
	newNode->mData = data;
	newNode->next = nullptr;
	newNode->prev = nullptr;

	if (checkForEmptyList()) {
		mHead = newNode;
		mTail = newNode;
	}
	else {
		newNode->next = mHead;
		newNode->mData = data;
		mHead->prev = newNode;
		mHead = newNode;
	}
	mSize++;
}

template<typename T>
T LinkedList<T>::pop_back() {
	if (checkForEmptyList()) {
		throw std::logic_error("You cannot remove something if nothing is there!");
	}
	T data = mTail->mData;
	if (mSize == 1) {
		delete mTail;
		mHead = mTail = nullptr;
	}
	else {
		mTail = mTail->prev;
		delete mTail->next;
		mTail->next = nullptr;
	}
	mSize--;
	return data;
}

template<typename T>
T LinkedList<T>::pop_front() {
	if (checkForEmptyList()) {
		throw std::logic_error("You cannot delete something when nothing is there!");
	}
	T data;
	if (mSize == 1) {
		data = mHead->mData;
		delete mHead;
		mHead = mTail = nullptr;
	}
	else {
		data = mHead->mData;
		mHead = mHead->next;
		delete mHead->prev;
		mHead->prev = nullptr;
	}
	mSize--;
	return data;
}


#endif