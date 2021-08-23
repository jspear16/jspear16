import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic object
    test_schematic_1 = classes.Schematic()

    # Setup the inital states of the components and test adding them to the schematic
    c1 = {"id": 0, "component_type": "Capacitor"}
    test_schematic_1.add_component(c1)
    c2 = {"id": 1, "component_type": "Capacitor"}
    test_schematic_1.add_component(c2)
    c3 = {'id': 2, 'component_type': "Capacitor"}
    test_schematic_1.add_component(c3)
    d1 = {'id': 3, 'label': 'D1', 'component_type': 'Diode'}
    test_schematic_1.add_component(d1)

    # Test removing components
    test_schematic_1.remove_component(c1['id'])
    test_schematic_1.remove_component(3)

    # Print out component stuff
    test_schematic_1.print_all_components_strings()
