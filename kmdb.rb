# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!
Movie.destroy_all
Studio.destroy_all
Actor.destroy_all
Character.destroy_all

# Generate models and tables, according to the domain model.
# TODO!

rails generate model Movie title:string year:integer rating:string studio:references
rails generate model Studio name:string
rails generate model Actor name:string
rails generate model Character name:string actor:references movie:references

# rails db:migrate

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

warner_bros = Studio.create(name: "Warner Bros.")

batman_begins = Movie.create(title: "Batman Begins", year: 2005, rating: "PG-13", studio: warner_bros)
dark_knight = Movie.create(title: "The Dark Knight", year: 2008, rating: "PG-13", studio: warner_bros)
dark_knight_rises = Movie.create(title: "The Dark Knight Rises", year: 2012, rating: "PG-13", studio: warner_bros)


christian_bale = Actor.create(name: "Christian Bale")
michael_caine = Actor.create(name: "Michael Caine")
liam_neeson = Actor.create(name: "Liam Neeson")
katie_holmes = Actor.create(name: "Katie Holmes")
gary_oldman = Actor.create(name: "Gary Oldman")
heath_ledger = Actor.create(name: "Heath Ledger")
aaron_eckhart = Actor.create(name: "Aaron Eckhart")
maggie_gyllenhaal = Actor.create(name: "Maggie Gyllenhaal")
tom_hardy = Actor.create(name: "Tom Hardy")
joseph_gordon_levitt = Actor.create(name: "Joseph Gordon-Levitt")
anne_hathaway = Actor.create(name: "Anne Hathaway")

batman_begins.actors << christian_bale << michael_caine << liam_neeson << katie_holmes << gary_oldman
dark_knight.actors << christian_bale << heath_ledger << aaron_eckhart << michael_caine << maggie_gyllenhaal
dark_knight_rises.actors << christian_bale << gary_oldman << tom_hardy << joseph_gordon_levitt << anne_hathaway

bruce_wayne_bb = Character.create(name: "Bruce Wayne", actor: christian_bale, movie: batman_begins)
alfred_bb = Character.create(name: "Alfred", actor: michael_caine, movie: batman_begins)
ras_al_ghul_bb = Character.create(name: "Ra's Al Ghul", actor: liam_neeson, movie: batman_begins)
rachel_dawes_bb = Character.create(name: "Rachel Dawes", actor: katie_holmes, movie: batman_begins)
commissioner_gordon_bb = Character.create(name: "Commissioner Gordon", actor: gary_oldman, movie: batman_begins)

bruce_wayne_dk = Character.create(name: "Bruce Wayne", actor: christian_bale, movie: dark_knight)
alfred_dk = Character.create(name: "Alfred", actor: michael_caine, movie: dark_knight)
joker_dk = Character.create(name: "Joker", actor: heath_ledger, movie: dark_knight)
harvey_dent_dk = Character.create(name: "Harvey Dent", actor: aaron_eckhart, movie: dark_knight)
rachel_dawes_dk = Character.create(name: "Rachel Dawes", actor: maggie_gyllenhaal, movie: dark_knight)

bruce_wayne_dkr = Character.create(name: "Bruce Wayne", actor: christian_bale, movie: dark_knight_rises)
commissioner_gordon_dkr = Character.create(name: "Commissioner Gordon", actor: gary_oldman, movie: dark_knight_rises)
bane_dkr = Character.create(name: "Bane", actor: tom_hardy, movie: dark_knight_rises)
john_blake_dkr = Character.create(name: "John Blake", actor: joseph_gordon_levitt, movie: dark_knight_rises)
selina_kyle_dkr = Character.create(name: "Selina Kyle", actor: anne_hathaway, movie: dark_knight_rises)


# Prints a header for the movies output


# Query the movies data and loop through the results to display the movies output.
# TODO!

#Query
movies = Movie.all
#Loop
puts "Movies"
puts "======"
puts ""
movies.each do |movie|
  puts "#{movie.title.ljust(23)} #{movie.year.to_s.ljust(7)} #{movie.rating.ljust(6)} #{movie.studio.name}"
end

# Prints a header for the cast output


# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

# Group characters 
characters_by_movie = Character.includes(:actor, :movie).group_by(&:movie_id)

# Loop through 
puts ""
puts "Top Cast"
puts "========"
puts ""
characters_by_movie.each do |movie_id, characters|
  movie = Movie.find(movie_id)
  characters.each do |character|
    puts "#{movie.title.ljust(23)} #{character.actor.name.ljust(20)} #{character.name}"
  end
end
