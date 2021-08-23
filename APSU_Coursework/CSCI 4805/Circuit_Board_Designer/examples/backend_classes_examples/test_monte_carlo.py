from xml.dom import NO_DATA_ALLOWED_ERR
import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic object
    sch = classes.Schematic()

    # # Setup the inital states of the components and add them to the schematic
    # c1 = {"id": 0, "component_type": "Capacitor"}
    # sch.add_component(c1)
    # c2 = {"id": 1, "component_type": "Capacitor"}
    # sch.add_component(c2)
    # c3 = {"id": 2, "component_type": "Capacitor"}
    # sch.add_component(c3)

    # # Add connections between the 2 components
    # sch.add_connection("0_1", "1_1")
    # sch.add_connection("0_0", "1_0")
    # sch.add_connection("1_1", "2_1")
    # sch.add_connection("1_0", "2_0")

    # Test using gui generated file
    sch.load("jason_test_monte_through_gui.circ")

    # sch.initialize_connections_list()
    # sch.randomize_layout()
    # sch.initialize_pin_placement_dict()
    # paths = sch.run_a_star()

    # j = 0
    # while paths == [] and j < 2*len(sch.connections_list):
    #     print("Trying different order for connections list")
    #     np.random.shuffle(sch.connections_list)
    #     paths = sch.run_a_star()
    #     j += 1
    # if paths == []:
    #     print("Couldn't find an ordering that worked...making new layout")

    # sch.paths = sch.run_a_star()
    # for path in sch.paths:
    #     path_id = path["path_id"]
    #     path_nodes = path["path_nodes"]
    #     path_length = path["length"]
    #     print(
    #         f"Path: {path_id}\nPath nodes: {path_nodes}\nLength: {path_length}")

    # Test monte_carlo:
    sch.set_monte_carlo_parameters(4, 4, .75)
    sch.monte_carlo(3000)
    for path in sch.paths:
        path_id = path["path_id"]
        path_nodes = path["path_nodes"]
        path_length = path["length"]
        print(
            f"Path: {path_id}\nPath nodes: {path_nodes}\nLength: {path_length}")
    if sch.paths == []:
        print(f"No valid Layout")
    else:
        print(f"\nLayout Score: {sch.calculate_score(sch.paths)}")

    sch.overwrite_save("jason_test_monte_through_gui_1.circ")
