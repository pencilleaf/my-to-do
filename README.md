# ToDo's App
A to-do list application written in Swift 5 for iOS featuring basic CRUD (Create, Read, Update, Delete) for tasks. It was developed using Core Data, Apple's data persistence framework, as well as SwiftUI to build the user interface. Core Data was used to manage the model objects easily, as it allows us to create a schema to describe a ToDoItem entity and its properties, and then maps the records in the persistent store to managed objects that is used in the application.

<img src="https://user-images.githubusercontent.com/43260774/87439055-e2886a00-c622-11ea-9e3e-16e6e4f57c9f.png" alt="screenshot" height="320"/>

## Features
- Create tasks with due dates
- Mark tasks as complete
- Edit tasks by tapping on each row
- Delete tasks by swiping or using the Edit button to remove multiple rows at once

## Requirements
- Xcode 11.5, Swift 5

## Instructions
Clone the repository and open the project in Xcode
```
git clone https://github.com/pencilleaf/my-to-do.git
cd my-to-do
xed .
```
Build and run on any iOS mobile device simulator (iPhone 11 Pro was used in the above screenshots)
