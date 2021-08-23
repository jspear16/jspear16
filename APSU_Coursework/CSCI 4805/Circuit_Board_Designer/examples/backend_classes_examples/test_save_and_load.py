import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic
    test_schematic_1 = classes.Schematic()

    # Setup the inital states of the components and test adding them to the schematic
    c1 = {"id": 0, "component_type": "Capacitor"}
    test_schematic_1.add_component(c1)
    c2 = {"id": 1, "component_type": "Capacitor"}
    test_schematic_1.add_component(c2)

    # Set schematic position
    test_schematic_1.set_component_schematic_pos("0", 200, 200)
    test_schematic_1.set_component_schematic_pos("1", 100, 200)

    # Set pcb positions randomly
    test_schematic_1.set_monte_carlo_parameters(3, 10, 2)
    test_schematic_1.randomize_layout()

    # Test the save function (output to test1.json)
    # file_name_1 = input("Filename:   ") + ".json"
    file_name_1 = "test_classes"
    test_schematic_1.save(file_name_1)

    # delete the schematic
    del test_schematic_1

    # Test the load function (from test1.json) into a new schematic
    test_schematic_2 = classes.Schematic()
    test_schematic_2.load(file_name_1)

    # To see how everything worked (save as test2.json)
    file_name_2 = input("Filename:   ") + ".json"
    test_schematic_2.save(file_name_2)
