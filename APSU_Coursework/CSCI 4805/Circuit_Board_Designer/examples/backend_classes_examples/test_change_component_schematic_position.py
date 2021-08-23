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

    # Test setting the schematic position
    test_schematic_1.set_component_schematic_pos("0", 200, 200)
    test_schematic_1.set_component_schematic_pos("1", 100, 200)

    # Print out component stuff
    test_schematic_1.print_all_components_strings()
