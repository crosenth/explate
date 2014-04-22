"""
"""

import os
import sys

from os import path
from ConfigParser import SafeConfigParser

from SCons.Script import (Decider, Variables, Environment, Help, Alias)

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

# time stamp feature
vars.Add('time',
         'system path to the time function',
         '/usr/bin/time --verbose --output ${TARGETS[0]}.time')

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

env = Environment(
    ENV = scons_env,
    variables = vars,
    SHELL = 'bash'
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
              '-outfile $TARGET')
    )
Alias('report', report)
###

### Begin script
env.Command(
    target = '',
    source = '',
    action = ('')
    )

