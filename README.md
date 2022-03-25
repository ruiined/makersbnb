# MakersBnB
## Overview
This is the project of a web application, using Sinatra and PostreSQL.

## Contributors
  <a href="https://github.com/ruiined/makersbnb/graphs/contributors">
  <img src="https://github.com/ruiined/makersbnb/blob/main/screenshots/feb22_team1.png" />
  </a>

## Usage

### Installation And Set-Up Instructions

Navigate to the directory you wish for the project to be in...
```
$ cd yourdirectory
```

Then you can clone this repository by running the following...
```
$ git clone https://github.com/ruiined/makersbnb.git
```

Change directory to the project...
```
$ cd makersbnb
```

If you don't have postgresql installed, run the following (if you do, skip this)...
```
$ brew install postgresql
```

Make sure postgresql is running in the background (if it's already running, skip this)...
```
$ brew services start postgresql
```

Install the gems by running the following...
```
$ bundle install
```

Start postgresql...
```
$ psql postgres
postgres=#
```

Create the database...
```
postgres=# CREATE DATABASE makersbnb;
```

Create the test database...
```
postgres=# CREATE DATABASE makersbnb_test;
```

Make sure you're connected to the database...
```
postgres=# \c makersbnb;
```

Create the users table...
```
postgres=# CREATE TABLE users (id SERIAL PRIMARY KEY, username VARCHAR(60), password VARCHAR(60), email VARCHAR(60));
```

Create the properties table...
```
postgres=# CREATE TABLE properties (id SERIAL PRIMARY KEY, host_id INTEGER REFERENCES users (id), title VARCHAR(80), description VARCHAR(500), address VARCHAR(80), price FLOAT(8), image_url VARCHAR(80));
```

Create the bookings table...
```
postgres=# CREATE TABLE bookings (id SERIAL PRIMARY KEY, property_id INT4, user_id INT4);
```

### How To Interact With The App

To be added later...

## Workflow Stages

### Beginning

The first thing we did was to establish a comfortable dynamic between all members of the team. We spent a fair amount of time establishing expectations, ambitions and concerns for our week working together.

### User Stories
We continued by converting the headline specifications into user stories, as well as thinking of the more basic functionality (relative to the headline specifications) that needed to be in our project. They were also converted into user stories.

  ```
  As a user,
  So that I can look for holiday apartments,
  I want to be able to view a list of spaces.
  ```
  ```
  As a user,
  So that I can find a perfect holiday apartment,
  I want to be able to view every space in detail with a title, description, image and price.
  ```
  ```
  As a user,
  So that I can go on a holiday,
  I want to be able to request a booking for an apartment I want.
  ```
  ```
  As a user,
  So that my details are saved,
  I want to be able to sign up.
  ```
  ```
  As a user,
  So that only I can access my account,
  I want to be able to sign in or sign out.
  ```
  ```
  As a host,
  So that I can rent my property out,
  I want to be able to accept a booking request.
  ```
  ```
  As a host,
  So that my property doesn't get double booked,
  I want my property to not be bookable after I accept a booking request.
  ```
  
### Diagram

The next step was to domain model the project.
  ![Project Diagram](https://github.com/ruiined/makersbnb/blob/main/screenshots/makersbnb_diagram.jpg)

### Starting To Code
Once we exited the planning stage we split the project into small tasks and worked in pairs with one member being left alone at any one time. To compensate for the less than ideal nature of somebody being a solo artist, we switched stations (tasks and pairs) quite often. This benefitted all of us by giving us variety in the material we were working on and learning/consolidating, as well as giving us a chance to work with all other members of the team and experience the subtle differences in their work preferences. We would reconvene frequently and briefly to assess our progress and allocate new tasks based on prerequisites being met or issues arising from prior changes.

### Minimum Viable Product
Our MVP consisted of the first two user stories, namely being able to see a list of spaces and being able to view any one space in more detail.

### Next Steps
We will add the functionality to book a space, which will make use of the User class. The functionality for a user to sign up (and requirement when attempting to book a space) will also be added, along with signing in and out.

## Retrospective
To be completed after the project.
