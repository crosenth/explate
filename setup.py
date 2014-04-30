"""
"""

import subprocess

from setuptools import setup, find_packages

version = subprocess.check_output('git describe --tags', shell = True).strip()

setup(name = '',
      author = '',
      author_email = '',
      packages = find_packages(),
      description = '',
      version = version,
      install_requires = ['bioscons']
      )

