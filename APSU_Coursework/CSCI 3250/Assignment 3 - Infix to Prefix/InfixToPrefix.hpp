//Joseph Spear
//CSCI 3250 - Data Structures and Algorithms
//Assignment 4 - Stacks

#include <iostream>
#include <string>
#include "Stack.hpp"

using namespace std;

class InfixToPrefix {
private:
	std::string mExpression;
	Stack mOperator;
	Stack mOperand;
public:
	InfixToPrefix(string);
	string toPrefix();

};

InfixToPrefix::InfixToPrefix(string infixExpression) {
	mExpression = infixExpression;
}

string InfixToPrefix::toPrefix() {
	string newExpression;

	string term = ""; // Term represents the operand if it has more than one Token (like xyz being a single operand)

	for (int i = 0; i < mExpression.length(); i++) { //    xyz+c^d/g-h   =   +xyz-/^cdgh
		
		if (mExpression[i] == '(') {
			string str(1, mExpression[i]);
			mOperator.push(str);
			}
			
			// If Token is a operator
			else if (mExpression[i] == '^' || mExpression[i] == '*' || mExpression[i] == '/'
			|| mExpression[i] == '+' || mExpression[i] == '-') {

				// Protecting against string index out of range error
				if (i == 0) {
					return "Invalid Expression!\n\n";
					break;
				}

				// If second Token is an operator
				if (mExpression[i - 1] == '^' || mExpression[i - 1] == '*' || mExpression[i - 1] == '/' ||
					mExpression[i - 1] == '+' || mExpression[i - 1] == '-')
				{
					return "Invalid Expression!\n\n";
					break;
				}
				string newOperand;

				// If the new Token is a ^
				if (mExpression[i] == '^') {
					string str(1, mExpression[i]);
					while (true) {
						if (mOperator.isEmpty()) {
							mOperator.push(str);
							break;
						}
						if (str == mOperator.top()) {
							string temp = mOperand.pop();
							newOperand = mOperator.pop() + mOperand.pop() + temp;
							mOperand.push(newOperand);
						}
						else {
							mOperator.push(str);
							break;
						}
					}
				}

				// If the new Token is a * or /
				else if (mExpression[i] == '*' || mExpression[i] == '/') {
					string str(1, mExpression[i]);
					while (true) {
						if (mOperator.isEmpty()) {
							mOperator.push(str);
							break;
						}
						if (mOperator.top() == "^") {
							string temp = mOperand.pop();
							newOperand = mOperator.pop() + mOperand.pop() + temp;
							mOperand.push(newOperand);
						}
						else if (mOperator.top() == "*" || mOperator.top() == "/") {
							string temp = mOperand.pop();
							newOperand = mOperator.pop() + mOperand.pop() + temp;
							mOperand.push(newOperand);
						}
						else {
							mOperator.push(str);
							break;
						}
					}
				}

				else if (mExpression[i] == '+' || mExpression[i] == '-') {
					string str(1, mExpression[i]);
					while (true) {
						if (mOperator.isEmpty()) {
							mOperator.push(str);
							break;
						}
						if (mOperator.top() == "^") {
							string temp = mOperand.pop();
							newOperand = mOperator.pop() + mOperand.pop() + temp;
							mOperand.push(newOperand);
						}
						else if (mOperator.top() == "*" || mOperator.top() == "/") {
							string temp = mOperand.pop();
							newOperand = mOperator.pop() + mOperand.pop() + temp;
							mOperand.push(newOperand);
						}
						else if (mOperator.top() == "+" || mOperator.top() == "-"){
							string temp = mOperand.pop();
							newOperand = mOperator.pop() + mOperand.pop() + temp;
							mOperand.push(newOperand);
						}
						else {
							mOperator.push(str);
							break;
						}
					}
				}

				// Otherwise, push into operator stack
				else {
					string str(1,mExpression[i]);
					mOperator.push(str);
				}
			}
		
			else if (mExpression[i] == ')') {
				string str(1, mExpression[i]);
				string temp;

				if (mOperator.isEmpty()) {
					return "There are too many right parentheses!\n\n";
					break;
					}
				else {
					while (mOperator.top() != "(") {
						temp = mOperand.pop();
						newExpression = mOperator.pop() + mOperand.pop() + temp;
						mOperand.push(newExpression);
					}
					mOperator.pop();
				}
			}

		// If Token is not an operator, Check to see if there is a string of letters for one operator (for example xyz is one operand)
		else {
			term = term + mExpression[i];
			// Protecting against string index out of range error
			if (i == mExpression.length()-1) {
				mOperand.push(term);
				term = "";
			}
			else {
				if (mExpression[i + 1] != '^' && mExpression[i + 1] != '*' && mExpression[i + 1] != '/' &&
					mExpression[i + 1] != '+' && mExpression[i + 1] != '-' && mExpression[i + 1] != '(' && mExpression[i + 1] != ')') {
					continue;
				}
				else {
					mOperand.push(term);
					term = "";
				}
			}
		}
	}
	while (mOperand.size() > 1) {
		string temp = mOperand.pop();
		if (mOperator.top() == "(") {
			mOperator.pop();
			continue;
		}
		else {
			newExpression = mOperator.pop() + mOperand.pop() + temp;
			mOperand.push(newExpression);
		}
	}

	if (mOperand.size() == 1 && mOperator.size() == 0) {
		return mOperand.pop();
	}
	else {
		return "Something went wrong!\n\n";
	}
	
}