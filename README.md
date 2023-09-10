# YetAnotherWetherApp

Weather app based on openweather API.
Matrix architecture was used in development.
The basic logic of the application is contained in the appcoordinator. The next domain logic layer should contain specialized coordinators(locations, weather, search). Coordinators use shared features(modules) such as persistence and networking.
UI is based on viewModels and swiftUI views.
Appcoordinator is covered with unit tests.

In real app, specialized coordinators should contain more logic like managing caching, persistence, and stuff like that.

Some UI was taken from https://github.com/Datafox-JCP/WeatherSampleApp.
I'm too lazy to write my own wrapper above CoreLocation so I took the existing one https://github.com/alexandrehsaad/swift-locations.git

Things need to be done:
 - Add some city image service
 - Refactor error screen. Now it is a dead-end.
 - Refactor persistence. Change it to something more interesting than UserDefaults.
 - Cover coordinators with unit tests.
 - and many more... )
