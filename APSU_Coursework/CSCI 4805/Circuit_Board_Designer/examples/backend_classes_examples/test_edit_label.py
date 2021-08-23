import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic object
    test_schematic_1 = classes.Schematic()

    # Setup the inital state of the component
    # and add it to the schematic
    c1 = {"id": 0, "component_type": "Capacitor"}
    test_schematic_1.add_component(c1)

    # Test adding a label to the component
    test_schematic_1.edit_label(0, "C1")

    # Print out component stuff
    test_schematic_1.print_all_components_strings()
