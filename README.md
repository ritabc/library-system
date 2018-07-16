# Library System

#### Epicodus: Ruby Course: Tuesday, July 11th, 2018

#### Craig Wann, Rita Bennett-Chew

## Description

## Setup/Contribution Requirements

1. Clone the repo
1. Make a new branch
1. Commit and push your changes
1. Create a PR

## Technologies Used

* Ruby 2.4.1

## Database Schema

<img width="915" alt="screen shot 2018-07-11 at 2 40 53 pm" src="https://user-images.githubusercontent.com/11031915/42604369-3e1559bc-8527-11e8-9283-ecef5ea749a4.png">

## User Stories

* As a librarian, I want to create, read, update, delete, and list books in the catalog, so that we can keep track of our inventory.
* As a librarian, I want to search for a book by author or title, so that I can find a book easily when the book inventory at the library grows large.
* As a patron, I want to check a book out, so that I can take it home with me.
* As a patron, I want a patron account page that gives me options for:
  - showing me all the books that I can currently check out.
  - showing a history of all the books I checked out (so that I can look up the name of that awesome sci-fi novel I read three years ago. (Hint: make a checkouts table that is a join table between patrons and books.))
  - knowing when a book I checked out is due, so that I know when to return it.
* As a librarian, I want to see a list of overdue books, so that I can call up the patron who checked them out and tell them to bring them back - OR ELSE!
* As a librarian, I want to enter multiple authors for a book, so that I can include accurate information in my catalog. (Hint: make an authors table and a books table with a many-to-many relationship.)

## License

This software is licensed under the MIT license.

Copyright (c)2018 **Craig Wann, Rita Bennett-Chew**
