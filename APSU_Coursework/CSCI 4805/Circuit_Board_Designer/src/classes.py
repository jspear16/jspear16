from typing import Type
import numpy as np
import json
from PyQt5 import QtWidgets, QtGui
from PIL import Image, ImageDraw, ImageFont
import os.path
from xml.dom import minidom

# set the transform.rotate(...) to one of these --- flip does not mirror, it just rotates by 180 degrees. (-Jason)
# This is for rotating in the schematic - not integrated (-Jason)
SCHEM_ORIENTATIONS = {'upright': 0, 'CW1': 90, 'CCW1': -90, 'flip': 180}

# add the one that sets the second pin whichever direction you want the component to go. (-Jason)
# this is for rotating in the pcb
PCB_ORIENTATIONS = [[1, 0], [0, 1], [-1, 0], [0, -1]]

# This class holds the svg/xml for each component and has a method in it that
# allows us to change the fill for a pin to make it look "connected" - not integrated (-Jason)
class ComponentSVG:
    def __init__(self, base_file_name="", base_xml=None, active_xml=None):
        if active_xml == None:
            if base_xml == None:
                self.active_xml = minidom.parse(base_file_name)
            else:
                self.active_xml = base_xml
        else:
            self.active_xml = active_xml

    # For filling in the pin to make it obvious it has been connected to.
    def change_pin_state(self, pin_number, new_state):
        # These are the two options: transparent or black - disconnected or connected.
        fill_options = ["none", "#000000"]
        fill = fill_options[new_state]

        # Get a searchable xml from the svg file and find the circle (pin) objects
        new_xml = self.active_xml
        pins = new_xml.getElementsByTagName("circle")

        # Split the style line into two sections: the fill section and the rest.
        # Then get the current fill
        style_line = pins[pin_number].attributes["style"].value
        current_fill = style_line.split(';', 1)[0].split(':')[1]

        # # This decides which element the new_fill will be based on the current_fill
        # current_state = not current_fill == fill_options[0]
        # new_fill = fill_options[not current_state]
        # new_state = not current_state

        style = f"fill:{fill};{style_line.split(';', 1)[1]}"
        pins[pin_number].attributes["style"].value = style

        # Update the active xml
        self.active_xml = new_xml

    # For debugging the xml output.
    def print_svg_file(self, file_name):
        with open(file_name, 'w') as f:
            self.active_xml.writexml(f)

    # In case we wanted to put this version of the xml in a save file - we don't (-Jason)
    def to_dict(self):
        svg_dict = {"active_xml": self.active_xml.toxml()}
        return svg_dict


# This class holds pretty much everything you need for describing and working
# with a component. It has 7 child classes: Resistor, Capacitor, Inductor,
# Diode, Led, Switch, and VoltageSource.
class Component:
    # for easy access - though we never integrated rotating in the schematic (-Jason)
    global SCHEM_ORIENTATIONS

    def __init__(self, id, label, num_pins, schem_position, schem_orientation, pcb_position, connections, svg_file_name):
        if self.valid_input({"id": id, "label": label, "schem_position": schem_position, "schem_orientation": schem_orientation}):
            self.id = id
            self.label = label
            self.num_pins = num_pins
            # pin_states would have been for quick lookup to see what pins were connected - not integrated (-Jason)
            self.pin_states = [False for i in range(0, self.num_pins)]
            self.schem_position = schem_position
            self.schem_orientation = schem_orientation
            self.pcb_position = pcb_position
            # This is for setting up the initial connections state.
            # Originally, it was set up this way to allow for any
            # number of pins to be used, but we've decided not to
            # implement it yet. (-Jason)
            self.connections = self.set_connections(connections)
            # This is the svg object that is used to draw a component in PyQt
            self.svg_obj = ComponentSVG(
                base_file_name=svg_file_name)

    # For debugging/input checks
    def valid_input(self, input_kwargs):
        for key in input_kwargs:
            if key == "id":
                if type(input_kwargs[key]) != int:
                    raise TypeError("Invalid id type")
                if input_kwargs[key] < 0:
                    raise ValueError("Invalid id value")
            elif key == "label":
                if type(input_kwargs[key]) != str:
                    raise TypeError("Invalid label type")
            elif key == "schem_position":
                if type(input_kwargs[key]) != list:
                    raise TypeError("Invalid schematic position type")
                if np.shape(input_kwargs[key]) != (2,):
                    raise ValueError("Invalid shape for schematic position")
            elif key == "schem_position":
                if type(input_kwargs[key]) != int:
                    raise TypeError("Invalid schematic orientation type")
                if not np.shape(input_kwargs[key]) in SCHEM_ORIENTATIONS.values:
                    raise ValueError("Invalid value for schematic orientation")
        return True

    # To set the initial state of the pins' connections.
    # The connections dictionary is as follows:
    # {pin0_id: [list_of_other_pins_this_ones_connected_to], pin1_id: [list_of_other...], ...}
    def set_connections(self, connections):
        if connections == {}:
            self.connections = {f"{self.id}_0": [], f"{self.id}_1": []}
        else:
            self.connections = {f"{self.id}_0": [], f"{self.id}_1": []}
            for this_pin_id, connection_list in connections.items():
                for that_pin_id in connection_list:
                    self.connections[this_pin_id].append(that_pin_id)

    # Used to set and keep track of the position of the component in the schematic
    def set_schematic_pos(self, pos):
        self.schem_position = pos

    # Used to set the position of the component in the pcb grid
    def set_pcb_pos(self, pos):
        self.pcb_position = pos

    # Connects this pin to that pin using the id as a key to look
    # up which pin this one is to append that pin id
    def connect(self, this_pin_id, that_pin_id):
        if this_pin_id in self.connections:
            self.connections[this_pin_id].append(that_pin_id)

            # If this is the first connection, update the image
            if len(self.connections) == 1:
                this_pin_num = this_pin_id.split("_")
                self.active_svg_xml, self.pin_states[this_pin_num] = self.svg_obj.change_pin_state(
                    this_pin_num, True)
                self.pin_states[this_pin_num] = True
        else:
            raise ValueError("Invalid pin id")

    # Disconnects this pin from that pin by using the id to look for
    # and remove that pin id.
    def disconnect(self, this_pin_id, that_pin_id):
        if this_pin_id in self.connections:
            self.connections[this_pin_id].remove(that_pin_id)

            # If there aren't any more connections, update the image
            if len(self.connections) == 0:
                this_pin_num = this_pin_id.split("_")
                self.active_svg_xml, self.pin_states[this_pin_num] = self.svg_obj.change_pin_state(
                    this_pin_num, False)
                self.pin_states[this_pin_num] = False
        else:
            raise ValueError("Invalid pin id")

    # gets svg center-of-pin pixel position - not integrated (-Jason)
    def get_svg_pin_position(self):
        raise NotImplementedError("Abstract method")

    # gets the xml for drawing in PyQt
    def get_svg_xml(self):
        return self.svg_obj.active_xml

    # for debugging the xml
    def print_svg(self, file_name):
        self.svg_obj.print_svg_file(file_name)

    # Used to edit a component's label
    def edit_label(self, text=""):
        if text == "":
            raise ValueError("Invalid label text")
        self.label = text

    # Used to draw oneself - not implemented (-Jason)
    def draw(self):
        raise NotImplementedError("Abstract method")

    # Used to get info about the components in a schematic
    # very useful for debugging! (-Jason)
    def to_string(self):
        return (f"component_type: {self.__class__.__name__}\n"
                f"id: {self.id}\n"
                f"label: {self.label}\n"
                f"num_pins: {self.num_pins}\n"
                f"schem_position: {self.schem_position}\n"
                f"schem_orientation: {self.schem_orientation} degrees\n"
                f"pcb_position: {self.pcb_position}\n"
                f"connections: {self.connections}\n")

    # Used for saving the component's state
    def to_dict(self):
        component_dict = {
            "id": self.id,
            "component_type": self.__class__.__name__,
            "label": self.label,
            "schem_position": self.schem_position,
            "schem_orientation": self.schem_orientation,
            "pcb_position": self.pcb_position,
            "connections": self.connections
        }
        return component_dict

## The following 7 components are classes that represent a different type of component. They
#  each have their own svg_pin_positions, though they're all the same. 
class Resistor(Component):
    def __init__(self, id=-1, label="", schem_position=[0, 0], schem_orientation=SCHEM_ORIENTATIONS['upright'], pcb_position=[], connections={}, svg_file_name="comp_img/Resistor.svg"):
        super().__init__(id, label, 2, schem_position,
                         schem_orientation, pcb_position, connections, svg_file_name)
        self.svg_pin_positions = [[10, 30], [150, 30]]

    # Returns the svg center-of-pin pixel position - not fully integrated (-Jason)
    def get_svg_pin_position(self):
        return self.svg_pin_positions

    # PyQt does all that!
    def draw(self):
        pass


class Capacitor(Component):
    def __init__(self, id=-1, label="", schem_position=[0, 0], schem_orientation=SCHEM_ORIENTATIONS['upright'], pcb_position=[], connections={}, svg_file_name="comp_img/Capacitor.svg"):
        super().__init__(id, label, 2, schem_position,
                         schem_orientation, pcb_position, connections, svg_file_name)
        self.svg_pin_positions = [[10, 30], [150, 30]]

    # Returns the svg center-of-pin pixel position - not fully integrated (-Jason)
    def get_svg_pin_position(self):
        return self.svg_pin_positions

    # PyQt does all that!
    def draw(self):
        pass


class Inductor(Component):
    def __init__(self, id=-1, label="", schem_position=[0, 0], schem_orientation=SCHEM_ORIENTATIONS['upright'], pcb_position=[], connections={}, svg_file_name="comp_img/Inductor.svg"):
        super().__init__(id, label, 2, schem_position,
                         schem_orientation, pcb_position, connections, svg_file_name)
        self.svg_pin_positions = [[10, 30], [150, 30]]

    # Returns the svg center-of-pin pixel position - not fully integrated (-Jason)
    def get_svg_pin_position(self):
        return self.svg_pin_positions

    # PyQt does all that!
    def draw(self):
        pass


class Diode(Component):
    def __init__(self, id=-1, label="", schem_position=[0, 0], schem_orientation=SCHEM_ORIENTATIONS['upright'], pcb_position=[], connections={}, svg_file_name="comp_img/Diode.svg"):
        super().__init__(id, label, 2, schem_position,
                         schem_orientation, pcb_position, connections, svg_file_name)
        self.svg_pin_positions = [[10, 30], [150, 30]]

    # Returns the svg center-of-pin pixel position - not fully integrated (-Jason)
    def get_svg_pin_position(self):
        return self.svg_pin_positions

    # PyQt does all that!
    def draw(self):
        pass


class Led(Component):
    def __init__(self, id=-1, label="", schem_position=[0, 0], schem_orientation=SCHEM_ORIENTATIONS['upright'], pcb_position=[], connections={}, svg_file_name="comp_img/Led.svg"):
        super().__init__(id, label, 2, schem_position,
                         schem_orientation, pcb_position, connections, svg_file_name)
        self.svg_pin_positions = [[10.025, 30], [150.025, 30]]

    # Returns the svg center-of-pin pixel position - not fully integrated (-Jason)
    def get_svg_pin_position(self):
        return self.svg_pin_positions

    # PyQt does all that!
    def draw(self):
        pass


class Switch(Component):
    def __init__(self, id=-1, label="", schem_position=[0, 0], schem_orientation=SCHEM_ORIENTATIONS['upright'], pcb_position=[], connections={}, svg_file_name="comp_img/Switch.svg"):
        super().__init__(id, label, 2, schem_position,
                         schem_orientation, pcb_position, connections, svg_file_name)
        self.svg_pin_positions = [[10, 30], [150, 30]]

    # Returns the svg center-of-pin pixel position - not fully integrated (-Jason)
    def get_svg_pin_position(self):
        return self.svg_pin_positions

    # PyQt does all that!
    def draw(self):
        pass


class VoltageSource(Component):
    def __init__(self, id=-1, label="", schem_position=[0, 0], schem_orientation=SCHEM_ORIENTATIONS['upright'], pcb_position=[], connections={}, svg_file_name="comp_img/VoltageSource.svg"):
        super().__init__(id, label, 2, schem_position,
                         schem_orientation, pcb_position, connections, svg_file_name)
        self.svg_pin_positions = [[10, 30], [150, 30]]

    # Returns the svg center-of-pin pixel position - not fully integrated (-Jason)
    def get_svg_pin_position(self):
        return self.svg_pin_positions

    # PyQt does all that!
    def draw(self):
        pass

# A class that was gonna be used for storing the comments a user could make.
# It has various methods regarding the state of a comment - not integrated (-Jason)
class Comment:
    def __init__(self, id, text="Type something here", position=[0, 0]):
        if self.valid_input({"id": id, "text": text, "position": position}):
            self.id = id
            self.text = text
            self.position = position

    # For debugging/input checks
    def valid_input(self, input_kwargs):
        for key in input_kwargs:
            if key == "id":
                if type(input_kwargs[key]) != int:
                    raise TypeError("Invalid id type")
                if input_kwargs[key] < 0:
                    raise ValueError("Invalid id value")
            if key == "text":
                if type(input_kwargs[key]) != str:
                    raise TypeError("Invalid text type")
            if key == "position":
                if type(input_kwargs[key]) != list:
                    raise TypeError("Invalid position type")
                if len(input_kwargs[key]) != 2:
                    raise ValueError("invalid position shape")
        return True

    # Edits the displayed text - not integrated (-Jason)
    def edit_text(self, text):
        if self.valid_input({"text": text}):
            self.text = text

    # Sets the position of the comment box - not integrated (-Jason)
    def set_position(self, position):
        if self.valid_input({"position": position}):
            self.location = position

    # PyQt!
    def draw(self):
        pass

    # For saving a comment in a schematic
    def to_dict(self):
        comment_dict = {
            "id": self.id,
            "text": self.text,
            "position": self.position
        }
        return comment_dict

    # For printing the contents, very useful - not integrated (-Jason)
    def to_string(self):
        return (f"id: {self.id}\n"
                "text: {self.text}\n"
                "position: {self.position}\n")


# This class represents a grid point in a pcb grid space
# it holds all of the basic stuff for use by A* (pseudo code from Sebastian Lague on YouTube) (-Jason)
class GridNode:
    def __init__(self, pos, taken):
        self.pos = pos
        self.taken = taken
        self.g_cost = -1
        self.h_cost = -1
        self.parent = None

    # Return the f_cost: total cost of the path so far + cost of straight line distance to end
    def f_cost(self):
        return self.g_cost + self.h_cost

# This class controls the grid nodes and works out a path between a start and goal node
class PcbGrid:
    def __init__(self, dims, obstructions):
        self.dims = dims
        self.obstructions = obstructions
        self.nodes = self.initialize_grid(obstructions)

    # This initializes all of the grid spaces
    # each grid space is a GridNode
    # I set the taken to be true wherever there are obstructions, of course, and vice versa. (-Jason)

    def initialize_grid(self, obstructions):
        nodes = {}

        for i in range(0, self.dims):
            for j in range(0, self.dims):
                pos = [i, j]
                if not (pos in obstructions):
                    nodes[str(pos)] = GridNode(pos, False)
                else:
                    nodes[str(pos)] = GridNode(pos, True)

        return nodes

    # For getting a node at a position
    def node_at(self, pos):
        if str(pos) in self.nodes.keys():
            return self.nodes[str(pos)]

    # Finds the neighbors that are left, right, up, and down
    def get_neighbors(self, node):
        neighbors = []

        for i in range(-1, 2):
            for j in range(-1, 2):
                if (i == 0 and j == 0) or (i*j != 0):
                    continue
                neighbor_node_pos = [node.pos[0] + i, node.pos[1] + j]
                if neighbor_node_pos[0] >= 0 and neighbor_node_pos[0] < self.dims and neighbor_node_pos[1] >= 0 and neighbor_node_pos[1] < self.dims:
                    neighbor_node = self.nodes[str(neighbor_node_pos)]
                    neighbors.append(neighbor_node)

        return neighbors

    # The heuristic from Sebastian Lague (i is for rows (y), j is for columns (x))
    def get_distance(self, from_node, goal_node):
        di = abs(goal_node[0] - from_node[0])
        dj = abs(goal_node[1] - from_node[1])

        if dj > di:
            return 14 * di + 10 * (dj - di)
        return 14 * dj + 10 * (di - dj)

    # This gets the path nodes' positions by looking at the goal node and tracing
    # its "parents" to the start node and then the resulting list is reversed to put it
    # the right way around.
    def retrace_path(self, start_node, goal_node):
        lst = []
        node = goal_node

        while node != start_node:
            # print(node.pos, node.parent)
            lst.append(node.pos)
            node = node.parent
        else:
            lst.append(start_node.pos)

        lst.reverse()
        return lst

    # A* as defined by Sebastian Lague (-Jason)
    def a_star(self, start_node, goal_node):
        # Two sets: one for the things we need to deal with, and the oher for things we are done dealing with
        open_nodes = [self.nodes[str(start_node.pos)]]
        closed_nodes = []

        # while there is something to deal with
        while len(open_nodes) > 0:
            # find node with lowest f_cost to go to
            this_node = open_nodes[0]
            for that_node in open_nodes[1:]:
                if (that_node.f_cost() < this_node.f_cost()) or ((that_node.f_cost() == this_node.f_cost()) and (that_node.h_cost < this_node.h_cost)):
                    this_node = that_node

            # place node in closed list (we're dealing with it now, so we don't need it in the "need to deal with" list)
            open_nodes.remove(this_node)
            closed_nodes.append(this_node)

            # If the node happens to be the goal node,
            # return false to alert the caller that the paths list is definitely not empty
            if this_node == goal_node:
                return False

            # Look at all the neighbors and decide which ones to deal with.
            for neighbor in self.get_neighbors(this_node):
                if neighbor.taken or (neighbor in closed_nodes):
                    continue

                tentative_g_cost = this_node.g_cost + \
                    self.get_distance(this_node.pos, neighbor.pos)
                if (tentative_g_cost < neighbor.g_cost) or not (neighbor in open_nodes):
                    neighbor.g_cost = tentative_g_cost
                    neighbor.h_cost = self.get_distance(
                        neighbor.pos, goal_node.pos)
                    neighbor.parent = this_node

                    if not(neighbor in open_nodes):
                        open_nodes.append(neighbor)
        # let the caller know that the paths list is empty - there wasn't a path
        if self.nodes[str(goal_node.pos)].parent == None:
            return True


class Schematic:
    COMPONENT_CLASSES = {
        "Resistor": Resistor,
        "Capacitor": Capacitor,
        "Inductor": Inductor,
        "Diode": Diode,
        "Led": Led,
        "Switch": Switch,
        "VoltageSource": VoltageSource
    }

    def __init__(self):
        self.components = {}
        self.comments = {}
        self.paths = []
        self.curr_runs_score = -1
        self.pin_placement_dict = {}
        self.connections_list = []
        self.area_weight = .3
        self.path_length_weight = .7
        self.set_monte_carlo_parameters()
        self.converted_image_bg_color = (0, 0, 0)
        self.converted_image_color_mode = "RGB"
        self.converted_image_scaling = 50
        self.converted_image_trace_color = (135, 10, 99)
        self.converted_image = None

    # Allows for setting the monte carlo params so it can continue (-Jason)
    def set_monte_carlo_parameters(self, n_grid_spaces=5, a_star_grid_padding=4, target_score=.5):
        self.n_grid_spaces = n_grid_spaces
        self.a_star_grid_padding = a_star_grid_padding
        self.target_score = target_score

    # Checks an id versus the list of component ids that exist and tells whether its unique (-Jason)
    def unique_component_id(self, id):
        if len(self.components) < 1:
            return True
        else:
            return not (id in [component_id for component_id in self.components])

    # Checks an id versus the list of comment ids that exist and tells whether its unique (-Jason)
    def unique_comment_id(self, id):
        if len(self.comments) < 1:
            return True
        else:
            return not (id in [comment_id for comment_id in self.comments])

    # I'm using this to set a new schematic to a loaded one (-Jason)
    def Schematic(self, schematic_dict):
        for component in schematic_dict["components"].values():
            self.add_component(component)

        for comment in schematic_dict["comments"].values():
            self.add_comment(comment)

        self.paths = schematic_dict["paths"]
        self.curr_runs_score = schematic_dict["curr_runs_score"]
        self.pin_placement_dict = schematic_dict["pin_placement_dict"]
        self.connections_list = schematic_dict["connections_list"]
        self.area_weight = schematic_dict["area_weight"]
        self.path_length_weight = schematic_dict["path_length_weight"]
        self.set_monte_carlo_parameters(
            schematic_dict["n_grid_spaces"], schematic_dict["a_star_grid_padding"], schematic_dict["target_score"])

    # adds component to self.components dict
    def add_component(self, component_dict):
        if self.unique_component_id(component_dict["id"]):
            if "connections" in component_dict:
                connections = component_dict.pop("connections")
            else:
                connections = {}

            component_type = component_dict["component_type"]
            component_dict.pop("component_type")
            component_id = component_dict["id"]
            self.components[f"component_{component_id}"] = self.COMPONENT_CLASSES[component_type](
                **component_dict)
            self.components[f"component_{component_id}"].set_connections(
                connections)

        else:
            raise ValueError("Component id not unique")

    # removes the component from self.components dice
    def remove_component(self, component_id):
        self.components.pop(f"component_{component_id}")

    # gets the component in question based on its id
    def get_component(self, component_id):
        return self.components[f"component_{component_id}"]

    # gets the svg center-of-pin pixel to know where to place the end of
    # wires in PyQt
    def get_pin_position(self, pin_id):
        component_id, pin_num = pin_id.split('_')
        component_lookup_id = f"component_{component_id}"
        component = self.components[component_lookup_id]
        return component.get_svg_pin_position()[int(pin_num)]

    # for editing component labels
    def edit_label(self, component_id, new_text):
        self.components[f"component_{component_id}"].edit_label(new_text)

    # for adding connections to the component
    def add_connection(self, component_1_pin_id, component_2_pin_id):
        component_1_id = int(component_1_pin_id.split("_")[0])
        component_2_id = int(component_2_pin_id.split("_")[0])
        self.components[f"component_{component_1_id}"].connect(
            component_1_pin_id, component_2_pin_id)
        self.components[f"component_{component_2_id}"].connect(
            component_2_pin_id, component_1_pin_id)

        self.append_to_connections_list(component_1_pin_id, component_2_pin_id)

    # for removing connections from the component
    def remove_connection(self, component_1_pin_id, component_2_pin_id):
        component_1_id = int(component_1_pin_id.split("_")[0])
        component_2_id = int(component_2_pin_id.split("_")[0])
        self.components[f"component_{component_1_id}"].disconnect(
            component_1_pin_id, component_2_pin_id)
        self.components[f"component_{component_2_id}"].disconnect(
            component_2_pin_id, component_1_pin_id)

        self.remove_from_connections_list(
            component_1_pin_id, component_2_pin_id)

    # Put these into the connections list, Ken needed the connections list sooner than
    # I needed it for monte_carlo, so here we are (-Jason)
    def append_to_connections_list(self, pin_1_id, pin_2_id):
        self.connections_list.append([pin_1_id, pin_2_id])

    # Maybe he needed to remove them actually...(-Jason)
    def remove_from_connections_list(self, pin_1_id, pin_2_id):
        self.connections_list.remove([pin_1_id, pin_2_id])

    # Set the position in the component field for where the component is in the schematic
    def set_component_schematic_pos(self, component_id, pos):
        self.components[f"component_{component_id}"].set_schematic_pos(
            pos)

    # Print all info about components (that we want) (-Jason)
    def print_all_components_strings(self):
        for component in self.components.values():
            print(component.to_string())

    # Print all info about comments (that we want) (-Jason)
    def print_all_comments_strings(self):
        for comment in self.comments.values():
            print(comment.to_string())

    # Add a comment to the schematic
    def add_comment(self, comment_dict):
        if self.unique_comment_id(comment_dict["id"]):
            comment = Comment(**comment_dict)
            self.comments[f"comment_{comment.id}"] = comment
        else:
            raise ValueError("Comment id not unique")

    # Edit the comments text
    def edit_comment(self, comment_id, new_text):
        self.comments[f"comment_{comment_id}"].edit_text(new_text)

    # Remove the comment from the schematic
    def remove_comment(self, comment_id):
        self.comments.pop(f"comment_{comment_id}")

    # PyQt!
    def draw(self):
        for component in self.components.values():
            component.draw()
        for comment in self.comments.values():
            comment.draw()

    # For saving the schematic.
    # This gathers pretty much all information about a schematic so it can save it to a json file
    def to_dict(self):
        components = {}
        comments = {}
        schematic_dict = {}

        for component_id in self.components:
            components[component_id] = self.components[component_id].to_dict()

        for comment_id in self.comments:
            comments[comment_id] = self.comments[comment_id].to_dict()

        schematic_dict = {
            "components": components,
            "comments": comments,
            "paths": self.paths,
            "curr_runs_score": self.curr_runs_score,
            "target_score": self.target_score,
            "pin_placement_dict": self.pin_placement_dict,
            "connections_list": self.connections_list,
            "area_weight": self.area_weight,
            "path_length_weight": self.path_length_weight,
            "n_grid_spaces": self.n_grid_spaces,
            "a_star_grid_padding": self.a_star_grid_padding
        }

        return schematic_dict

    # Save using json
    # If a file exists, then just do something like "file_name(i)" where i is the next one not taken
    def save(self, file_name):
        schematic_dict = self.to_dict()
        fn = f"{file_name}"
        if not os.path.exists(fn):
            with open(fn, 'x') as f:
                json.dump(schematic_dict, f)
        else:
            i = 0
            fn = f"{file_name}({i})"
            while os.path.exists(fn):
                if i > 254:
                    raise FileExistsError(
                        f"\"{file_name}\" exists and there are too many with its base name (255)")
                i += 1
                fn = f"{file_name}({i})"
            with open(fn, 'x') as f:
                json.dump(schematic_dict, f)

    # Overwrite save file regardless of if it exists
    def overwrite_save(self, file_name):
        schematic_dict = self.to_dict()
        fn = f"{file_name}"
        with open(fn, 'w') as f:
            json.dump(schematic_dict, f)

    # Load all data into a new schematic
    def load(self, file_name):  # need to implement some safegard to be sure that the user wants to load in something (in case they had not saved the current schematic) (-Jason)
        fn = f"{file_name}"
        if os.path.exists(fn):
            f = open(fn, "r")
            schematic_dict = json.load(f)
            self.Schematic(schematic_dict)
        # notify user that file does not exist and ask if they want to reenter a filename (-Jason)
        else:
            raise FileNotFoundError(f"No file \"{fn}\"")

    # Figure out where all the pins are and send back the list
    def not_allowed_pcb_spots(self):
        not_allowed = []

        # Append existing components to the not allowed list.
        for component in self.components.values():
            if component.pcb_position != []:
                not_allowed.append(component.pcb_position[0])
                not_allowed.append(component.pcb_position[1])

        return not_allowed

    # Randomly pick one pin position
    def get_pin1_pos(self):
        pin1_pos = [int(np.floor(np.random.rand() * self.n_grid_spaces)),
                    int(np.floor(np.random.rand() * self.n_grid_spaces))]
        return pin1_pos

    # Randomly pick another that is either up, down, right or left of pin1 position
    def get_pin2_pos(self, pin1_pos):
        global PCB_ORIENTATIONS
        possible_orientations = PCB_ORIENTATIONS.copy()
        rn_orient = int(np.floor(np.random.rand() * 4))

        # topleft corner
        if pin1_pos[0] == 0 and pin1_pos[1] == 0:
            rn_orient = int(np.floor(np.random.rand() * 2))
            possible_orientations.remove([-1, 0])
            possible_orientations.remove([0, -1])
        # topright corner
        elif pin1_pos[0] == 0 and pin1_pos[1] == self.n_grid_spaces - 1:
            rn_orient = int(np.floor(np.random.rand() * 2))
            possible_orientations.remove([0, 1])
            possible_orientations.remove([-1, 0])
        # bottomright corner
        elif pin1_pos[0] == self.n_grid_spaces - 1 and pin1_pos[1] == self.n_grid_spaces - 1:
            rn_orient = int(np.floor(np.random.rand() * 2))
            possible_orientations.remove([1, 0])
            possible_orientations.remove([0, 1])
        # bottomleft corner
        elif pin1_pos[0] == self.n_grid_spaces - 1 and pin1_pos[1] == 0:
            rn_orient = int(np.floor(np.random.rand() * 2))
            possible_orientations.remove([0, -1])
            possible_orientations.remove([1, 0])
        # left edge
        elif pin1_pos[0] * pin1_pos[1] == 0 and pin1_pos[1] == 0:
            rn_orient = int(np.floor(np.random.rand() * 3))
            possible_orientations.remove([0, -1])
        # top edge
        elif pin1_pos[0] * pin1_pos[1] == 0 and pin1_pos[0] == 0:
            rn_orient = int(np.floor(np.random.rand() * 3))
            possible_orientations.remove([-1, 0])
        # right edge
        elif pin1_pos[1] == self.n_grid_spaces - 1:
            rn_orient = int(np.floor(np.random.rand() * 3))
            possible_orientations.remove([0, 1])
        # bottom edge
        elif pin1_pos[0] == self.n_grid_spaces - 1:
            rn_orient = int(np.floor(np.random.rand() * 3))
            possible_orientations.remove([1, 0])
        pin2_pos = np.add(pin1_pos, possible_orientations[rn_orient]).tolist()

        return pin2_pos

    # Figure out a position for the pins without landing on a "not_allowed" spot
    def get_valid_spot(self, not_allowed_pcb_spots):
        rn_pos_1 = self.get_pin1_pos()
        rn_pos_2 = self.get_pin2_pos(rn_pos_1)
        rn_pos = [rn_pos_1, rn_pos_2]

        i = 0
        while rn_pos[0] in not_allowed_pcb_spots or rn_pos[1] in not_allowed_pcb_spots:
            rn_pos_1 = self.get_pin1_pos()
            rn_pos_2 = self.get_pin2_pos(rn_pos_1)
            rn_pos = [rn_pos_1, rn_pos_2]

            i += 1
        return rn_pos

    # Will make a layout where no pins overlap
    # and are adjusted by some padding (-Jason)
    def randomize_layout(self):
        for component in self.components:
            rn_spot = self.get_valid_spot(self.not_allowed_pcb_spots())
            self.components[component].set_pcb_pos(rn_spot)
        for component in self.components:
            self.components[component].set_pcb_pos(np.add(
                self.components[component].pcb_position, [int(self.a_star_grid_padding/2), int(self.a_star_grid_padding/2)]).tolist())

    # This gets a list for the position for every pin
    def initialize_pin_placement_dict(self):
        pin_placement_dict = {}
        for component in self.components.values():
            pin_ids = list(component.connections.keys())
            for pin_id, pos in zip(pin_ids, component.pcb_position):
                pin_placement_dict |= {pin_id: pos}
        self.pin_placement_dict = pin_placement_dict

    # This gets the connections into a single list
    def initialize_connections_list(self):
        connections_list = []
        for component in self.components.values():
            for pin_id, connections in component.connections.items():
                for connection in connections:
                    if len(connections_list) > 0:
                        if not [connection, pin_id] in connections_list:
                            connections_list.append([pin_id, connection])
                    else:
                        connections_list.append([pin_id, connection])
        self.connections_list = connections_list

    # LOOK AT force base graph layout algorithms as an alternative to this (-Jason)
    # Metropolis' Monte Carlo method. Which means nothing more than
    # lets take a random approach to placing things on a board.
    # Given darts and a dartboard, see what happens (-Jason)
    def monte_carlo(self, max_iters=1000):
        paths = []
        curr_runs_score = 0
        self.initialize_connections_list()
        best_layout = [-1, None]

        # run the iterations up until the target score is reached or we've reached the max_iters
        i = 0
        while (best_layout[0] < self.target_score) and (i < max_iters):
            # Clear some lists to make sure we don't have straggling data
            self.paths.clear()
            self.pin_placement_dict.clear()

            # Randomize the layout of the pins
            # Get the pin placement dict based on the layout
            # Then run A*
            self.randomize_layout()
            self.initialize_pin_placement_dict()
            paths = self.run_a_star()

            # Try connection list as is; if that doesn't work then randomize the order and try again.
            # We do this because the first pin as first pick and probably the best pick. So, it might
            # ruin the chance for another pin making it to their other pin
            j = 0
            while paths == [] and j < 4*len(self.connections_list):
                np.random.shuffle(self.connections_list)
                paths = self.run_a_star()
                j += 1
            if paths == []:
                i += 1
                continue

            # Check if the score is better than the best yet. If so, set the new score and
            # layout as the best then move on to the next iteration
            curr_runs_score = self.calculate_score(paths)
            if curr_runs_score > best_layout[0]:
                best_layout[0] = curr_runs_score
                best_layout[1] = paths
            i += 1

        # The best layout will hopefully not be an empty list. If it is,
        # we tell the user to just try again.
        self.paths = best_layout[1]

    # Used to find the score of a board
    def pcb_area(self, paths):
        min_j = int((self.n_grid_spaces + self.a_star_grid_padding)/2)
        max_j = int((self.n_grid_spaces + self.a_star_grid_padding)/2)
        min_i = int((self.n_grid_spaces + self.a_star_grid_padding)/2)
        max_i = int((self.n_grid_spaces + self.a_star_grid_padding)/2)

        for path in paths:
            for path_node in path["path_nodes"]:
                grid_i = path_node[0]
                grid_j = path_node[1]

                min_i = min(grid_i, min_i)
                max_i = max(grid_i, max_i)
                min_j = min(grid_j, min_j)
                max_j = max(grid_j, max_j)

        return [min_i, max_i, min_j, max_j]

    # For calculating how good a set of paths (pcb layout) is.
    # It is based on total path length and total area (including paths)
    def calculate_score(self, paths):
        worst_total_area = np.square(
            self.n_grid_spaces + self.a_star_grid_padding)
        best_total_area = len(paths)*2
        # based on taking every path in a grid
        worst_path_length = 10 * \
            np.square(self.n_grid_spaces + self.a_star_grid_padding)
        best_path_length = 10  # the pins are right next to one another

        total_path_length = 0
        for path in paths:
            total_path_length += path["length"]
        min_max = self.pcb_area(paths)
        total_area = (min_max[1]-min_max[0])*(min_max[1]-min_max[0])

        score = ((worst_total_area - total_area)/(worst_total_area-best_total_area))*self.area_weight + \
            (worst_path_length - total_path_length) / \
            (worst_path_length - best_path_length)*self.path_length_weight

        return score

    # This method goes through each pair of connections and finds a path between them
    # It keeps track of new paths as obstacles as well.
    def run_a_star(self):
        paths = []
        not_allowed = self.not_allowed_pcb_spots()

        for start_id, goal_id in self.connections_list:
            path = {}
            start_pos = self.pin_placement_dict[start_id]
            goal_pos = self.pin_placement_dict[goal_id]
            not_allowed.remove(start_pos)
            not_allowed.remove(goal_pos)
            grid = PcbGrid(self.n_grid_spaces +
                           self.a_star_grid_padding, not_allowed)

            start_node = grid.nodes[str(start_pos)]
            goal_node = grid.nodes[str(goal_pos)]

            no_paths = grid.a_star(start_node, goal_node)
            if no_paths:
                return []

            path["path_nodes"] = grid.retrace_path(start_node, goal_node)

            not_allowed += path["path_nodes"]
            path["length"] = goal_node.g_cost+1
            path["path_id"] = f"{start_id}->{goal_id}"

            paths.append(path)
            not_allowed.append(start_pos)
            not_allowed.append(goal_pos)

        return paths

    # Used to set the grid to be a bounding box of the points actually used in it. Returns the dims of
    # the new layout.
    def trim_pcb_layout(self):
        print(self.paths)
        pcb_dims = self.pcb_area(self.paths)
        for i in range(0, len(self.paths)):
            nodes = self.paths[i]["path_nodes"]
            for j in range(0, len(nodes)):
                node = nodes[j]
                self.paths[i]["path_nodes"][j] = np.add(np.subtract(
                    node, (pcb_dims[0], pcb_dims[2])), [1, 1]).tolist()

        for component in self.components.values():
            self.components[f"component_{component.id}"].set_pcb_pos(np.subtract(
                component.pcb_position, (pcb_dims[0], pcb_dims[2])).tolist())

        return pcb_dims

    # Converts the data in the schematic paths field to an actual image of traces and pad
    def convert_to_pcb_image(self):
        # Get the settings:
        mode = self.converted_image_color_mode
        scale = self.converted_image_scaling
        bg_color = self.converted_image_bg_color
        trace_color = self.converted_image_trace_color

        # fit the image to the used points
        pcb_dims = self.trim_pcb_layout()

        # Set the size of the image
        nj = abs(pcb_dims[3] - pcb_dims[2])
        ni = abs(pcb_dims[1] - pcb_dims[0])
        width = scale*(nj+2)
        height = scale*(ni+2)
        size = (width, height)
        # print(f"height, width: {height}, {width}")

        # The objects to make the image
        image = Image.new(mode, size, bg_color)
        draw = ImageDraw.Draw(image)
        font = ImageFont.truetype("Roboto-Regular.ttf", 22)

        # the pad dimension
        box_w_h = 10

        # draw each path from point to point
        for path in self.paths:
            nodes = path["path_nodes"]
            points = []

            # draw the lines for the traces
            for i in range(0, len(nodes) - 1):
                i1, j1 = nodes[i]
                i2, j2 = nodes[i+1]
                draw.line((scale*j1, scale*i1, scale*j2, scale*i2),
                          fill=trace_color, width=5)

        # draw each pad
        for path in self.paths:
            nodes = path["path_nodes"]

            # setup and draw the pads
            i_start, j_start = nodes[0]
            i_start = scale*i_start - box_w_h/2
            j_start = scale*j_start - box_w_h/2
            i_goal, j_goal = nodes[-1]
            i_goal = scale*i_goal - box_w_h/2
            j_goal = scale*j_goal - box_w_h/2

            # square rectangles as the pads
            draw.rectangle((j_start, i_start, j_start+box_w_h,
                            i_start+box_w_h), fill=trace_color, width=0)
            draw.rectangle((j_goal, i_goal, j_goal+box_w_h, i_goal +
                            box_w_h), fill=trace_color, width=0)

        # Set up the labels for the component spots
        self.set_labels_for_converted_image(draw, font, height)

        # Set the image field to the completed image
        self.converted_image = image

    # This whole thing just figures out where to place labels relative to the center of the pins for
    # a component. It doesn't completely work since the positions go all wacky for higher complexity
    # schematics. (-Jason)
    def set_labels_for_converted_image(self, draw, font, height):
        for component in self.components:
            scale = self.converted_image_scaling
            trace_color = self.converted_image_trace_color

            pin_positions = self.components[component].pcb_position
            di = (pin_positions[0][0] - pin_positions[1][0])
            dj = (pin_positions[0][1] - pin_positions[1][1])

            # moved along j(columns)
            if di == 0:
                # moved physically upward
                if dj < 0:
                    label_center_j = pin_positions[1][1]+float(dj)/2.0
                    label_center_i = pin_positions[0][0]
                # moved physically downward
                else:
                    label_center_j = pin_positions[1][1]+float(dj)/2.0
                    label_center_i = pin_positions[0][0]
            # moved along i(rows)
            elif dj == 0:
                if di < 0:
                    label_center_j = pin_positions[0][1]
                    label_center_i = pin_positions[1][0]+float(di)/2.0
                else:
                    label_center_j = pin_positions[0][1]
                    label_center_i = pin_positions[1][0]+float(di)/2.0

            label_center_i = (1 + label_center_i) * scale
            label_center_j = (1 + label_center_j) * scale

            label_text = self.components[component].label
            text_size = font.getsize(label_text)
            offset = [float(text_size[1])/2,
                      float(text_size[0])/2]

            label_center_i -= offset[0]
            label_center_j -= offset[1]

            if di == 0:
                if label_center_i > height/2:
                    reading_room = 2*offset[0]
                else:
                    reading_room = -2*offset[0]

            elif dj == 0:
                reading_room = 0

            draw.text((label_center_j, label_center_i + reading_room), label_text,
                      fill=trace_color, font=font)
