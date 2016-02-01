lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tictactoe/version'

Gem::Specification.new do |gem|
  gem.name    = 'tictactoe'
  gem.version = TicTacToe::VERSION 
  gem.date    = Date.today.to_s

  gem.summary = "TicTacToe Game"
  gem.description = gem.summary
  gem.authors  = ['Sarah Johnston']
  gem.homepage = 'https://github.com/sarahabimay/TicTacToe_Gem'

  gem.add_development_dependency('rspec', [">= 3.4.0"])
  gem.require_paths = ["lib"]
  gem.files = Dir.glob("lib/**/*")
end
