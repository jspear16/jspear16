from xml.dom import NO_DATA_ALLOWED_ERR
import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic object
    sch = classes.Schematic()

    # Setup the inital states of the components and add them to the schematic
    c1 = {"id": 0, "component_type": "Capacitor"}
    sch.add_component(c1)
    c2 = {"id": 1, "component_type": "Capacitor"}
    sch.add_component(c2)
    c3 = {"id": 2, "component_type": "Capacitor"}
    sch.add_component(c3)

    # Add connections between the 2 components
    sch.add_connection("0_1", "1_1")
    sch.add_connection("0_0", "1_0")
    sch.add_connection("1_1", "2_1")
    sch.add_connection("1_0", "2_0")

    # Setup a layout.
    sch.set_monte_carlo_parameters(4, 2, 10)
    sch.randomize_layout()
    sch.initialize_pin_placement_dict()
    sch.initialize_connections_list()

    # See where the components are.
    sch.print_all_components_strings()

    # # Do what A* should do
    # not_allowed = sch.not_allowed_pcb_spots()

    # start_pos = sch.pin_placement_dict[sch.connections_list[0][0]]
    # goal_pos = sch.pin_placement_dict[sch.connections_list[0][1]]
    # not_allowed.remove(start_pos)
    # not_allowed.remove(goal_pos)

    # grid = classes.PcbGrid(sch.n_grid_spaces +
    #                        sch.a_star_grid_padding, not_allowed)

    # start_node = grid.nodes[str(start_pos)]
    # goal_node = grid.nodes[str(goal_pos)]

    # grid.a_star(start_node, goal_node)
    # path={}
    # path["path_nodes"] = grid.retrace_path(start_node, goal_node)
    # print(path["path_nodes"])

    # not_allowed.append(start_pos)
    # not_allowed.append(goal_pos)

    # path = grid.retrace_path(start_node, goal_node)
    # length = goal_node.g_cost

    # print(f"Path Nodes: {path}\nLength: {length}")

    # lst = []
    # node = goal_node
    # while node != start_node:
    #     # print(node.pos, node.parent)
    #     lst.append(node.pos)
    #     node = node.parent
    # else:
    #     lst.append(start_node.pos)

    # lst.reverse()
    # print(lst)

    # Run A* on the layout.
    sch.paths = sch.run_a_star()
    for path in sch.paths:
        path_id = path["path_id"]
        path_nodes = path["path_nodes"]
        path_length = path["length"]
        print(
            f"Path: {path_id}\nPath nodes: {path_nodes}\nLength: {path_length}")
    if sch.paths == []:
        print(f"No valid path")

    # sch.overwrite_save("a_star_test_out")
