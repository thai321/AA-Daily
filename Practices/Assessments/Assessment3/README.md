
```ruby
# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer


def example_select
  execute(<<-SQL)
    SELECT
      population
    FROM
      countries
    WHERE
      name = 'France'
  SQL
end

def select_population_of_germany
  execute(<<-SQL)
    SELECT
      population
    FROM
      countries
    WHERE
      name = 'Germany'
  SQL
end

def per_capita_gdp
  # Show the name and per capita gdp (gdp/population) for each country where
  # the area is over 5,000,000 km^2
  execute(<<-SQL)
    SELECT
      name, gdp/population
    FROM
      countries
    WHERE
      area > 5000000
  SQL
end

def small_and_wealthy
  # Show the name and continent of countries where the area is less than 2,000
  # and the gdp is more than 5,000,000,000.
  execute(<<-SQL)
    SELECT
      name, continent
    FROM
      countries
    WHERE
      area < 2000
      AND gdp > 5000000000
  SQL
end

def scandinavia
  # Show the name and the population for 'Denmark', 'Finland', 'Norway', and
  # 'Sweden'
  execute(<<-SQL)
    SELECT
      name, population
    FROM
      countries
    WHERE
      name IN ('Denmark', 'Finland', 'Norway', 'Sweden')

  SQL
end

def starts_with_g
  # Show each country that begins with the letter G
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      name LIKE 'G%'
  SQL
end

def just_the_right_size
  # Show the country and the area in 1000's of square kilometers for countries
  # with an area between 200,000 and 250,000.
  # BETWEEN allows range checking - note that it is inclusive.
  execute(<<-SQL)
    SELECT
      name, area/1000
    FROM
      countries
    WHERE
      area BETWEEN 200000 AND 250000
  SQL
end


# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def example_select
  execute(<<-SQL)
    SELECT
      population
    FROM
      countries
    WHERE
      name = 'France'
  SQL
end

def large_countries
  # Show the names of the countries that have a population of at least
  # 200 million. 200 million is 200,000,000 (eight zeros).
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      population >= 200000000
  SQL
end

def high_population_gdps
  # Give the names and the per capita GDPs of countries with a population
  # of at least 200 million.
  execute(<<-SQL)
    SELECT
      name, gdp/population
    FROM
      countries
    WHERE
      population > 200000000
  SQL
end

def population_in_millions
  # Show the name and population in millions for the countries with continent
  # 'South America'. Divide the population by 1,000,000 to get population in
  # millions.
  execute(<<-SQL)
    SELECT
      name, population/1000000
    FROM
      countries
    WHERE
      continent = 'South America'
  SQL
end

def name_and_population
  # Show the name and population for 'France', 'Germany', and 'Italy'
  execute(<<-SQL)
    SELECT
      name, population
    FROM
      countries
    WHERE
      name IN ('France', 'Germany', 'Italy')
  SQL
end

def united_we_stand
  # Show the countries that have a name that includes the word 'United'
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      name LIKE '%United%'
  SQL
end


# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def example_select
  execute(<<-SQL)
    SELECT
      yr,
      subject,
      winner
    FROM
      nobels
    WHERE
      yr = 1960
  SQL
end

def prizes_from_1950
  # Display Nobel prizes for 1950.
  execute(<<-SQL)
    SELECT
      *
    FROM
      nobels
    WHERE
      yr = 1950
  SQL
end

def literature_1962
  # Show who won the 1962 prize for Literature.
  execute(<<-SQL)
    SELECT
      winner
    FROM
      nobels
    WHERE
      yr = 1962 AND
      subject = 'Literature'
  SQL
end

def einstein_prize
  # Show the year and subject that won 'Albert Einstein' his prize.
  execute(<<-SQL)
    SELECT
      yr, subject
    FROM
      nobels
    WHERE
      winner = 'Albert Einstein'
  SQL
end

def millennial_peace_prizes
  # Give the name of the 'Peace' winners since the year 2000, including 2000.
  execute(<<-SQL)
    SELECT
      winner
    FROM
      nobels
    WHERE
      yr >= 2000 AND
      subject = 'Peace'
  SQL
end

def eighties_literature
  # Show all details (yr, subject, winner) of the Literature prize winners
  # for 1980 to 1989 inclusive.
  execute(<<-SQL)
    SELECT
      yr, subject, winner
    FROM
      nobels
    WHERE
      yr BETWEEN 1980 AND 1989 AND
      subject = 'Literature'
  SQL
end

def presidential_prizes
  # Show all details of the presidential winners: ('Theodore Roosevelt',
  # 'Woodrow Wilson', 'Jimmy Carter')
  execute(<<-SQL)
    SELECT
      *
    FROM
      nobels
    WHERE
      winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter')
  SQL
end

def nobel_johns
  # Show the winners with first name John
  execute(<<-SQL)
    SELECT
      winner
    FROM
      nobels
    WHERE
      winner LIKE 'John%'
  SQL
end



# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

# BONUS PROBLEM: requires sub-queries or joins. Attempt this after completing
# sections 04 and 07.

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT
      DISTINCT yr
    FROM
      nobels
    WHERE
      yr NOT IN (
        SELECT
          yr
        FROM
          nobels
        WHERE
          subject = 'Chemistry'
      ) AND
      subject = 'Physics'
  SQL
end




# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# A note on subqueries: we can refer to values in the outer SELECT within the
# inner SELECT. We can name the tables so that we can tell the difference
# between the inner and outer versions.

def example_select_with_subquery
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      population > (
        SELECT
          population
        FROM
          countries
        WHERE
          name='Romania'
        )
  SQL
end

def larger_than_russia
  # List each country name where the population is larger than 'Russia'.
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      population > (
        SELECT
          population
        FROM
          countries
        WHERE
          name = 'Russia'
      )
  SQL
end

def richer_than_england
  # Show the countries in Europe with a per capita GDP greater than
  # 'United Kingdom'.
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp/population > (
        SELECT
          gdp/population
        FROM
          countries
        WHERE
          name = 'United Kingdom'
      ) AND
        continent = 'Europe'
  SQL
end

def neighbors_of_certain_b_countries
  # List the name and continent of countries in the continents containing
  # 'Belize', 'Belgium'.
  execute(<<-SQL)
    SELECT
      name, continent
    FROM
      countries
    WHERE
      continent IN (
        SELECT
          continent
        FROM
          countries
        WHERE
          name In ('Belize', 'Belgium')
      )
  SQL
end

def population_constraint
  # Which country has a population that is more than Canada but less than
  # Poland? Show the name and the population.
  execute(<<-SQL)
    SELECT
      name, population
    FROM
      countries
    WHERE
      population BETWEEN (
        SELECT
          population
        FROM
          countries
        WHERE
          name = 'Canada'
      ) AND (
        SELECT
          population
        FROM
          countries
        WHERE
          name = 'Poland'
      ) AND
        name NOT IN ('Canada', 'Poland')

  SQL
end

def sparse_continents
  # Find every country that belongs to a continent where each country's
  # population is less than 25,000,000. Show name, continent and
  # population.
  # Hint: Sometimes rewording the problem can help you see the solution.
  execute(<<-SQL)
    SELECT
      name, continent, population
    FROM
      countries
    WHERE
      continent NOT IN (
        SELECT
          continent
        FROM
          countries
        WHERE
          population >= 25000000
      )
  SQL
end



# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          MAX(gdp)
        FROM
          countries
        WHERE
          continent = 'Europe'
      )

  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      continent, name, area
    FROM
      countries c1
    WHERE
      c1.area IN (
        SELECT
          MAX(c2.area)
        FROM
          countries c2
        WHERE
          c1.continent = c2.continent
        -- GROUP BY
          -- c2.continent
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      c1.name, c1.continent
    FROM
      countries c1
    WHERE
      c1.population > 3 * (
        SELECT
          MAX(c2.population)
        FROM
          countries c2
        WHERE
          c1.name != c2.name AND
          c1.continent = c2.continent
      )
  SQL
end


# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def example_sum
  execute(<<-SQL)
    SELECT
      SUM(population)
    FROM
      countries
  SQL
end

def continents
  # List all the continents - just once each.
  execute(<<-SQL)
    SELECT
      DISTINCT continent
    FROM
      countries
  SQL
end

def africa_gdp
  # Give the total GDP of Africa.
  execute(<<-SQL)
    SELECT
      SUM(gdp)
    FROM
      countries
    WHERE
      continent = 'Africa'
  SQL
end

def area_count
  # How many countries have an area of more than 1,000,000?
  execute(<<-SQL)
    SELECT
      COUNT(countries.name)
    FROM
      countries
    WHERE
      area > 1000000
  SQL
end

def group_population
  # What is the total population of ('France','Germany','Spain')?
  execute(<<-SQL)
    SELECT
      SUM(countries.population)
    FROM
      countries
    WHERE
      name IN ('France','Germany','Spain')
  SQL
end

def country_counts
  # For each continent show the continent and number of countries.
  execute(<<-SQL)
    SELECT
      continent, COUNT(countries.name)
    FROM
      countries
    GROUP BY
      continent
  SQL
end

def populous_country_counts
  # For each continent show the continent and number of countries with
  # populations of at least 10 million.
  execute(<<-SQL)
    SELECT
      continent, COUNT(countries.name)
    FROM
      countries
    WHERE
      population >= 10000000
    GROUP BY
      continent
  SQL
end

def populous_continents
  # List the continents that have a total population of at least 100 million.
  execute(<<-SQL)
    SELECT
      continent
    FROM
      countries
    GROUP BY
      continent
    HAVING
      SUM(population) >= 100000000
  SQL
end



# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_query
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    WHERE
      title = 'Doctor No'
  SQL
end

def films_from_sixty_two
  # List the films where the yr is 1962 [Show id, title]
  execute(<<-SQL)
    SELECT
      movies.id, movies.title
    FROM
      movies
    WHERE
      movies.yr = 1962
  SQL
end

def year_of_kane
  # Give year of 'Citizen Kane'.
  execute(<<-SQL)
    SELECT
      movies.yr
    FROM
      movies
    WHERE
      movies.title = 'Citizen Kane'
  SQL
end

def trek_films
  # List all of the Star Trek movies, include the id, title and yr (all of
  # these movies include the words Star Trek in the title). Order results by
  # year.
  execute(<<-SQL)
    SELECT
      movies.id, movies.title, movies.yr
    FROM
      movies
    WHERE
      movies.title LIKE '%Star Trek%'
    ORDER BY
      movies.yr
  SQL
end

def films_by_id
  # What are the titles of the films with id 1119, 1595, 1768?
  execute(<<-SQL)
    SELECT
      movies.title
    FROM
      movies
    WHERE
      movies.id IN (1119, 1595, 1768)
  SQL
end

def glenn_close_id
  # What id number does the actress 'Glenn Close' have?
  execute(<<-SQL)
    SELECT
      actors.id
    FROM
      actors
    WHERE
      actors.name = 'Glenn Close'

  SQL
end

def casablanca_id
  # What is the id of the film 'Casablanca'?
  execute(<<-SQL)
    SELECT
      movies.id
    FROM
      movies
    WHERE
      movies.title = 'Casablanca'
  SQL
end

def casablanca_cast
  # Obtain the cast list for 'Casablanca'. Use the id value that you obtained
  # in the previous question directly in your query (for example, id = 1).
  execute(<<-SQL)
    SELECT
      actors.name
    FROM
      actors
    JOIN castings
      ON castings.actor_id = actors.id
    JOIN movies
      ON movies.id = castings.movie_id
    WHERE
      movies.title = 'Casablanca'
  SQL
end

def alien_cast
  # Obtain the cast list for the film 'Alien'
  execute(<<-SQL)
    SELECT
      actors.name
    FROM
      actors
    JOIN castings
      ON castings.actor_id = actors.id
    JOIN movies
      ON movies.id = castings.movie_id
    WHERE
      movies.title = 'Alien'
  SQL
end




# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      movies.title
    FROM
      movies
    JOIN castings
      ON castings.movie_id = movies.id
    JOIN actors
      ON actors.id = castings.actor_id
    WHERE
      actors.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      movies.title
    FROM
      movies
    JOIN castings
      ON castings.movie_id = movies.id
    JOIN actors
      ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Harrison Ford' AND
      castings.ord != 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      movies.title, actors.name
    FROM
      movies
    JOIN castings
      ON castings.movie_id = movies.id
    JOIN actors
      ON actors.id = castings.actor_id
    WHERE
      movies.yr = 1962 AND
      castings.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      movies.yr, COUNT(movies.id)
    FROM
      movies
    JOIN castings
      ON castings.movie_id = movies.id
    JOIN actors
      ON actors.id = castings.actor_id
    WHERE
      actors.name = 'John Travolta'
    GROUP BY
      movies.yr
    HAVING
      COUNT(movies.id) >= 2
    ORDER BY
      COUNT(movies.id) DESC

  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      JA_movies.title, others.name
    FROM
      movies JA_movies
    JOIN castings JA_casting
      ON JA_casting.movie_id = JA_movies.id
    JOIN actors JA_actor
      ON JA_actor.id = JA_casting.actor_id
    JOIN castings other_casting
      ON other_casting.movie_id = JA_casting.movie_id
    JOIN actors others
      ON others.id = other_casting.actor_id
    WHERE
      JA_actor.name = 'Julie Andrews' AND
      other_casting.ord = 1

  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      actors.name
    FROM
      actors
    JOIN castings
      ON castings.actor_id = actors.id
    WHERE
      castings.ord = 1
    GROUP BY
      actors.name
    HAVING
      COUNT(*) >= 15
    ORDER BY
      actors.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      movies.title, COUNT( DISTINCT castings.actor_id) AS actor_count
    FROM
      movies
    JOIN castings
      ON castings.movie_id = movies.id
    WHERE
      movies.yr = 1978
    GROUP BY
      movies.title
    ORDER BY
      actor_count DESC, movies.title

  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      DISTINCT others.name
    FROM
      actors AG_actor
    JOIN castings AG_castings
      ON AG_castings.actor_id = AG_actor.id
    JOIN castings other_casting
      ON other_casting.movie_id = AG_castings.movie_id
    JOIN actors others
      ON others.id = other_casting.actor_id
    WHERE
      AG_actor.name = 'Art Garfunkel' AND
      others.name != 'Art Garfunkel'
  SQL
end





# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT
      albums.artist
    FROM
      albums
    JOIN tracks
      ON tracks.album = albums.asin
    WHERE
      tracks.song = 'Alison'

  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT
      albums.artist
    FROM
      albums
    JOIN tracks
      ON tracks.album = albums.asin
    WHERE
      tracks.song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT
      tracks.song
    FROM
      tracks
    JOIN albums
      ON albums.asin = tracks.album
    WHERE
      albums.title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
    SELECT
      albums.title, COUNT(tracks.*) AS num_tracks
    FROM
      albums
    JOIN tracks
      On albums.asin = tracks.album
    WHERE
      tracks.song LIKE '%Heart%'
    GROUP BY
      albums.title
    ORDER BY
      num_tracks DESC, albums.title
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT
      tracks.song
    FROM
      tracks
    JOIN albums
      ON albums.asin = tracks.album
    WHERE
      tracks.song = albums.title
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT
      albums.title
    FROM
      albums
    WHERE
      albums.title = albums.artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT
      tracks.song, COUNT( DISTINCT albums.asin )
    FROM
      tracks
    JOIN albums
      ON albums.asin = tracks.album
    GROUP BY
      tracks.song
    HAVING
      COUNT(DISTINCT albums.asin) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT
      albums.title, albums.price, COUNT(tracks.*)
    FROM
      albums
    JOIN tracks
      ON tracks.album = albums.asin
    GROUP BY
      albums.asin
    HAVING
      (albums.price/COUNT(tracks.*)) < 0.50
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums. Select both the album title and the track
  # count, and order by both track count and title (descending).
  execute(<<-SQL)
    SELECT
      albums.title, COUNT(tracks.*) AS num_tracks
    FROM
      albums
    JOIN tracks
      ON tracks.album = albums.asin
    GROUP BY
      albums.asin
    ORDER BY
      num_tracks DESC, albums.title DESC
    LIMIT 10
  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)
    SELECT
      albums.artist, COUNT( DISTINCT albums.asin ) AS num_albums
    FROM
      albums
    JOIN styles
      ON styles.album = albums.asin
    WHERE
      styles.style LIKE '%Rock%'
    GROUP BY
      albums.artist
    ORDER BY
      num_albums DESC
    LIMIT 1

  SQL
end




# == Schema Information
#
# Table name: teachers
#
#  id          :integer      not null, primary key
#  dept_id     :integer
#  name        :string
#  phone       :integer
#  mobile      :string
#
# Table name: depts
#
#  id          :integer      not null, primary key
#  name        :string       not null

require_relative './sqlzoo.rb'

def null_dept
  # List the teachers who have NULL for their department.
  execute(<<-SQL)
    SELECT
      teachers.name
    FROM
      teachers
    WHERE
      teachers.dept_id IS NULL
  SQL
end

def all_teachers_join
  # Use a type of JOIN that will list all teachers and their department,
  # even if the department in NULL/nil.
  execute(<<-SQL)
    SELECT
      teachers.name, depts.name
    FROM
      teachers
    LEFT JOIN depts
      ON teachers.dept_id = depts.id

  SQL
end

def all_depts_join
  # Use a different JOIN so that all departments are listed.
  # NB: you can avoid RIGHT OUTER JOIN (and just use LEFT) by swapping
  # the FROM and JOIN tables.
  execute(<<-SQL)
    SELECT
      teachers.name, depts.name
    FROM
      teachers
    RIGHT JOIN depts
      ON teachers.dept_id = depts.id

  SQL
end

def teachers_and_mobiles
  # Use COALESCE to print the mobile number. Use the number '07986
  # 444 2266' if no number is given. Show teacher name and mobile
  # #number or '07986 444 2266'
  execute(<<-SQL)
    SELECT
      teachers.name, COALESCE(teachers.mobile, '07986 444 2266')
    FROM
      teachers
  SQL
end

def teachers_and_depts
  # Use the COALESCE function and a LEFT JOIN to print the teacher name and
  # department name. Use the string 'None' where there is no
  # department.
  execute(<<-SQL)
    SELECT
      teachers.name ,COALESCE(depts.name, 'None')
    FROM
      teachers
    LEFT JOIN depts
      ON depts.id = teachers.dept_id
  SQL
end

def num_teachers_and_mobiles
  # Use COUNT to show the number of teachers and the number of
  # mobile phones.
  # NB: COUNT only counts non-NULL values.
  execute(<<-SQL)
    SELECT
      COUNT(teachers.name), COUNT(teachers.mobile)
    FROM
      teachers
  SQL
end

def dept_staff_counts
  # Use COUNT and GROUP BY dept.name to show each department and
  # the number of staff. Structure your JOIN to ensure that the
  # Engineering department is listed.
  execute(<<-SQL)
    SELECT
      depts.name, COUNT(teachers.id)
    FROM
      depts
    LEFT JOIN teachers
      ON depts.id = teachers.dept_id
    GROUP BY
      depts.name

  SQL
end

def teachers_and_divisions
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the the teacher is in dept 1 or 2 and 'Art' otherwise.
  execute(<<-SQL)
    SELECT
      teachers.name,
      CASE
        WHEN teachers.dept_id IN (1, 2) Then 'Sci'
        ELSE 'Art'
      END
    FROM
      teachers

  SQL
end

def teachers_and_divisions_two
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the the teacher is in dept 1 or 2, 'Art' if the dept is 3, and
  # 'None' otherwise.
  execute(<<-SQL)
    SELECT
      teachers.name,
      CASE
        WHEN teachers.dept_id IN (1, 2) THEN 'Sci'
        WHEN teachers.dept_id = 3 THEN 'Art'
        ELSE 'None'
      END
    FROM
      teachers
  SQL
end



# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT
      COUNT(stops.id)
    FROM
      stops

    -- SELECT
    --   COUNT(DISTINCT(routes.stop_id))
    -- FROM
    --   routes;
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT
      stops.id
    FROM
      stops
    WHERE
      stops.name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      stops.id, stops.name
    FROM
      stops
    JOIN routes
      ON routes.stop_id = stops.id
    WHERE
      routes.num = '4' AND routes.company = 'LRT'
  SQL
  # ["19", "Bingham"],
  # ["177", "Northfield"],
  # ["149", "London Road"],
  # ["194", "Princes Street"],
  # ["115", "Haymarket"],
  # ["53", "Craiglockhart"],
  # ["179", "Oxgangs"],
  # ["85", "Fairmilehead"],
  # ["117", "Hillend"]

end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)

    SELECT
      routes.company, routes.num, COUNT(*) AS num_routes
    FROM
      routes
    WHERE
      routes.stop_id = 149 OR routes.stop_id = 53
    GROUP BY
      routes.company, routes.num
    HAVING
      COUNT(*) = 2
  SQL

  # ["LRT", "45", "2"],
  # ["LRT", "4", "2"]
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      a.stop_id,
      b.stop_id
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    WHERE
      a.stop_id = 53 AND b.stop_id = 149
  SQL

  # ["LRT", "4", "53", "149"],
  # ["LRT", "45", "53", "149"]
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # JOIN
  #   stops stopa ON (a.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      stopa.name,
      stopb.name
    FROM
      routes a
    JOIN routes b
      ON (a.company = b.company AND a.num = b.num)
    JOIN stops stopa
      ON (stopa.id = a.stop_id)
    JOIN stops stopb
      ON (stopb.id = b.stop_id)
    WHERE
      stopa.name = 'Craiglockhart' AND stopb.name = 'London Road'
  SQL

  # ["LRT", "4", "Craiglockhart", "London Road"],
  # ["LRT", "45", "Craiglockhart", "London Road"]
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT
      DISTINCT a.company, a.num
    FROM
      routes a
    JOIN routes b
      ON (a.company = b.company AND a.num = b.num)
    JOIN stops stopa
      ON (stopa.id = a.stop_id)
    JOIN stops stopb
      ON (stopb.id = b.stop_id)
    WHERE
      stopa.name = 'Haymarket' AND stopb.name = 'Leith'

    -- SELECT DISTINCT
    --  start_routes.company,
    --  start_routes.num
    -- FROM
    --   routes AS start_routes
    -- JOIN
    --   routes AS end_routes ON start_routes.company = end_routes.company
    --      AND start_routes.num = end_routes.num
    -- WHERE
    --   start_routes.stop_id = 115 AND end_routes.stop_id = 137
  SQL

  # ["LRT", "12"],
  # ["LRT", "2"],
  # ["LRT", "22"],
  # ["LRT", "25"],
  # ["LRT", "2A"],
  # ["SMT", "C5"]
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT
      start_route.company, start_route.num
    FROM
      routes start_route
    JOIN routes end_route
      ON start_route.company = end_route.company AND
        start_route.num = end_route.num
    JOIN stops stopa
      ON stopa.id = start_route.stop_id
    JOIN stops stopb
      ON stopb.id = end_route.stop_id
    WHERE
      stopa.name = 'Craiglockhart' AND
      stopb.name = 'Tollcross'

  SQL

  # ["LRT", "10"],
  # ["LRT", "27"],
  # ["LRT", "45"],
  # ["LRT", "47"]
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT
      stopb.name, start_route.company, start_route.num
    FROM
      routes start_route
    JOIN routes end_route
      ON start_route.company = end_route.company AND
        start_route.num = end_route.num
    JOIN stops stopa
      ON stopa.id = start_route.stop_id
    JOIN stops stopb
      ON stopb.id = end_route.stop_id
    WHERE
      stopa.name = 'Craiglockhart'
  SQL

  # ["Bingham", "LRT", "4"],
  # ["Northfield", "LRT", "4"],
  # ["London Road", "LRT", "4"],
  # ["Princes Street", "LRT", "4"],
  # ["Haymarket", "LRT", "4"],
  # ["Craiglockhart", "LRT", "4"],
  # ["Oxgangs", "LRT", "4"],
  # ["Fairmilehead", "LRT", "4"],
  # ["Hillend", "LRT", "4"],
  # ...
end

```
