from os import terminal_size
from xml.dom import NO_DATA_ALLOWED_ERR
import classes
import numpy as np
from PIL import Image, ImageDraw


def main():
    # Create a schematic object:
    sch = classes.Schematic()
    # Use gui generated schematic:
    sch.load("CRAZY.circ")
    # sch.print_all_components_strings()

    do_monte_carlo(sch)
    if sch.paths != None:
        convert_to_pcb_image(sch, "demonstration.png")

    sch.overwrite_save("demonstration.json")


def do_monte_carlo(sch):
    # Monte_carlo w/ output:
    sch.set_monte_carlo_parameters(4, 2, .9)
    sch.monte_carlo(50)


def convert_to_pcb_image(sch, file_name):
    sch.convert_to_pcb_image()
    im = sch.converted_image
    im.save(file_name)


if __name__ == "__main__":
    main()
