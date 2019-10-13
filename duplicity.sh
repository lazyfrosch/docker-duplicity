#!/usr/bin/env python

import warnings
warnings.simplefilter(action='ignore', category=DeprecationWarning)
warnings.simplefilter(action='ignore', category=FutureWarning)
warnings.simplefilter(action='ignore', category=ResourceWarning)

import imp
imp.load_source('__main__', '/usr/bin/duplicity')
