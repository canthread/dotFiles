import os
import hashlib
import shutil



class DotFileProgram:

    def __init__(self, name="", config_path="", backup_path=""):
        self.name = name
        self.config_path = config_path 
        self.backup_path= backup_path 

    def get_config_path(self):
        """Returns the path to the configuration file for the dotfile program."""
        return config_path.path
    
    def set_config_path(self, new_path):
        """Sets a new path for the configuration file of the dotfile program."""
        self.config_path = new_path

    def get_program_name(self):
        """Returns the name of the dotfile program."""
        return self.name
     
    def set_program_name(self, new_name):
        """Sets a new name for the dotfile program."""
        self.name = new_name


class DotFileManager:

    REPO_LOCATION = os.getcwd()  # Points to the current working directory for the repository
    DOTFILE_CONFIG_FILE = REPO_LOCATION / "config.txt"

    def __init__(self):
        self.programs = []

    def load_config(self):
        """Loads the list of dotfile programs from config.txt."""
        if not os.path.exists(self.DOTFILE_CONFIG_FILE):
            raise FileNotFoundError(f"Config file not found: {self.DOTFILE_CONFIG_FILE}")

        with open(self.DOTFILE_CONFIG_FILE, "r") as file:
            for line in file:
                line = line.strip()
                if line:  # Skip empty lines
                    name, path = line.split(maxsplit=1)  # Split into name and path
                    program = DotFileProgram(name, path)
                    self.programs.append(program)


    def save_config(self):
        """Saves the list of dotfile programs to config.txt."""
        with open(self.DOTFILE_CONFIG_FILE, "w") as file:
            for program in self.programs:
                file.write(f"{program.name} {program.path}\n")

    def remove_program(self, name):
        """Removes a dotfile program from the manager."""
        program = self.get_program(name)

        if program is None:
            raise KeyError(f"Program {name} not found.")

        self.programs.remove(program)

        # Update the config file
        with open(self.DOTFILE_CONFIG_FILE, "w") as file:
            for prog in self.programs:
                file.write(f"{prog.name} {prog.path}\n")

    def add_program(self, name, path):
        """Adds a new dotfile program to the manager."""
        found = any(program.name == name for program in self.programs)
        if found:
            raise ValueError(f"Program {name} already exists.")

        self.programs.append(DotFileProgram(name, path))
        with open(self.DOTFILE_CONFIG_FILE, "a") as file:
            file.write(f"{name} {path}\n")

    def get_program(self, name):
        """Checks if a dotfile program exists by its name.
        Returns the program if found, otherwise None."""
        return next((program for program in self.programs if program.name == name), None) 

    def setup_programs(self):
        """Sets up the dotfile programs by creating necessary directories."""
        for program in self.programs:
            if not os.path.exists(program.path):
                # Create the directory for the program if it does not exist
                os.makedirs(program.path, exist_ok=True)
                print(f"Created directory for {program.name} at {program.path}")
                path = self.REPO_LOCATION / program.name
                shutil.copytree(path_to_repo_config, program.path, dirs_exist_ok=True)
                print(f"Copied configuration for {program.name} to {program.path}")
            else:
                print(f"Directory for {program.name} already exists at {program.path}")

    def backup_program(self, name):
        """Backs up a dotfile program's configuration to the repository."""

        program = self.get_program(name)

        # check if the program actually exists
        if program is None:
            raise KeyError(f"Program {name} not found.")

        if not os.path.exists(program.path):
            raise FileNotFoundError(f"Configuration path for {name} does not exist: {program.path}")

        if not os.path.isdir(program.path):
            raise NotADirectoryError(f"Configuration path for {name} is not a directory: {program.path}")

        # open the repository directory and remove all files and directories in it
        # copy all files and directoris from the programs path to the repository directory
        path_to_repo_config = self.REPO_LOCATION / program.name

        # Remove the existing directory in the repo, if it exists
        if os.path.exists(path_to_repo_config):
            shutil.rmtree(path_to_repo_config)

        # Copy the program's config directory to the repo
        shutil.copytree(program.path, path_to_repo_config)
        
        print(f"Backing up configuration for {program.name} at {program.path}...")

    def list_programs(self):
        """Lists all dotfile programs managed by the manager."""
        return list(self.programs.values())

    def set_config_path(self, new_path):
        """Sets a new path for the configuration file of a dotfile program."""
        self.CONFIG_FILE = new_path 

    
    def hash_directory(directory_path):
        """Compute a hash for the contents of a directory."""
        sha256 = hashlib.sha256()

        for root, dirs, files in sorted(os.walk(directory_path)):
            for file_name in sorted(files):
                file_path = os.path.join(root, file_name)
                sha256.update(file_name.encode())  # Include file name in hash
                try:
                    with open(file_path, 'rb') as f:
                        while chunk := f.read(8192):
                            sha256.update(chunk)  # Include file content in hash
                except FileNotFoundError:
                # Handle files that might be deleted during hashing
                    continue

        return sha256.hexdigest()
