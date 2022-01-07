# CTRL_HUB
A central app that houses a variety of information related to daily tasks

- budget tracking
- stock research
- daily tasks / habit tracker
- chat messaging
- random projects

#Important
- there are two config files that are gitignored
    - one at web/config.js with a script<> reference in index.html. This connects to the firebase project
    - a config file DO_NOT_COMMIT holds the plaid api keys

# Activity Log
## 1/7/2022
- issues with firebase app initialize
    - in the shuffle somehow lost the config file so need to re-add
## 8/24/21
- Reviewing structuring flutter app. Need to refactor and organize now that the basic authentication, data fetching is set up.
## 8/19/21
- test in example works; implementing in main app
- followed doc at https://firebase.flutter.dev/docs/auth/social
- fuctions signInWithGoogle() userCred return doesnt have to be stored anywhere...
- So far the auth component is bare bones; need to secure it to cloud function calls
## 8/16/21
- Review deep dive article on [implementing google auth flutter](https://medium.com/firebase-developers/dive-into-firebase-auth-on-flutter-third-party-authentication-a242472ae347)
## 8/12/21
- Implementing Google Auth using flutterfire and google_sign_in_web package
- doc https://pub.dev/packages/google_sign_in_web
## 8/2/21
- Review pattern tasks https://github.com/plaid/pattern
- Setup User model
- Store keys and users in firestore db
- Implement Google Auth
- tie to all function calls

## 8/1/21
- Built out link token authentication cloud function
- Need to finish authentication and basic data call

## 7/28/21
- Need to update the cloud function to use onCall
- Test in flutter app

## 7/23/21
- Testing cloud functions in repository https://github.com/MMattLeeE/CTRL_HUB_Functions
- Building the initial link token creation function.

## 7/22/21
New plan: For initial mvp just going to use firebase cloud functions for the back end and firebase authentication
then later build out custom backend infrastructure 

## 7/21/21
Authentication to make calls to the plaid api require using there Link front end plug in. Implementation requires a back end app server to call and return a token to the client.

Will build a node.js app server after refreshing knowledge
