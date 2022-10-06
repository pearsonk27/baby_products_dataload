"""CLI interface for baby_products_dataload project.

Be creative! do whatever you want!

- Install click or typer and create a CLI app
- Use builtin argparse
- Start a web application
- Import things from your .base module
"""
import json
import os
import baby_products_dataload.database.product_repo as product_repo

dir_path = os.path.dirname(os.path.realpath(__file__))
data_path = os.path.join(dir_path, 'data/products.json')

def main():  # pragma: no cover
    """
    The main function executes on commands:
    `python -m baby_products_dataload` and `$ baby_products_dataload `.

    This is your program's entry point.

    You can change this function to do whatever you want.
    Examples:
        * Run a test suite
        * Run a server
        * Do some other stuff
        * Run a command line application (Click, Typer, ArgParse)
        * List all available tasks
        * Run an application (Flask, FastAPI, Django, etc.)
    """
    with open(data_path) as jsonFile:
        jsonObject = json.load(jsonFile)
        jsonFile.close()

    for baby_product in jsonObject:
        print("Adding...")
        print(baby_product)
        product_repo.add_product(baby_product["name"], baby_product["price"])
        for feature in baby_product["features"]:
            product_repo.add_feature(baby_product["name"], feature)
        for accolade in baby_product["accolades"]:
            product_repo.add_accolade(baby_product["name"], accolade["accolade"], accolade["source"])
