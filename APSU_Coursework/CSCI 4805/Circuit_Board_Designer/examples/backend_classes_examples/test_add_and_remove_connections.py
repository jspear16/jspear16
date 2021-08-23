import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic object
    test_schematic_1 = classes.Schematic()

    # Setup the inital states of the components and add them to the schematic
    c1 = {"id": 0, "component_type": "Capacitor"}
    test_schematic_1.add_component(c1)
    c2 = {"id": 1, "component_type": "Capacitor"}
    test_schematic_1.add_component(c2)

    # Test adding connections between 2 components
    test_schematic_1.add_connection("0_0", "1_1")
    test_schematic_1.add_connection("0_1", "1_0")

    # Short out a component and then unshort its pins (test removing a connection)
    test_schematic_1.add_connection("0_1", "0_0")
    test_schematic_1.remove_connection("0_1", "0_0")

    # Print out component stuff
    test_schematic_1.print_all_components_strings()
