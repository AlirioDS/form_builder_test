# Rails TEST
## Installation
1. Docker and docker-compose for run postgres DB
2. ```bash
    docker-compose up -d
   ```
3. ```bash
    bundle exec rails db:create db:migrate
   ```
4. ```bash
    bundle install
   ```
5. ```bash
    bundle exec rails s
   ```
6. Using script to show form builder for all
   ```bash
    ruby bin/questionnaire personal_information about_the_situation
   ```
7. Using script to show form builder for separate
   ```bash
    ruby bin/questionnaire personal_information
    ||
    ruby bin/questionnaire about_the_situation
   ```
8. Tests
   ```bash
    bundle exec rspec
   ```
