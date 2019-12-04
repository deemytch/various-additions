Gem::Specification.new do |lib|
  lib.name          = 'various-additions'
  lib.version       = '0.1.0'
  lib.date          = '2019-12-04'
  lib.summary       = 'Улучшения стандартных классов, которые не вошли в monkey-hash'
  lib.files         = Dir[ 'lib/*rb' ]
  lib.require_paths = %w[ lib ]
  lib.authors       = [ 'Dimitri Pekarovsky' ]
  lib.email         = 'dimitri@pekarovsky.name'
  lib.licenses      = ['GPL-2.0']
  lib.homepage      = 'https://gitlab.sudo.su/amqp-lib/various-additions'

  lib.add_runtime_dependency 'monkey-hash'
  lib.add_runtime_dependency 'cfgstore'
end
