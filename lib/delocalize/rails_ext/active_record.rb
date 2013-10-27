require 'active_record'
require 'active_record/connection_adapters/abstract/schema_definitions'
require 'active_record/connection_adapters/column'

# let's hack into ActiveRecord a bit - everything at the lowest possible level, of course, so we minimalize side effects
ActiveRecord::ConnectionAdapters::Column.class_eval do
  def date?
    klass == Date
  end

  def time?
    klass == Time
  end
end

if Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('4.0.0')
  require 'delocalize/rails_ext/active_record_rails4'
else
  raise "delocalize4 requires rails > '4.0.0'"
end
