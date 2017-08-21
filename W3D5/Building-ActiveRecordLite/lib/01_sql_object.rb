require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

require 'byebug'

class SQLObject

  def self.columns
    # ...
    return @columns if @columns
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT 1
    SQL

    @columns = columns.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end

      define_method(column.to_s + "=") do |val|
        self.attributes[column] = val
      end
    end

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name || self.name.tableize
  end

  def self.all
    # ...
    items = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    self.parse_all(items)
  end

  def self.parse_all(results)
    # ...

    results.map do |result|
      self.new(result)
    end

  end

  def self.find(id)
    # ...
    item = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = ?
    SQL

    return nil if item.empty?
    self.new(item.first)
  end

  def initialize(params = {})
    # ...
    params.each do |attribute, val|
      # self is Cat instance object, <cat#..234> --> self.class -> Cat's class object
      if !self.class.columns.include?(attribute.to_sym)
        raise "unknown attribute '#{attribute}'"
      else
        send(attribute.to_s + "=", val)
      end
    end

  end

  def attributes
    # ...
    return @attributes if @attributes
    @attributes = {}
  end

  def attribute_values
    # ...
    @attributes.values
  end

  def insert
    # ...
    col_names = "(" + self.class.columns[1..-1].map(&:to_s).join(',') + ")"

    len = self.class.columns.length - 1
    values = self.attribute_values
    question_marks = "(" + (["?"] * len).join(',') + ")"

    DBConnection.execute(<<-SQL, values)
    INSERT INTO
      #{self.class.table_name} #{col_names}
    VALUES
      #{question_marks}
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    col_names = self.class.columns[1..-1].map(&:to_s).join(' = ?, ')
    col_names += ' = ?'
    id, values = self.attribute_values[0] ,self.attribute_values[1..-1]

    DBConnection.execute(<<-SQL, values, id )
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    # ...
    self.id.nil? ? insert : update
  end
end
