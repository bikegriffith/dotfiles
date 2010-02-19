#!/usr/bin/env python
#
# This is a test runner that tries to silence most of the output, and only
# display what's absolutely necessary to find which line caused an error.
# It's used by the .vimrc test running plugin.
#
from __future__ import print_function

import sys
import nose
import warnings


def main(sysargs=sys.argv[:]):
    return Runner(sysargs).run()


class Runner(object):
    ignored_warnings = [DeprecationWarning, SyntaxWarning, RuntimeWarning]

    def __init__(self, sysargs=sys.argv[:]):
        self.is_debug = '-D' in sysargs[1:]
        self.sysargs = sysargs
        self.nose_args = ['nosetests']

    def run(self):
        self._ignore_stuff()
        self._prep_nose_args()
        self._show_command_if_debug()
        return self._run_nose()

    def _ignore_stuff(self):
        for to_ignore in self.ignored_warnings:
            warnings.simplefilter('ignore', to_ignore)

    def _prep_nose_args(self):
        #self.nose_args += ['-c', self.noseconf_dir/'default.ini']
        #if '-i' in self.sysargs[1:]:
        #    self.nose_args += ['-c', self.noseconf_dir/'with-itests.ini']
        #    del self.sysargs[self.sysargs.index('-i')]
        self.nose_args += self.sysargs[1:]

    def _show_command_if_debug(self):
        if self.is_debug:
            print('# ----> {0}'.format(' '.join(self.nose_args)))

    def _run_nose(self):
        return nose.run(argv=self.nose_args)


if __name__ == '__main__':
    sys.exit(main())
