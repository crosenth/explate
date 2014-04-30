"""
"""

import os
import sys

from os import path
from ConfigParser import SafeConfigParser
from SCons.Script import (Decider, Variables, Help, Alias)

from bioscons.slurm import SlurmEnvironment

Decider('MD5-timestamp')

analysis_id = path.basename(os.getcwd())

### get the settings
_params = SafeConfigParser(allow_no_value = True)
_params.read('settings.conf')

if not path.exists('settings.conf'):
    sys.exit('Please create a settings.conf file to read from.')

venv = _params.defaults().get('virtualenv') or analysis_id + '-env'

if not path.exists(venv):
    sys.exit('Please specify a virtualenv in settings.conf or '
             'create one using \'bin/bootstrap.sh\'.')

vars = Variables()

for k,v in _params.defaults().items():
    vars.Add(k, default=v)

### PATH and Environment (preference given to local venv executables)
PATH = [
    path.join(venv, 'bin'),
    '/usr/local/bin',
    '/usr/bin',
    '/bin'
]

scons_env = dict(os.environ,
        PATH=':'.join(PATH),
        THREADS_ALLOC=_params.defaults().get('nproc', 1))

env = SlurmEnvironment(
    ENV = scons_env,
    variables = vars,
    SHELL = 'bash',
    use_cluster = False,
    time = True
)

Help(vars.GenerateHelpText(env))

### report generation
report = env.Command(
    target = 'report.html',
    source = 'report.org',
    action = ('emacs '
              '--script bin/org2html.el '
              '-package-dir ./.org-export '
              '-infile $SOURCE '
              '-outfile $TARGET'),
    time = False
    )
Alias('report', report)
###

### Begin script
env.Command(
    target = '',
    source = '',
    action = (''),
    )

