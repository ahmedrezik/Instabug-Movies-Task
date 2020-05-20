# Instabug-Movies-Task

### Requirements
> Users should see a list of movies when they start the app with the section title “All Movies” . 

_Fulfilled by adding a TableView to the Main View COntroller with a section titled All Moviess_

> Users should see for each movie entry: Title, overview, date and poster.

_Fulfilled by displaying the required data on the cell and the overview is in a DetialView accessed by Tapping on the Cell_

> User should be able to load new pages as he scrolls down to the last cell.

_Fulffilled by creating  custom class for an Activity Indicaotr  and makes API Call as soon as it is displayed and hides when data is returned_

> Users should see a loading indicator at the bottom if the new page isn’t available. 

_Fulffilled by creating  custom class for an Activity Indicaotr  and makes API Call as soon as it is displayed and hides when data is returned_

> Users should be able to add a new movie of their own to the app.

_fulfilled by adding a UIButton (plus) the the Navigation TopBar_

> Users should be able to set the Title, overview, date and Image for his movie

_the AddMovie View COntroller allows the user to add the 4 attributes to create a Custom Movie Object_

> Users should be able to set the image for this movie from the gallery.

_fulfilled using UIKit's UIImagePickerController_

>Users should be able to see his newly added movies in a new section at the top with title “My movies”.

_The TableView in the Main View Controller contains a dedicated section for user created Movies_

### API

The Movie Database as required by the Requirments Document

### Testing 

The project includes 2 testing Target , one for Unit Tests and one for UI Test . Code COvergae =  83.9%

### Design
This project was designed through an MVC Design 
