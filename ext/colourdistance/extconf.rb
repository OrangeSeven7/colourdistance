require 'mkmf'
require 'rake/extensiontask'

$CFLAGS = "--std=c99 -O"

extension_name = 'colourdistance/colourdistance'

create_makefile(extension_name)
Rake::ExtensionTask.new(extension_name)