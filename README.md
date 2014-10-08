# My First Generic iOS App to test iOS APIs

An iOS App similar to Instagram to use technologies like Core Data, Photo (Camera and Picker), Table Views and Segues
-----------------------

This was my first attempt to make a full-fledge iOS App after a lot of basic calculator and simple stuff Apps

But later converted this to a generic project as an example to use my code in projects using Core Data and Photo APIs

Very Buggy Approach to myStonyGram haha! but it was my first attempt to Core Data and Multi-VC App

I learnt this from many online resources like iTunes U Stanford Videos and Stack Overflow,

Learning a lot during the course of coding this app but now I want to share some pieces of code that code save some time 
for coders using Core Data and Photo API.

This project is still buggy so I insist only to go to part of code that relates to your project. 

Issues: 

1. No unique username checking for now
2. Comments Part still in progress 
3. Photo Display Order

List of generic things implemented:

### Create an Account and Save it in Core Data 

The login page has an option to sign up and login, 

No Login Button as the GO(Return Button) will begin the process of login.

Sign up button opens a generic view controller to sign up. 

![Alt text](/images/login.png?raw=true "Login VC")

### Adding Photos to the Feed and Store photo information in Core Data

Click the image to click picture from camera or pick photo from the camera roll/photo library

Photo information, i.e., the photo title along with which user took it and photoURL in the photo-library
is saved in Core Data

![Alt text](/images/takePhoto1.png?raw=true)
![Alt text](/images/takePhoto2.png?raw=true)
![Alt text](/images/takePhoto3.png?raw=true)
![Alt text](/images/takePhoto4.png?raw=true)
![Alt text](/images/takePhoto5.png?raw=true)
![Alt text](/images/takePhoto6.png?raw=true)

### News feed pulling data from Core Data and putting it in Custom UITableViewCells  

This table view controller displays all the feed. 

Photos being displayed is shown by saving the URL of the photo in the camera roll/photo library

The photos are stored in the photo library but I save the photo URL to not save photos in Core Data as binary.

![Alt text](/images/newsfeed.png?raw=true "NewsFeed VC")