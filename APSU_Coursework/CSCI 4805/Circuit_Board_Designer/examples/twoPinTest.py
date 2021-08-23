# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'twoPinComponentWidget.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_Form(object):
    def setupUi(self, Form):
        Form.setObjectName("Form")
        Form.resize(150, 95)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Form.sizePolicy().hasHeightForWidth())
        Form.setSizePolicy(sizePolicy)
        Form.setMinimumSize(QtCore.QSize(150, 95))
        Form.setMaximumSize(QtCore.QSize(168, 16777215))
        self.label_name = QtWidgets.QLabel(Form)
        self.label_name.setGeometry(QtCore.QRect(0, 0, 150, 20))
        self.label_name.setMinimumSize(QtCore.QSize(0, 20))
        self.label_name.setMaximumSize(QtCore.QSize(16777215, 20))
        self.label_name.setAlignment(QtCore.Qt.AlignCenter)
        self.label_name.setObjectName("label_name")
        self.frame = QtWidgets.QFrame(Form)
        self.frame.setGeometry(QtCore.QRect(0, 20, 150, 75))
        self.frame.setMinimumSize(QtCore.QSize(150, 50))
        self.frame.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame.setObjectName("frame")
        self.lable_image = QtWidgets.QLabel(self.frame)
        self.lable_image.setGeometry(QtCore.QRect(0, 0, 150, 75))
        self.lable_image.setText("")
        self.lable_image.setScaledContents(True)
        self.lable_image.setObjectName("lable_image")
        self.btn_pin0 = QtWidgets.QPushButton(self.frame)
        self.btn_pin0.setGeometry(QtCore.QRect(0, 0, 75, 75))
        self.btn_pin0.setStyleSheet("")
        self.btn_pin0.setText("")
        self.btn_pin0.setObjectName("btn_pin0")
        self.btn_pin1 = QtWidgets.QPushButton(self.frame)
        self.btn_pin1.setGeometry(QtCore.QRect(75, 0, 75, 75))
        self.btn_pin1.setStyleSheet("")
        self.btn_pin1.setText("")
        self.btn_pin1.setObjectName("btn_pin1")

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

