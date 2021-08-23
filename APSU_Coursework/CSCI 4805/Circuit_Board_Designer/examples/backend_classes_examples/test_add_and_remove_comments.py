import classes
import numpy as np

if __name__ == "__main__":
    # Create a schematic object
    test_schematic_1 = classes.Schematic()

    # Setup the initial state of the comment and test adding it to the schematic
    comm1 = {"id": 0, "text": "Hello, world! 1", "position": [10, 0]}
    test_schematic_1.add_comment(comm1)
    comm2 = {"id": 0, "text": "Hello, world 2!", "position": [10, 20]}
    test_schematic_1.add_comment(comm2)

    # Test removing the comment from
    test_schematic_1.remove_comment(comm1["id"])

    # Print out comment stuff
    test_schematic_1.print_all_comments_strings()
