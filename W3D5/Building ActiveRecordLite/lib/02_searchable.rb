require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    columns = params.keys.map(&:to_s).join(' = ? AND ')
    columns += ' = ?'
    values = params.values

    result = DBConnection.execute(<<-SQL, values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{columns}
    SQL

    self.parse_all(result)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable

end
