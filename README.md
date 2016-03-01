## README

### Steps to create and initialize the database

Make sure you have MySql installed. There is a database diagram `diagram.mwb` which can be opened with MySql workbench that can generate a create script though this is not necessary since you will run rails migrations :)

Run `bundle install` so you get the MySql gem installed before running the migrations. On some OS'es like linux you may need to install the development files for MySql, refer to your package manager documentation.

Once the above command has successfully executed create the database:

`rake db:create db:migrate`

Now put some test data on it:

`rake db:seed`

### Steps to prepare the source code.

This application expects a ruby version of 2.2.3. You can use [rbenv](https://github.com/rbenv/rbenv) to have a specific version of ruby installed.

### Any assumptions made and missing requirements that are not covered in the requirements

 * Misread the original requirements and was halfway there so there is no option to _"rent"_
 * Most of the endpoints should return json if requested (did not split the app in api and app, no time for that really)
 * Missed adding the proper unit tests (again, had not enough time)

### Any feedback you may wish to give about improving the assignment

 * Lots of improvements can be made of course:
  * Security
  * Handle API tokens
  * Unit Tests
  * Design
  * Refactor search / pagination and use scopes insteads
  * Use concerns for certain repetitive tasks in controllers
  * Add forgot password functionality
  * Add mailers to activate accounts