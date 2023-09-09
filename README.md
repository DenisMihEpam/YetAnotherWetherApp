# YetAnotherWetherApp

Wether app based on openwether API.
Matrix architecture was used in development.
The basic logic of the application is contained in the appcoordinator. The next layer of domain logic should contain specialized coordinators(locations, wether, search). Coordinators use shared features(modules) such as persistence and networking.
UI is based on viewModels and swiftUI views.
Appcoordinator is covered with unit tests.

In real app specialized coordinators should contain more logic like managing caching, persistence and stuff like that.
Some UI was taken from https://github.com/Datafox-JCP/WeatherSampleApp.
Thing need to be done:
 - add some city image service
 - refactor error screen. Now it is a deadend.
 - Refactor persistence. Change it to something more interesting than UserDefaults.
 - Cover coordinators with unit tests.
 - and many more... )
