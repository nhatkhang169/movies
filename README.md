# Movies - Test app

## Showcase

  https://github.com/nhatkhang169/movies/assets/1230519/bc71a079-dc13-44b3-b1e9-36a0832680ae


## Software principles, patterns and practices:
The project relies on CLEAN architeture with some adjustments. The main design pattern is being used is MVVM-C, utilizing Protocol Oriented Programming(POP), Ractive Programming(via Combine), mixing with some structures I experienced in other past projects. Unit testing is an extremely easy task.

## Brief description:
The idea of structure folder is based on `features`. Each feature will have a separated folder/group. Each feature folder contains groups for models (ViewModel, Model, Entity), views(Controller, View) and Interactor/Repo which are consumed by the feature.

Entities are business objects, used for parsing raw data objects from remote server (or local database).

The project was developed with Xcode 14.3, supporting iOS 16 or later
The project has these below dependencies(managed by Swift Package Manager):
1. [RealmSwift](https://github.com/realm/realm-swift): local storage, mobile database
2. [ProgressHUD](https://github.com/relatedcode/ProgressHUD): loading indicator
3. [SwiftGenPlugin](https://github.com/SwiftGen/SwiftGenPlugin): Swift code for resources (like images, localised strings, etc)

## Steps to run application:
1. Open the project with Xcode 14.3 (minimum: simulator iOS 16) 
2. Make sure `Package Dependencies` are all loaded successfully
3. Run the project with a simulator

## Done items:
1. Programming language
2. Design app architecture
3. Universal app support with all orientations
4. UI should be looked like design.
5. Write UnitTests (over 90% code coverage)
6. Exception handling
7. Local storage handling

## Additional note:
This project was completed in about 5 days:
- Day 1: Analyze and initilize project
- Day 2: Integrate with SwiftGenPlugin & RealmSwift and migrate initial data (RealmSwift is new to me)
- Day 3 & 4: Implement UI
- Day 5: Add unit tests
