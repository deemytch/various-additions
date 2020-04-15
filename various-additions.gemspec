Gem::Specification.new do |lib|
  lib.name          = 'various-additions'
  lib.version       = '0.3.1'
  lib.date          = '2020-04-15'
  lib.summary       = 'Дополнения и полезные утилиты, которые не вошли в monkey-hash'
  lib.files         = Dir[ 'lib/*rb' ]
  lib.require_paths = %w[ lib ]
  lib.author        = 'deemytch'
  lib.email         = 'aspamkiller@yandex.ru'
  lib.license       = 'GPL-2.0'
  lib.homepage      = 'https://github.com/deemytch/various-additions'

  lib.add_runtime_dependency 'monkey-hash'
  lib.add_runtime_dependency 'cfgstore'
end
