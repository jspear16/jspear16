# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'threePinComponentWidget.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PySide2 import QtCore, QtGui, QtWidgets
from PySide2.QtCore import (QCoreApplication, QPropertyAnimation, QDate, QDateTime, QMetaObject, QObject, QPoint, QRect, QSize, QTime, QUrl, Qt, QEvent)
from PySide2.QtGui import (QBrush, QColor, QConicalGradient, QCursor, QFont, QFontDatabase, QIcon, QKeySequence, QLinearGradient, QPalette, QPainter, QPixmap, QRadialGradient)
from PySide2.QtWidgets import *

class Ui_Form(object):
    def setupUi(self, Form):
        Form.setObjectName("Form")
        Form.resize(168, 194)
        self.verticalLayout = QtWidgets.QVBoxLayout(Form)
        self.verticalLayout.setObjectName("verticalLayout")
        self.label_name = QtWidgets.QLabel(Form)
        self.label_name.setMinimumSize(QtCore.QSize(0, 20))
        self.label_name.setMaximumSize(QtCore.QSize(16777215, 20))
        self.label_name.setAlignment(QtCore.Qt.AlignCenter)
        self.label_name.setObjectName("label_name")
        self.verticalLayout.addWidget(self.label_name)
        self.frame = QtWidgets.QFrame(Form)
        self.frame.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame.setObjectName("frame")
        self.label_image = QtWidgets.QLabel(self.frame)
        self.label_image.setGeometry(QtCore.QRect(0, 0, 150, 150))
        self.label_image.setMinimumSize(QtCore.QSize(0, 150))
        self.label_image.setMaximumSize(QtCore.QSize(16777215, 150))
        self.label_image.setText("")
        self.label_image.setScaledContents(True)
        self.label_image.setObjectName("label_image")
        self.btn_pin0 = QtWidgets.QPushButton(self.frame)
        self.btn_pin0.setGeometry(QtCore.QRect(0, 0, 75, 150))
        self.btn_pin0.setStyleSheet("background-color: rgba(255, 255, 255, 0);")
        self.btn_pin0.setText("")
        self.btn_pin0.setObjectName("btn_pin0")
        self.btn_pin1 = QtWidgets.QPushButton(self.frame)
        self.btn_pin1.setGeometry(QtCore.QRect(75, 0, 75, 75))
        self.btn_pin1.setStyleSheet("background-color: rgba(255, 255, 255, 0);")
        self.btn_pin1.setText("")
        self.btn_pin1.setObjectName("btn_pin1")
        self.btn_pin2 = QtWidgets.QPushButton(self.frame)
        self.btn_pin2.setGeometry(QtCore.QRect(75, 75, 75, 75))
        self.btn_pin2.setStyleSheet("background-color: rgba(255, 255, 255, 0);")
        self.btn_pin2.setText("")
        self.btn_pin2.setObjectName("btn_pin2")
        self.verticalLayout.addWidget(self.frame)

        self.retranslateUi(Form)
        QtCore.QMetaObject.connectSlotsByName(Form)

    def retranslateUi(self, Form):
        _translate = QtCore.QCoreApplication.translate
        Form.setWindowTitle(_translate("Form", "Form"))
        self.label_name.setText(_translate("Form", "Component Name"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Form = QtWidgets.QWidget()
    ui = Ui_Form()
    ui.setupUi(Form)
    Form.show()
    sys.exit(app.exec_())

