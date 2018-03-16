# TechStudio

Heroku link: https://tech-studio.herokuapp.com/

### What is TechStudio?

TechStudio was created for a Software Engineering course at Mills College in 2018. We wanted to create a place to foster interdisciplinary tech projects.

### TechStudio Members
* Deana Bui https://github.com/deanabui
* Natasha Culbreth https://github.com/LesForcesDuMal
* Gloriane Tran https://github.com/glorianetran
* Regina Wang https://github.com/reginayiwang

### Viewing our Repo
1. Clone Repository into your environment.
2. In the TechStudio directory run `bundle install`
3. Populate the database:
  * In the console, run ```rails db:migrate```
  * Then ```rails db:seed```
4. To view database data
  * Type ```rails console``` in the console.
  * Then enter CRUD operations such as ```Project.all```
  * Our current tables are Project, Tagging and Tag.

### Project Details
* Rails Version: 5.1.5
* Ruby Version: 2.4.0
* BootStrap: Twitter Bootstrap, BootStrap sass
* Third-Party User Authentication: Google
