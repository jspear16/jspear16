import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic
    test_schematic_1 = classes.Schematic()

    # Setup the inital states of the components and add them to the schematic
    c1 = {"id": 0, "component_type": "Capacitor"}
    test_schematic_1.add_component(c1)
    c2 = {"id": 1, "component_type": "Capacitor"}
    test_schematic_1.add_component(c2)

    # Print out svg stuff before connections are made.
    test_schematic_1.get_component("0").print_svg("cap1.svg")
    test_schematic_1.get_component("1").print_svg("cap2.svg")

    # Add connections between the 2 components
    test_schematic_1.add_connection("0_0", "1_1")
    test_schematic_1.add_connection("0_1", "1_0")

    # Print out svg stuff after connections are made.
    test_schematic_1.get_component("0").print_svg("cap1.svg")
    test_schematic_1.get_component("1").print_svg("cap2.svg")

    # Remove the connections
    test_schematic_1.remove_connection("0_0", "1_1")
    test_schematic_1.remove_connection("0_1", "1_0")

    # Print out svg stuff after removing connections.
    test_schematic_1.get_component("0").print_svg("cap1.svg")
    test_schematic_1.get_component("1").print_svg("cap2.svg")
