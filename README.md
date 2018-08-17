# Ruby on Rails Project - Assess

Assess is an easy solution for group peer evaluations, that makes creating classes, groups, and evaluations simple. Instructors can freely create or remove classes, and form groups within those classes. Students can be added by the e-mails they signed up with. Instructors can easily add & remove students from classes and groups.

Peer Evaluations are simple to create and will automatically generate a customized evaluation for each member of a group. Assess speeds up the process of submitting evaluations by going digital, and saves time & paper. Switch to Assess today to see the benefits of our streamlined process!

### Group - The F3D5

* Michael Lynch
* Pranay Methuku
* Sayeef Moyen

### Roles

* Overall Project Manager: Pranay Methuku
* Coding Manager: Michael Lynch
* Testing Manager: Sayeef Moyen
* Documentation: Pranay Methuku

### Code Structure & Organization

Since the project is built on Rails, it follows a Model-View-Controller (MVC) pattern. You can find the ER diagram/Schema and the State diagram in the presentation folder. The project uses `devise`, `bootstrap`, `figaro`, and some `jquery` as some of the extra technologies and frameworks.

The controllers for groups and sections are organized in the `instructors/sessions` folder. This decision was taken considering the fact that most functionality for group and section creation/deletion and adding/removing students would be in the hands of instructors.

### Instructions to Grader

To run our web application, clone the repo and navigate into the `assess` folder. Once in the `assess` folder,

1. run `bundle install`
2. run `rails db:migrate`
3. run `rails server`
4. open Assess in your browser at `localhost:3000`.

### Contributions

* Pranay Methuku
  * Controller code for Groups, Sections, and Evaluations.
  * Set up scoped student and instructor routes for all actions in the controller code mentioned above.
  * Action Mailer, Confirmable, and Recoverable Devise setup
  * Database Modeling & Schema Design
  * Dashboard Section/Group partials HTML, setting up links for managing Sections/Groups/Evaluations
  * Helper functions for getting parameterized routes, and before actions for checking if instructor/student is logged in
  * Documentation of all functions written by the group (REST actions for groups, sections, and evaluations, extra helper functions for getting routes, and before actions)

* Sayeef Moyen
  * Basic Devise Setup
  * Controller code for Student & Instructor
  * Database Modeling & Schema Design
  * Site-wide Bootstrap & Additional Styling
  * HTML Formatting & Structure
  * View Reformatting & Restructuring

* Michael Lynch
  * Evaluation Scaffold
  * State Diagram
  * Minor Debugging
  * Start of Profile page and comment section

### Testing

Testing was done on a system level by every group member on their local environments. The following specific system tests were conducted. Unless otherwise noted, the tests were successful:

#### From Landing Page

* Click on the `Assess` navigation link - expect to stay on the same page
* Click on the `Home` navigation link - expect to stay on the same page
* Click on the `Instructor` button in the jumbotron - expect to be taken to the instructor sign up page
* Click on the `Student` button in the jumbotron - expect to be taken to the student sign up page
* Click on the `Sign Up` navigation link - expect to see dropdown for Student & Instructor
* Click on the `Log In` navigation link - expect to see dropdown for Student & Instructor
* Click on the `As Student` link from the Sign Up dropdown menu - expect to be taken to the student sign up page
* Click on the `As Instructor` link from the Sign Up dropdown menu - expect to be taken to the instructor sign up page
* Click on the `As Student` link from the Log In dropdown menu - expect to be taken to the student log in page
* Click on the `As Instructor` link from the Log In dropdown menu - expect to be taken to the instructor log in page

#### From Student Log In Page

* Attempt to log-in with a valid student account e-mail & password - expect to be taken to the student dashboard
* Attempt to log-in with a valid instructor account e-mail & password - expect to be shown an alert
* Attempt to log-in with an invalid e-mail or password - expect to be shown an alert
* Click on the `Sign Up` link - expect to be taken to the student sign up page
* Click on the `Forgot Your Password?` link - expect to be taken to the Password Recovery by email page
* Click on the `Didn't Receive Your Confirmation Instructions?` link - expect to be taken to the Resend confirmation instructions page
* Click on the `Didn't Receive Your Unlock Instructions?` link - expect to be taken to the Resend unlock instructions page

#### From Student Dashboard

* Based on whether an instructor has added them to groups or not, expect to see their appropriate classes & groups. If in multiple groups in one class, should only see the class once, with all of the groups nested.
* If you just signed in, expect to see an alert notifying this at the top of the page
* Click on the `edit` button - expect to be taken to the account edit page
* Click on a group's name - expect to be taken to that group's page listing all students' names & emails
* Click on `Fill Evaluation` - expect to be taken to an empty evaluation form for that specific group
  * `Turn in` an Evaluation with some empty fields - expect to be shown an alert explaining what was empty
  * `Turn in` an Evaluation with everything filled in (except the optional `Other` section) - expect to be shown alert notifying success
* Click on `Show Evaluations` - expect to be shown all evaluations by current student for that specific group

#### From Instructor Log In Page

* Attempt to log-in with a valid instructor account e-mail & password - expect to be taken to the instructor dashboard
* Attempt to log-in with a valid student account e-mail & password - expect to be shown an alert
* Attempt to log-in with an invalid e-mail or password - expect to be shown an alert
* Click on the `Sign Up` link - expect to be taken to the instructor sign up page
* Click on the `Forgot Your Password?` link - expect to be taken to the Password Recovery by email page
* Click on the `Didn't Receive Your Confirmation Instructions?` link - expect to be taken to the Resend confirmation instructions page
* Click on the `Didn't Receive Your Unlock Instructions?` link - expect to be taken to the Resend unlock instructions page

#### From Instructor Dashboard

* If you just signed in, expect to see an alert notifying this at the top of the page
* Click on the `edit` button - expect to be taken to the account edit page
* Click on `Create Class` button - expect to be taken to a form page for a new class
* Click on `Manage Classes` button - expect to be taken to a page shwoing all classes created by an instructor in a tabular format
  * Click on `Delete Class` button - expect to be shown a window alert, which upon confirmation would delete a class and redirect to previous page
  * Click on `Create new Class` button - expect to be taken to a form page for a new class
* Click on `Create Group` button - expect to be taken to a form page for a new group
* Click on `Manage Groups` button - expect to be taken to a page shwoing all groups created by an instructor in a tabular format
  * Click on `Show Students` button - expect to be taken to that group's page listing all students' names & emails
  * Click on `Delete Group` button - expect to be shown a window alert, which upon confirmation would delete a group and redirect to previous page
  * Click on `Create new Group` button - expect to be taken to a form page for a new group
* Click on a group's name - expect to be taken to that group's page listing all students' names & emails
  * Click on `Add students` - expect to be shown a form for adding new students, redirect back to dashboard explaining who was added and who was not.
  * Click on `Remove student` - expect to be shown a window alert, which upon confirmation would remove student from group (but not their account).
* Click on `Show Evaluations` - expect to be shown all evaluations in that specific group

#### Site-wide

* Attempting to access any pages for a specific instructor by url (dashboard, manage groups, manage classes) without being logged in as that instructor - expect to be taken to the home page with a notice
* Attempting to access any pages for a specific student by url (dashboard, manage groups, manage classes) without being logged in as that student - expect to be taken to the home page with a notice
* Attempting to access any pages by url that are not actual urls in the site - expect to be taken to the home page without notice
