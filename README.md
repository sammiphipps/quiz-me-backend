# QuizMe Backend

This is the backend API for the QuizMe project. The frontend is an application that allows users to create, view and run through the different kinds of study methods. As such, the backend keeps track of the different categories, questions and answers.  

## Routes Available: 
Below is a list of the different routes that are available. Due to the way that the frontend is setup, some of the routes may only allow a specific HTTP Verb.

* Categories
* Questions
* Correct Answers
* Incorrect Answers
* Study Cards
* Quizzes
* Tests

## Instruction 
1. Download the repo by forking it and then using git clone in the folder you wish to put it
2. Install all of the dependencies that are required by bundle installing
3. Ensure that you are using Ruby 2.6.6 version by entering rvm use 2.6.6
4. Create the database on your computer by running rails db:create
5. Migrate all of the tables by using rails db:migrate
6. Run rails db:seed if you would just like to view and use the current database information
7. Run the server by typing in rails s
8. Follow the instructions for downloading and running the frontend section at https://github.com/sammiphipps/quiz-me-frontend. 
9. Enjoy
