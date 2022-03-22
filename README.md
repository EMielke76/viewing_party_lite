# Viewing Party

## Table of contents
- [Overview](#overview)
- [Setup](#setup)
- [API Setup](#api-setup)
- [Technologies](#technologies)
- [Contributors](#contributors)

## <ins>Overview</ins>

A Full-Stack repository built to consume endpoints from [The Movie Database](https://www.themoviedb.org/) API that would allow a user to search for movies nd then create a "Viewing Party" where they may invite other users to viwe the movie with them. This reposity was constructed following RESTful design patterns adhering to Service Oriented Architecture best practices. 

This project is based off Turing's viewing_party_lite project. More details can be found [here](https://backend.turing.edu/module3/projects/viewing_party_lite/index)

### <ins>Setup</ins>
1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate}`
4. Run `bundle exec rspec` to run the full test suite.

### <ins>API Setup</ins>
1. Sign up for and API key by registering with [The Movie Database](https://www.themoviedb.org/) and following the directions provided therein.
2. From the command line, run the following: `bundle exec figaro install`
3. Navigate to /config/application.yml
4. Paste the following code and replace 'YOUR-API-KEY' with the respective credentials:
  ```
  movie_api_key: YOUR-API-KEY
  ```

### <ins>Technologies</ins>

#### Versions
- Ruby 2.7.2
- Rails 5.2.5

#### Development tools employed 
- [Figaro](https://github.com/laserlemon/figaro)
- [Faraday](https://lostisland.github.io/faraday/)
- [PostgreSQL](https://www.postgresql.org/)
- [Postman](https://www.postman.com/)
- [Ruby on Rails](https://rubyonrails.org/)


#### Languages
- Ruby

#### Testing tools
- [Pry](http://pry.github.io/)
- [RSPEC](https://rspec.info/)
- [Capybara](https://github.com/teamcapybara/capybara)
- [Shoulda Matchers](https://matchers.shoulda.io/)
- [Simplecov](https://github.com/simplecov-ruby/simplecov)
- [VCR](https://relishapp.com/vcr/vcr/docs)
- [Webmock](https://github.com/bblimke/webmock)

#### Development Principles
- OOP
- TDD
- MVC
- REST

### <ins>Contributors</ins>
- [Eric Mielke](https://github.com/EMielke76)
