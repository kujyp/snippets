#!/usr/bin/env python
import os


def get_script_directory():
    """
    It removes a dependency from the current working directory.
    These has same results:
    $ (cd ci_tools; ./check_requirements_has_no_inequality_signs)
    $ ci_tools/check_requirements_has_no_inequality_signs
    """
    return os.path.abspath(os.path.dirname(__file__))


def get_project_root():
    return os.path.normpath(os.path.join(get_script_directory(), ".."))


def err_msg(msg):
    print("\033[0;31m[ERROR] {}\033[0m".format(msg))


def main():
    about_path = os.path.join(get_project_root(), "mtstaticdependency", "about.py")
    about = {}
    with open(about_path) as f:
        exec(f.read(), about)

    if "__version__" not in about:
        err_msg("Getting version failed.")
        exit(1)

    print(about["__version__"])


if __name__ == '__main__':
    main()
