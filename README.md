# Swift-UIkit-Projects

This repository contains a collection of projects built using `UIkit`. Each project showcases different features and functionalities. A repo with the same projects, but with `SwiftUI` is [here](https://github.com/hyonbokan/SwiftUI-projects)

## Projects

### Personal Blog
**PersonalBlog** is an interactive mobile app that allows users to craft and share their stories through a combination of text and images.

#### Demo:

<p float="left">
  <img src="Project_img/PersonalBlog/1.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/PersonalBlog/2.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/PersonalBlog/3.png" width="200" style="margin-right: 10px;" /> 
  <img src="Project_img/PersonalBlog/4.png"width="200" style="margin-right: 10px;" />
  <img src="Project_img/PersonalBlog/5.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/PersonalBlog/6.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/PersonalBlog/7.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/PersonalBlog/demovideo.gif" width="200" style="margin-right: 10px;" />
</p>

#### Key Features:

- User authentication
- Real-time database interactions
- Image, post uploads
- Post like status and updates
- Custom collection and table view cells
- MVVM Design Pattern

In the development of **PersonalBlog**, I put a strong emphasis on refining the user experience and implementing advanced customizations. Below are the key conceps I practiced: 
- **Concurrent User Retrieval**: retrieving user data concurrently, ensuring a smooth user experience.
- **Parallel Post Retrieval**: fetching blog posts for each user in parallel, reducing overall data retrieval time.
- **View Model Creation**: creating view models for blog posts concurrently, ensuring a responsive user interface.
- **UI Update on the Main Queue**: updating the user interface on the main queue to maintain responsiveness and provide up-to-date content.

### ToDoList

**ToDoList** is a task management application that allows users to efficiently manage their daily tasks. 

#### Demo:

<p float="left">
  <img src="Project_img/ToDoList/1.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/ToDoList/2.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/ToDoList/3.png" width="200" style="margin-right: 10px;" /> 
  <img src="Project_img/ToDoList/4.png"width="200" style="margin-right: 10px;" />
  <img src="Project_img/ToDoList/5.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/ToDoList/demo.gif" width="200" style="margin-right: 10px;" />
</p>

#### Key Features:

- **User Authentication**: Users can easily register and log in to the app. Authentication is securely handled using Firebase Auth.
  
- **Task Management**: 
  - **Add Tasks**: Users can add tasks to their list, specifying the title, date, and exact time for each task.
  - **Delete Tasks**: Any task can be removed from the list with a simple action.
  - **Task Completion**: Tasks can be marked as completed once they are done.
  
- **Backend**: The backend of the app is powered by Firebase. All data is stored and fetched in real-time from Firebase Firestore.

### Airbnb

**Airbnb** offers a simplified version of the popular Airbnb platform. This project was designed to provide a hands-on learning experience, focusing on API integration, data modeling.

#### Demo:
<p float="left">
  <img src="Project_img/Airbnb/1.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/Airbnb/2.png" width="200" style="margin-right: 10px;" />
  <img src="Project_img/Airbnb/3.png" width="200" style="margin-right: 10px;" /> 
</p>

#### Key Features:

- **API Integration**: In this project, we delve into the world of APIs and learn how to interact with external data sources. We utilize the Airbnb API, which is sourced from [OpenDataSoft](https://public.opendatasoft.com/explore/dataset/airbnb-listings/table/?disjunctive.host_verifications&disjunctive.amenities&disjunctive.features), to fetch scrapped data for Airbnb listings.

- **Data Modeling**: A fundamental aspect of this project is creating and defining structures for Airbnb listings.

- **User Interface**: The app presents a list of Airbnb listings in New York, providing essential information such as photos, listing details, and host information.