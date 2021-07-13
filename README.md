===

# OddJobz

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
- Peer- to- peer marketplace apps where anyone can list small jobs and a price (for example, mow a lawn for $20 or fix a leaky pipe for $30) and anyone can choose to do the job for the amount.
- People that are offering their services may also list a few jobs that they are experienced with and show flat rates/prices.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category: Business**
- **Mobile: Yes, mobile-first.**
- **Story: Everyone has their strengths and weaknesses. OddJobz will let people that specialize in certain areas help those in need. **
- **Market: Anyone that has a job that needs to be done and has money or can do a job and needs money can use this app.**
- **Habit: Anytime there is something that a user may be struggling with, they can post a job listing for it on OddJobz. For example, maybe you need help moving your couch upstairs but don't feel like hiring a moving crew. You can post it on OddJobz, and maybe a neighbor that used to work for a moving company (or is just very strong) accepts the job to come and help you.**
- **Scope:**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Must have sign in/log out functionality
* There should be a profile details page for any user
* Jobs detail page for any job listing (includes person that posted it, info about the job, distance, skill rating, pay, address)
* Must have some way to pay and accept payments (collect card info, apple pay, paypal, etc.)
* Should have list and grid views of jobs
* Must have a search and sort function (sort through listings by category, for example)
* Must have some kind of rating system (so that if someone has bad ratings, you know not to hire or work for them)
* Must utilize location services (so that you only see nearby listings)

**Optional Nice-to-have Stories**

* Some sort of safety feature (maybe having an emergency contact notified when you arrive for a job or someone arrives for yours)
* Messaging between clients
* Add an option for setting a time for the job to be done:
   - Warn users if jobs they sign up for has a time conflict

### 2. Screen Archetypes

* [Home Screen]
   * [login/logout button]
   * [Grid and list views of jobs]
   * [Search and sort function]
* [User Info]
   * [Profile details page for any user]
   * [Rating system]
* [Job Info]
   * [Job details page for any job]


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [List view, grid view] (home screen)
* [Back] (user info)
* [Back] (job info)

**Flow Navigation** (Screen to Screen)

* [Home Screen]
   * [Grid view > List View]
   * [Search sort view]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
[Add picture of your hand sketched wireframes in this section]
![Wireframe  2](https://user-images.githubusercontent.com/86276796/125313361-2760e280-e303-11eb-896b-de0f4d71042a.jpg)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
Objects: 
User:
- Name
- Star rating
- Account age
- Available Listings
- Completed jobs
- Location *maybe
- Reviews *maybe

Reviews: *maybe
- Poster
- Posted on/at
- Review text
- Listing name
    
Listings:
- Price
- Skill Level
- Posted by
- Location
- Post date
- Name
- Description


User

| Property      | Type          | 
| ------------- | ------------- |
| name  | String  |
| password  | String  |
| accountAge  |NSDate?  |


Profile

| Property      | Type          | 
| ------------- | ------------- |
| displayName  |String  |
| starRating | double |
| availableListings | int | 
| completedJobs | int 
| location | String |

Listing

| Property      | Type          | 
| ------------- | ------------- |
| price  | double  | 
| skillLevel  |double  | 
| postedBy | String | 
| listingName | String | 


Review

| Property      | Type          | 
| ------------- | ------------- |
| poster  | String  | 
| postedAt  | Date | 
| reviewText| String | 
| location | String | 
| postDate | Date | 
| jobTitle | String | 
| jobDescription | String | 



### Models
User

| Property      | Type          | Value
| ------------- | ------------- |-------------
| name  | String  |First and last name of user.
| displayName  |String  |User's username.
| starRating | double | Average user rating.
| availableListings | int | How many job postings the user has currently open.
| completedJobs | int | How many jobs the user has completed.
| location | String | The location of the user in City, State format.

Listing

| Property      | Type          | Value
| ------------- | ------------- |-------------
| price  | double  | The desired cost/pay of a job listing.
| skillLevel  |double  | The estimated difficulty of the current job listing.
| postedBy | String | Shows the user that posted the current job listing.
| location | String | Location of the current job listing.
| postDate | Date | Date that the current job was posted.
| jobTitle | String | Job title.
| jobDescription | String | Detailed description of the current job listing.


### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
