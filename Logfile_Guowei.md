# Week 1 (27 Jan-3 Feb):
> Introduced to the company, met with the client, and held a discussion about the application (functionalities and requirements) after that decided with teammates the roles and the plan to follow as well as the things needed to be done until the next meeting. Created a wireframe for the application.

# Week 2 (3 Feb-10 Feb):
> Held discussions around the wireframe, and was assigned to implement the application's home page as described in the wireframe. Improved the wireframe and successfully developed the home page with no functionality.

# Week 3 (10 Feb-17 Feb):
> In the meeting, we discussed about the application, specifically on how the data will be stored and retrieved using firebase. But for this sprint, we decided that we will implement all the pages according to the wireframe v1.1, that's simply just views with no functionalities and I was assigned to implement admin, create, and modify pages. Successfully implemented admin and create a view with simple UI and added navigation around Home -> Admin -> Create.

# Week 4 (17 Feb-24 Feb):
> Presented the application prototype to the client and was able to meet his expectation, furthermore, the next step is to implement simple interactions with the backend which my role is to develop data storage that allows the creation of competition names stored in the database and present them in the home and create pages. Implemented a backend that allows the admin to insert the name of the competition into the firebase real-time database with some validation such as the name cannot be empty while inserting, in addition, the appropriate popup message will show up if the action was successful or failed.

# Week 5 (24 Feb-3 Mar):
> No meeting for this week did an investigation and readings on how to implement an adding question functionality and how the data should be structured in the firebase database, and which way it's easier to retrieve it afterwards. With top priority, it must be functional.

# Week 6 (3 Mar-10 Mar):
> Further developed the app requirements, improved the backend database structure and fixed some issues. Initialized the functionality to add questions but needs improvements.

# Week 7 (10 Mar-17 Mar):
> As the previous implementation of question functionality did not work as intended especially had issues and difficulties on how to handle the data. Therefore, the question functionality has been redesigned and made improvements with the main focus on adding and fetching the data. Furthermore, had considerations on how to modify the questions, that is when changing an existing question which shouldn't be an issue but when it comes to deletion, it encounters a few problems.

# Week 8 (17 Mar-24 Mar):
> Created a modify view for questions that allows the admin to update or delete an existing question, the functionality of removing the competition has been added and overall improved UI design.

# Week 9 (24 Mar-31 Mar):
> Additional features added, 1. users can join competitions that have status="open" otherwise an appropriate message will display, similarly admin can open competition if there is at least one question, 2. fixed some errors caused by keyboard overflow, 3. verification for question form (must complete the form to add a question and notify the admin if success or fail), 4. admin can upload question in jpg, png format and view (retrieve) them in modify view, finally attempt to create a snack bar to indicate if the uploaded image was success or failure.

# Week 10 (31 Mar-7 Apr):
> Finalized the app, and added authentication login and logout functionalities moreover the admin can fully control the competition while the game is being played.
