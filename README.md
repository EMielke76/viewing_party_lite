# Viewing Party
![languages](https://img.shields.io/github/languages/top/emielke76/viewing_party_lite?color=red)
![PRs](https://img.shields.io/github/issues-pr-closed/emielke76/viewing_party_lite)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Table of contents
- [Overview](#overview)
- [DB Schema](#schema)
- [Setup](#setup)
- [API Setup](#api-setup)
- [Technologies](#technologies)
- [Contributors](#contributors)

## <ins>Overview</ins>

A Full-Stack repository built to consume endpoints from [The Movie Database](https://www.themoviedb.org/) API that would allow a user to search for movies nd then create a "Viewing Party" where they may invite other users to viwe the movie with them. User's were persisted to the database using Bcrypt authentication. This reposity was constructed following RESTful design patterns adhering to Service Oriented Architecture best practices. 

This project is based off Turing's viewing_party_lite project. More details can be found [here](https://backend.turing.edu/module3/projects/viewing_party_lite/index)

Originally built in collaboration with fellow student, refactored to utilitze `sessions` and `cookies` as a solo.

## <ins>Schema</ins>
![image](https://user-images.githubusercontent.com/81482407/159398475-f218aab6-5b7f-4a72-94c9-37b6eae8bf29.png)

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
