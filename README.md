# WindyCity

This is a simple app to check the wind and other weather conditions in any city or location around the world. It uses the OpenWeatherMap API and will require an API key to do anything useful.

## Demonstrates:

- Swift 5
- Simple MVVM architecture
- Using CocoaPods for dependency management
- Consuming JSON from a RESTful API
- Using Codable to read and write local & remote data
- Basic unit testing
- Simple custom UI and Auto Layout

## To do:

Given more time to work on this these are areas I'd like to address:
- Making the city search view controller modal to improve flow through the app
- Autocompleting search for cities etc. by putting the city/location list into a SQLite database or using Google Places or similar API
- More friendly error handling for when a city or location can't be found
- API requests are handled very quickly generally, but ideally a loading spinner or something should be shown if they take more than a second or two to complete
- More extensive unit tests
