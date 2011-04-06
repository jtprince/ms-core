require 'rubygems'
require 'spec/more'

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(this_dir)
$LOAD_PATH.unshift(File.join(this_dir, '..', 'lib'))

TESTFILES = this_dir + "/tfiles"

Bacon.summary_on_exit
