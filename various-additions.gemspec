Gem::Specification.new do |lib|
  lib.name          = 'various-additions'
  lib.version       = '0.3.3'
  lib.date          = '2021-02-09'
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
