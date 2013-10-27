ActiveRecord::ConnectionAdapters::Column.class_eval do

  def type_cast_with_localization(value)
    new_value = value
    if number? && I18n.delocalization_enabled?
      new_value = Numeric.parse_localized(value)
    elsif date?
      new_value = Date.parse_localized(value) rescue value
    elsif time?
      new_value = Time.parse_localized(value) rescue value
    end
    type_cast_without_localization(new_value)
  end

  alias_method_chain :type_cast, :localization

  def type_cast_for_write_with_localization(value)
    new_value = value
    if number? && I18n.delocalization_enabled?
      new_value = Numeric.parse_localized(value)
      new_value = (type == :integer) ? new_value.to_i : new_value.to_f
    elsif date?
      new_value = Date.parse_localized(value) rescue value
    elsif time?
      new_value = Time.parse_localized(value) rescue value
    end
    type_cast_for_write_without_localization(new_value)
  end

  alias_method_chain :type_cast_for_write, :localization
end
