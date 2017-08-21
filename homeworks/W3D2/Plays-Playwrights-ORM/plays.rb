require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id
  attr_reader :id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)
    plays = PlayDBConnection.instance.execute(
    <<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE
        title LIKE ?
    SQL

    return nil if plays.empty?

    Play.new(plays[0])
  end

  def self.find_by_playwright(name)
    writter = Playwright.find_by_name(name)
    raise "Can't find a play with the writter's name #{name}" if !writter

    plays = PlayDBConnection.instance.execute(
    <<-SQL, writter.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL

    return nil if plays.empty?

    plays.map { |a_play| Play.new(a_play) }
  end
end

class Playwright
  attr_accessor :name, :birth_year
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum|  Playwright.new(datum)}
  end

  def self.find_by_name(name)
    writter = PlayDBConnection.instance.execute(
    <<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name LIKE ?
    SQL

    return nil if writter.empty?

    Playwright.new(writter[0])
  end

  def create
    raise "Already in the database" if @id

    PlayDBConnection.instance.execute(
    <<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights(name, birth_year)
      VALUES
        (?, ?)
    SQL

    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "Not in the Database" if !@id
    PlayDBConnection.instance.execute(
    <<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    Play.find_by_playwright(@name)
  end

end
