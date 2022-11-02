# DemoWeatherApp (Nordic Weather) - a simple weather app built for iOS

<img src="/Readme/NordicWeather.png" align="left"
width="200" hspace="10" vspace="10">

DemoWeatherApp (Nordic Weather) is an iOS app with a deployment target of iOS 15.5.
Built with UIKit as part of an iOS Development Bootcamp.
This app relies on the Locationforecast 2.0 and Sunset 2.0 APIs provided by the [Norwegian Meteorological Institute (met.no)](https://www.met.no/) and the [Norwegian Broadcasting Corporation (NRK)](https://www.nrk.no/).<br/><br/><br/><br/><br/><br/>

## About
This app lets users get fairly accurate weather forecast within the Nordic Region as specified by yr.no, however it does allow to get weather forecast outside of the Nordic region as well.
The App was built with UIKit framework using storyboards. It relies on CoreLocation to fetch user location coordinates and to pass them for the API calls. For the search function within the MapView CLGeocoder is used and for displaying a map apple's MapKit is used.

## Features
- Displays an approximate user location on the map and provides a simple view of current weather.
- WeatherNow section displays detailed weather forecast for the current hour.
- LaterToday section provides an estimate text based prediction of the weather for the next 1 hour, 6 hours and 12 hours.
- Provides a temperature and weather condition forecast for the next 24 hours or 10 days from current date.
- Sunrise & Sunset section pisplays the time of sunset/sunrise for current day.
- Switch between system default, light or dark theme.
- Optional Daily notifications for weather forecast.

## Permissions
Whilst the deployment target is iOS 15.5 or higher, the app should function on lower versions as well.
For the app to work normally it needs the following:
- Network Access
- Permission to track user location
- Permission to send notifications

## TODO:
- Widget with WidgetKit
- Background data refresh
- Forecast Graph w/ Swift Charts
- Fix notification data not updating
- Fix the bug where app sets multiple notifications
- Improve sorting algorithm for the json data
- Localisation for Norway, Sweden, Finland, Estonia, Latvia, Denmark(?)

## Screenshots
<img src="/Readme/WeatherApp001.png" align="left"
width="250">
<img src="/Readme/WeatherApp002.png" align="left"
width="250">
<img src="/Readme/WeatherApp003.png" align="left"
width="250">
