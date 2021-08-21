//Joseph Spear
//CSCI 3250 - Data Structures and Algorithms
//Assignment 4 - Stacks

#include <iostream>
#include <string>
#include "LinkedList.hpp"

using namespace std;


class Stack {
private:
	LinkedList<string> list;

public:
	Stack();
	
	void clear();
	int size() const;
	bool isEmpty() const;
	string top() ;
	string pop();
	void push(string);

};

Stack::Stack() {
	// Empty Constructor
}

void Stack::clear() {
	while (!isEmpty()) {
		list.clear();
	}
}

int Stack::size() const {
	return list.size();
}

bool Stack::isEmpty() const {
	if (size() == 0) {
		return true;
	}
	else {
		return false;
	}
}

string Stack::top()  {
	if (isEmpty()) {
		throw std::logic_error("You cannot remove something if nothing is there!");
	}
	else {
		string data;
		data = pop();
		push(data);
		return data;
	}
}

string Stack::pop() {
	if (isEmpty()) {
		throw std::logic_error("You cannot remove something if nothing is there!");
	}
	else {
		return list.pop_back();
	}
}

void Stack::push(string data) {
	list.push_back(data);
}
