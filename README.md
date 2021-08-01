# CTRL_HUB
A central app that houses a variety of information related to daily tasks

- budget tracking
- stock research
- daily tasks / habit tracker

# Activity Log
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
