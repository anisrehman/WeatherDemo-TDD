# WeatherDemo-TDD
This demo project gets 100% test coverage. Unit Tests and Integration Tests have been written. 

Here is the screenshot for Test Coverage

![Alt text](/Screenshots/TestCoverage.png?raw=true "Test Coverage")

## App Features
- Get the current weather for list of cities.
- Tap on a city and get forcast for 5 days for different times in a day.

## App Architecture
### MVVM
It follows MVVM architecutre. It uses Combin framwork to bind ViewController views.
### ViewControllerFactory
This class is responsible for creating ViewControllers. It also create the dependancies of a ViewController and setup ViewController object. The benifit of this class is that ViewController creation details are hidden for the caller.
### Router/Coordinator
One ViewController should not create anotehr ViewController inside it. It will make tight coupling. To keep the loose coupling between ViewControllers, Router class is being used. Router is responsible to show/dismiss ViewControllers
