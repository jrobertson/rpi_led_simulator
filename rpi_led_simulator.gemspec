Gem::Specification.new do |s|
  s.name = 'rpi_led_simulator'
  s.version = '0.2.1'
  s.summary = "Simulates the rpi gem's functionality for controlling LEDs."
  s.authors = ['James Robertson']
  s.files = Dir['lib/rpi_led_simulator.rb']
  s.add_runtime_dependency('pinx', '~> 0.1', '>=0.1.3')
  s.add_runtime_dependency('colored', '~> 1.2', '>=1.2')
  s.signing_key = '../privatekeys/rpi_led_simulator.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/rpi_led_simulator'
end
