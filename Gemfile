# source 'https://rubygems.org'
source 'http://bundler-api.herokuapp.com'
ruby '2.0.0'

gem 'rake',                         '~> 10.0.3'
gem 'puma',                         '~> 1.6'
gem 'rails',          :git => "git://github.com/rails/rails.git",             :branch => "master"
gem 'pg',                           '~> 0.14'
gem 'draper',                       '~> 1.1'
gem 'devise',         :git => "git://github.com/plataformatec/devise.git",    :branch => "rails4"

gem 'coffee-rails',   :git => "git://github.com/rails/coffee-rails.git",      :branch => "master"
gem 'sass-rails',     :git => "git://github.com/rails/sass-rails.git",        :branch => "master"
gem 'haml-rails',                   '~> 0.4'
gem 'bootstrap-sass',               '~> 2.3'

# to speed Travis-CI up
group :development, :production do
  gem 'jquery-rails',                 '~> 2.2'
  gem 'execjs',                       '~> 1.4'
  gem 'libv8',                        '~> 3.16'
  gem 'therubyracer',   :git => "git://github.com/cowboyd/therubyracer",        :branch => "master"
  gem 'uglifier',                     '~> 2.0'
end

group :development do
  gem 'awesome_print',              '~> 1.1'
  gem 'letter_opener',              '~> 1.1'
  gem 'pry'
end

group :development, :test do
  gem 'rspec-rails',                '~> 2.13'
  gem 'coveralls',                  '~> 0.6',        require: false
end


  # gem 'thin',               '~> 1.3'
  # gem 'foreman',            '~> 0.50'
  # gem 'omniauth',           '~> 1.1'
  # gem 'omniauth-dropbox',   '~> 0.2'
  # gem 'omniauth-facebook',  '~> 1.4'
  # gem 'omniauth-github',    '~> 1.0'
  # gem 'omniauth-openid',    '~> 1.0'
  # gem 'omniauth-twitter',   '~> 0.0.8'
  # gem 'omniauth-xing',      '~> 0.1'
  # gem 'dropbox-api',        '~> 0.3'
  # gem 'simple_form',        '~> 2.0'
  # gem 'httparty',           '~> 0.8'
  #  gem 'rdiscount'
  #  gem 'carrierwave'
  #  gem 'active_admin'
  #  gem 'kaminari'

  # development / test
  # gem 'ffaker',                     '~> 1.15'
  # gem 'factory_girl_rails',         '~> 4.2'
  # gem 'spring',                     '~> 0.0.7'