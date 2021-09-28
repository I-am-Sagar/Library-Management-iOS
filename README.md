## Library Management

This is the first iOS app I made to learn about ObjC, iOS dev and Xcode. 

### How to run this app? 

To run this app, you will need a Mac with Xcode installed in it. 

**Step 1: Install Pods**

`Pods` are analogous to `node_modules/` in the web development. Just like `package.json` file is used to install `node_modules/`, you can install `Pods/` using `Podfile`. Install `Cocoapods` command-utility, analogous to `npm` and then run the following command inside the `Library Management/` folder:

```s
$ pod install
```

**Step 2: Set up Firebase Account**

As a next step you will need a firebase account to work with _Login_ and _Sign Up_ functionalities of the app. You will need to download a `GoogleService-Info.plist` file as follows and put it with `Info.plist` file in `Library Management/` folder. 

- Go to firebase homepage and create an account if you don't have one. 
- Create a new project and then select `iOS` for the project. 
- In the Bundle ID field, paste this: `com.sagarudasi.Library-Management`
- Just keep clicking next and download `GoogleService-Info.plist`

> Note: It is possible that even after keeping `GoogleService-Info.plist` at right place, you may not be able to run the app. This is because the Xcode works with references, rather than actual files. In this case you need to open the project in Xcode (by clicking .xproject file) and then drag the file at the appropiate location. 

**Step 3: Build the App and run it**

The title says it all. Just build it and try to run it. You may come up with error like `Multiple commands produce Info.plist`, which you can solve using this link https://stackoverflow.com/questions/50718018/xcode-10-error-multiple-commands-produce. 

### Features implemented in this app

**1. Login & Sign Up**

- [x] User can create account using Sign Up functionality and then login in the app 
- [ ] Forgot Password functionality
- [ ] Logging In using social media accounts like - Google or Facebook account

**2. Main App**

- [x] Showing the Books on the Library page fetched from itbooks api
- [x] Detailed view of each book separately 
- [x] Efficient fetching of data (dispatch_async calls). 
- [x] Caching of the images fetched
- [x] Persistent storage of items like Issued Books and Search History
- [ ] Clearing the History
- [ ] Deleting User account
- [ ] Changing Username and Password

<hr/>
