require_relative '03_associatable'
require 'byebug'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ...
    define_method(name) do

      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      from_table_primary_key = through_options.primary_key
      to_table_primary_key = source_options.primary_key

      from_table_foreign_key = through_options.foreign_key
      target_table_foreign_key = source_options.foreign_key

      from_table = through_options.table_name
      to_table = source_options.table_name

      result = DBConnection.execute(<<-SQL, self.id)
        SELECT
          #{to_table}.*
        FROM
          #{to_table}
        JOIN
          #{from_table}
        ON
          #{from_table}.#{to_table_primary_key} = #{to_table}.#{to_table_primary_key}
        WHERE
          #{from_table}.#{from_table_primary_key} = ?
      SQL

      source_options.model_class.parse_all(result).first
    end

  end
end
