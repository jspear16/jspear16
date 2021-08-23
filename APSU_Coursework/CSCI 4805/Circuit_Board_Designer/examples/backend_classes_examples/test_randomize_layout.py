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

    # Testing randomize_layout
    test_schematic_1.set_monte_carlo_parameters(3, 2, 10)
    test_schematic_1.randomize_layout()

    # Print out component stuff
    test_schematic_1.print_all_components_strings()
