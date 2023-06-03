# Rails Engine Lite
<img width="300" alt="Screen Shot 2022-02-11 at 9 46 05 AM" src="https://user-images.githubusercontent.com/90228086/153612657-947783f9-b055-4e53-a3bc-d7afccd75d13.png">

![languages](https://img.shields.io/github/languages/top/WadeNaughton/rails-engine-lite?color=red)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov)

## Project Description 
You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

## Learning Goals 

Below are technical goals that you should be applying in this project.
The priority of these goals are demonstrated using a star grading system.
By the end of this project:
- Student should have a functional understanding of the concept ⭐ ⭐ ⭐
- Student should have a familiar understanding, but may still have questions ⭐ ⭐
- Student should know of the concept, but need further resources to implement ⭐

Goals

- Expose an API ⭐ ⭐ ⭐
- Use serializers to format JSON responses ⭐ ⭐ ⭐
- Test API exposure ⭐ ⭐ ⭐
- Use SQL and AR to gather data ⭐ ⭐


## Gems Utilized

- gem 'jsonapi-serializer'
- gem 'shoulda-matchers'
- gem 'rspec-rails'
- gem 'simplecov'
- gem 'rspec-rails'
- gem 'factory_bot_rails'
- gem 'faker'


## **Setup**

- Git clone this repository 

```
git clone git@github.com:WadeNaughton/rails-engine-lite.git
```

- CD into the newly cloned repo

```
CD rails-engine-lite
```

- Bundle the gems 

```
bundle install
```

- Migrate the database

```
rake db:{drop,create,migrate,seed}
```

- Run the command below, then make sure the database exists

```
rails db:schema:dump
```

- Make sure the database exists through the following steps:

 run ``` rails c ```,
 Enter ``` Item.first```,
 The first Item should have the name ``` "Item Nemo Facere" ```
 
 - Run Localhost 

```rails s```


## **Contributor**

 <td align="center"><a href="https://github.com/wadenaughton"><img src="https://avatars.githubusercontent.com/u/90228086?v=4" width="100px;" alt=""/><br /><sub><b>Wade (he/him)</b></sub></a><br /><a href="https://github.com/WadeNaughton/rails-engine-lite/commits?author=wadenaughton" title="Code">💻</a> <a href="#ideas-wadenaughton" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/WadeNaughton/rails-engine-lite/commits?author=wadenaughton" title="Tests">⚠️</a> <a href="https://github.com/WadeNaughton/rails-engine-lite/pulls?q=is%3Apr+reviewed-by%3Ajwadenaughton" title="Reviewed Pull Requests">👀</a></td>
