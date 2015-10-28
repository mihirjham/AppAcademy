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
        a.name
      FROM
        countries a
      JOIN
        countries b ON a.continent != b.continent
      WHERE
        b.continent = 'Europe'
      GROUP BY
        a.name
      HAVING
        a.gdp > MAX(b.gdp)
      SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      continent, name, area
    FROM
      countries
    WHERE
      area IN (
          SELECT
            MAX(area)
          FROM
            countries
          GROUP BY
            continent
          )

  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      a.name, a.continent
    FROM
      countries a
    WHERE
      population > 3*(
          SELECT
            MAX(population)
          FROM
            countries b
          WHERE
            a.name != b.name AND a.continent = b.continent
      )
  SQL
end
