# MediquoApp


## Building And Running The Project (Requirements)
* Swift 5.0+
* Xcode 12.1+
* iOS 14.1+

### General Application Frameworks
- Alamofire: [Link](https://github.com/Alamofire/Alamofire)
- PromiseKit: [Link](https://github.com/mxcl/PromiseKit)
- FlagKit: [Link](https://github.com/madebybowtie/FlagKit)
- GECoreDataManager: [Link](https://github.com/GuillemEspejo/CoreDataManager)


### Cocoapods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To install the project go to your terminal, go to the project root directory, make sure you have cocoapods setup, then run:

pod install

## Disclaimer
There is a mismatch in the documentation provided at [CityBikes API Documentation](http://api.citybik.es/v2/) and the response you get from the server. This complicates the understanding of an otherwise very simple data model and adds additional steps and problems to the creation of the app. They have been solved as best as I've been capable although they may not be exactly what was requested. Apologies for that.

## Architecture
This demo application uses [Clean Swift](https://clean-swift.com) (V.I.P.) architecture. This is a variation of V.I.P.E.R. developed and promoted by Raymond Law.

The app itself is a Master-Detail app for iPhone and iPad. It has been tested in an iPad Air 2 physical device and in iPhone 12 and 8 simulators.

## Project Structure

### Scenes
This contains the scenes used in the project and the general V.I.P. objects. There is a scene for showing the company-network list and another one for company details, which shows the parking stations as well.

### Shared
This includes all additional Views and Extensions used. It also contains a Resources and Constants list for
easier use from code.

### Resources
In this folder group you can find any 'physical' resource used by the app ( localizables, storyboards,etc)

### Services
This contains all the classes used for accessing the data (DataStores)

### Model
This includes all the needed model classes. There are two kinds of classes, the ones used by Core Data and restricted to use in the DataStores, and an unmanaged version that can be used throughout the code.


## Tests
The project contains tests for one of the scenes as basic example. According to the architecture, only the objects that create the full V.I.P. cycle must be tested (Viewcontroller, Interactor,Presenter). From those objects, only boundary crossing methods should be tested. 
Other objects (like workers or datastores) should be tested if needed depending on specific rules of the project.
