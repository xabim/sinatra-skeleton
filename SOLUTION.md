# WORLD TEMPERATURE

For this ruby application with sinatra I've performed several steps.

## Docker containers

First of all to test and develop in local I've created a `Dockerfile` to build the artifact of the application

Also I've created two files for Docker compose `docker-compose.yml` and `docker-compose.test.yml`. The first one is for production and the second one is to run tests in local.

The difference is the database used in the application, even in this example **there is no database in use** I've left the options to show how a test environment where `sqlite3` is used and a production environent where `postgresql` is used

## Darksky library

I've created a library in order to be used with sinatra app and get the forecast with the api from [DarkSky](https://darksky.net/) with a coordinates given.

For TDD I've used rspec and the tests can be run with

```bash
docker build -t world_temperature --target test .
docker run world_temperature bundler exec rspec

```

I've used [WebMock](https://rubygems.org/gems/webmock) to stubb HTTP requests to the api and fixtures with json responses from the API

## Secrets

Secrets as API keys are loaded from environment variables to the same artifact in several environments to store the confiration in the environment [III. Config](config)

For this exercise [dotenv](https://rubygems.org/gems/dotenv) is in use, but depending on the strategy to deploy the application a `.env` file must be created in the home of the application.

Also, if deployed via docker environment variables can be passed as seen in `docker-compose.test.yml` with env file `test.env`
