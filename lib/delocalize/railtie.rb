module Delocalize
  class Railtie < Rails::Railtie
    initializer "delocalize" do |app|
      ActiveSupport.on_load :active_record do
        require 'delocalize/rails_ext/active_record'
      end

      require 'delocalize/rails_ext/time_zone'
    end
  end
end
