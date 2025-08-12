import os
import sys
from pathlib import Path
import argparse
import dotfile_manager 

def argument_parser():
    parser = argparse.ArgumentParser(description="save and recover dotfiles and configurations")

    parser.add_argument('-s', '--setup', help="""
                        Setup the dotfile program's configuration. Will setup the config stored in 
                        repository on local machine. This will not install the program, only setup 
                        the config.
                        Usage: python setup_sage.py -s <program_name>
                        """,)

    parser.add_argument('-b', '--backup',
                        help="""
                        Backup the dotfile program's configuration. Will backup the config stored in 
                        local machine to repository. This will not install the program, only backup 
                        the config.
                        Usage: python setup_sage.py -b <program_name>
                        """, 
                        nargs=2)

    parser.add_argument('-an', '--add_new_program', 
                        help="""
                        Add a new program to the dotfile repository. Will add the program's config 
                        to the repository. This will not install the program, only add the config.
                        Usage: python setup_sage.py -an <program_name> <pathl_to_config>
                        """,
                        nargs=2)

    return parser.parse_args()

def setup_program(program_name):
    # Placeholder function to setup a program's configuration
    # This function would contain the logic to setup the program's config
    print(f"Setting up configuration for {program_name}...")


def main(): 
    args = argument_parser()
    manager = dotfile_manager.DotFileManager()
    manager.load_config()


    if args.setup:
        program_name = args.setup
        print(f"Setting up configuration for {program_name}...")
        manager.setup_program(program_name)
        print(f"Configuration for {program_name} has been set up.")

    elif args.backup:
        program_name = args.backup

        print(f"Backing up configuration for {program_name}...")
        manager.setup_program(program_name)
        print(f"Configuration for {program_name} has been backed up.")

    elif args.add_new_program:

        program_name = args.add_new_program[0]
        path_to_config = args.add_new_program[1]

        print(f"Adding new program {program_name} with config at {path_to_config}...")

        # Here you would add the logic to add a new program to the dotfile repositoryo
        manager.add_program(program_name, path_to_config)

        print(f"Program {program_name} has been added with config at {path_to_config}.")
    
    else:
        print("No valid arguments provided. Use -h for help.")



if __name__ == "__main__":
    exit(main())
