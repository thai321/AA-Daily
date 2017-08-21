require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    data = {
      foreign_key: (name.to_s + "_id").to_sym,
      class_name: name.capitalize.to_s,
      primary_key: :id
    }

    data.each do |attribute, data_val|
      value = options[attribute] || data_val
      self.send(attribute.to_s + "=", value)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    data = {
      foreign_key: (self_class_name.to_s.downcase + "_id").to_sym,
      class_name: name.to_s.singularize.capitalize,
      primary_key: :id
    }

    data.each do |attribute, data_val|
      value = options[attribute] || data_val
      self.send(attribute.to_s + "=", value)
    end

  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    temp = BelongsToOptions.new(name, options)
    self.assoc_options[name] = temp

    define_method(name) do
      options = self.class.assoc_options[name]
      val = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => val).first
    end
  end

  def has_many(name, options = {})
    # ...
    temp = HasManyOptions.new(name, self.name, options)
    self.assoc_options[name] = temp

    define_method(name) do
      options = self.class.assoc_options[name]
      val = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => val)
    end

  end

  def assoc_options

    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options = {} if @assoc_options.nil?
    @assoc_options
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
