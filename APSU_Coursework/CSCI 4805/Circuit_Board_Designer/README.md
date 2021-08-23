# Circuit-Board-Designer

The Circuit Board Designer has been developed to be an easy-to-use tool to develop circuit diagrams efficiently and for those who may be lacking experience. The Circuit Board Designer offers a lot of features, but the most important is it’s simple and easy to understand graphical user interface (GUI) which allows the user to generate their own basic circuit within minutes. The Circuit Board Designer also provides functionality to convert the circuit diagram to a physical component layout that fits optimally on a printable circuit board (PCB). This function allows the user to be able to quickly develop their optimal layout for a compact circuit. This program also has the ability to give the user an image of their optimal PCB layout.

This GitHub repository is organized as follows:

## Documents

This directory includes all of the documents throughout the CSCI 4805 Course. This includes word documents and powerpoints which (some of which are saved as .pdf files) from various milestones of this project.

## examples

This directory is solely used to give the user examples on how to use different parts of the backend program. It is also used for testing purposes by the developers. 

## readmeImg

This directory is just to contain the images used in this README.
## src

This is the source directory of the entire project.

<ins>color_img</ins>
: Contains all of the different .png files for the color-related buttons on the GUI.

<ins>comp_img</ins>
: Contains all of the different .svg files for the components on the workspace of the GUI.

<ins>img</ins>
: Contains all of the different .png files for the other buttons not included in the color_img folder.

The classes.py file contains all of the class data related to the monte carlo and A* methods for the PCB Optimization

The main.py file contains all of the class data related to the GUI, file management, and the driver function of the program.

# Required Libraries and Installation (Windows Only)
* Install the latest version of Python3 and make sure to include python3 to your PATH
* Install Git and make sure to include git to your PATH
* In cmd run **pip3 install PyQt5**
* In cmd run **pip3 install PySide2**
* In cmd run **pip3 install numpy**
* In cmd run **pip3 install Pillow**
* In cmd run **git clone https://github.com/CinnaKenToast/Circuit-Board-Designer.git**

# Run the Program
Navigate to the src folder in cmd and the run **python3 main.py** in cmd.

# Important Program Controls
![Select](/readmeImg/select.png)

In order to select a component, click on the label of said component. 

![Select Pin](/readmeImg/pin.png)

When selecting a pins to connect, click on the open circle of the corresponding pin on the component. 

![Toggle](/readmeImg/toggle.png)

Press the this button to get the option to change the page of the program. A slideout menu will appear to change the screen.

![Menus](/readmeImg/pages.png)

Press one of the page buttons in the slideout menu after pressing the toggle menu to change to the different screens of the program. 
**Circuit Designer - Design a circuit by adding components to a workspace.**
**Circuit/PCB Converter - Convert the designed circuit to a PCB Layout.**
**File Management - Create, open, and save circuit diagrams.**

![Wire](/readmeImg/wire.png)

Press this button to connect two pins of different components. **You must select two pins to connect components, and they cannot be from the same component.**

![Snip](/readmeImg/snip.png)

Press this button to remove the connection from two pins of different components. **You must select two pins to disconnect components, and they cannot be from the same component.**

![Add](/readmeImg/add.png)

Press this button to get the option to add a component to the scene. A slideout menu will appear to allow you to choose a component.

![Delete](/readmeImg/delete.png)

Press this button to delete a component from the scene. **You must select a component to delete by clicking on its label. Deleting a component with connections will not remove the connections. This feature is not implemented yet.**

![Label](readmeImg/label.png)

Press this button to change the label of a component. **You must select a component to change its label by clicking on its label.**

![Comment](readmeImg/label.png)

**This feature is not yet added to the program.** Press this button to add a comment to the scene.

![Color](readmeImg/color.png)

Press this button to get the option to change the color any new wires that are added to the scene. A slideout menu will appear to change the color of the wires.

![ZoomHome](readmeImg/zoomHome.png)

Press this button to set the scene back to its deafult zoom setting.

![ZoomIn](readmeImg/zoomIn.png)

Press this button to zoom into the scene. The scene will only zoom into to a certain distance.

![ZoomHome](readmeImg/zoomOut.png)

Press this button to zoom out of the scene. The scene will only zoom out to a certain distance.




## Licenses
The base of the repo contains **license.txt** that contains all required licenses information and credit for any icons used in the program. 
