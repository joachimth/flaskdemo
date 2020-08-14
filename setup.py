#!/usr/bin/env python
from setuptools import setup, find_packages
from os import environ

PROJECT_NAME = 'flask-demo-app'

PROJECT_DESCRIPTION = 'Flask Demo App'


def version():
    return environ.get('BUILD_VERSION', '1.0.dev0')


def requirements(filename):
    with open(filename) as requirements:
        for requirement in requirements:
            yield requirement


setup(name=PROJECT_NAME,
      version=version(),
      description=PROJECT_DESCRIPTION,
      package_dir={'': 'src'},
      packages=find_packages('src'),
      include_package_data=True,
      install_requires=list(requirements('requirements.txt')))
