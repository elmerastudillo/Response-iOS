# Response iOS Client 
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()

Our mission is to give everyone the power to *respond* to what they care about most.

## Installation
We use [CocoaPods](http://cocoapods.org) for our dependency manager. This should be installed before continuing.

Clone the project with
```
git clone https://github.com/keivanshahida/response-ios.git
```

After cloning the project, `cd` into the new directory and install dependencies with
```
pod install
```
Open the Response Xcode workspace, `Response.xcworkspace`, and enjoy!

## Analytics and Crash Reporting:
1. Firebase
    * Database / Storage
    * Analytics
    * App Performance
    
2. Fabric
    * Crash Reporting

---

## Development 
  * [Models](#models)
  * [Views](#views)
  * [Controllers](#controllers)
  * [Other Classes](#other-classes)
  * [External Services](#external-services)

### Models

#### User


#### Organization 

| Name       | Type   | Description                             |
|------------|--------|-----------------------------------------|
| id         | String | Unique identifier.                      |
| name       | String | Organization name.                      |
| orgCode    | String | Organization code.                      |
| logoImage  | String | Logo image URL.                         |
| thumbnail  | String | Thumbnail image URL.                    |
| location   | String | Location of Organization.               |
| videoURL   | String | Video URL.                              |
| mission    | String | Mission of Organization.                |
| slogan     | String | Organization slogan.                    |

#### Mission 

| Name       | Type   | Description                             |
|------------|--------|-----------------------------------------|
| id         | String | Unique identifier.                      |
| name       | String | Mission name.                           |
| orgCode    | String | Mission code.                           |
| logoImage  | String | Logo image URL.                         |
| thumbnail  | String | Thumbnail image URL.                    |
| location   | String | Location of Mission.                    |
| videoURL   | String | Video URL.                              |
| mission    | String | Mission of Mission.                     |
| slogan     | String | Mission slogan.                         |

#### Cause

| Name        | Type   | Description                             |
|-------------|--------|-----------------------------------------|
| id          | String | Unique identifier.                      |
| title       | String | Cause name.                             |
| image       | String | Image URL.                              |
| logoImage   | String | Logo image URL.                         |
| location    | String | Location of Cause.                      |
| shortDesc   | String | Short description of Cause.             |
| description | String | Description of Cause.                   |
| responses   | String | Responses count                         |
| chairtySN   | Int    | Charity/Organization short name         |
| dateStarted | Date   | Date cause was started                  |

#### Response

| Name           | Type   | Description                                   |
|----------------|--------|-----------------------------------------------|
| id             | String | Unique identifier.                            |
| userID         | String | User Unique Identifier.                       |
| amountDonated  | Float  | Dollar amount donated.                        |
| storyID        | String | Dtory Unique Identifier.                      |
| causeID        | String | Cause Unique Identifier.                      |
| missionID      | String | Mission Unique Identifier.                    |
| timestamp      | Date   | Date response was created                     |

#### Story

| Name           | Type   | Description                             |
|----------------|--------|-----------------------------------------|
| title          | String | Story name.                             |
| date           | Date   | Date story was created.                 |
| subtitle       | String | Subtitle of story.                      |
| location       | String | Current location of story.              |
| latitude       | Float  | Latitude point of current location.     |
| longitude      | Float  | Longitude point of current location.    |
| storyImage     | String | Story image URL.                        |
| storyVideo     | String | Story video URL.                        |
| orgID          | String | Organization Unique Identifier.         |
| responses      | Int    | Responses to current story.             |
| amtCollected   | Int    | Total amount collected.                 |
| avgDonation    | Float  | Average Donation.                       |
| uniqueDonors   | Float  | Amount of unique donors                 |


### Views

#### Cells

#### Headers


### Controllers

### Other Classes

### External Services

 * [Fabric](https://get.fabric.io/?utm_campaign=discover&utm_medium=natural): Used to track every move of our users. 
 * [SnapKit](http://snapkit.io/docs/): Used for some AutoLayout magic.
 * [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON): Used for improved JSON parsing.

Check out [Issues](https://github.com/keivanshahida/response-ios/issues) to see what we are working on!

For information on our version control practices click [here](https://bible.cornellappdev.com/git/).

For information on our style guidelines click [here](https://github.com/keivanshahida/response-ios/wiki/Style-Guidelines).

[Back to top ^](#)

