# TRIP PLANNER APP

A simple Flutter app to start planning your trips.

## Getting Started

### 💻 Requirements

- Any Operating System (ie. MacOS X, Linux, Windows)
- Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)
- A little knowledge of Dart and Flutter

### 🔌 Install Dependencies

Run `flutter pub get i` or `dart pub get` in the terminal to install the dependencies.

### 🔧 Environment Variables

Create an `.env` file in the root of the project with the following entries:

- `API_KEY`: RapidAPI Key 
- `API_HOST_FLIGHT`: URL of Fligh Scanner API
- `API_HOST_GEO`: URL of GeoDB API
- `API_HOST_HOTELS`: URL of Hotels API

- `API_ACCESS_TOKEN_FREE_EVENTS`: Access token from Amadeus API
- `API_KEY_FREE_EVENTS`: API Key from Amadeus API
- `API_KEY_SECRET_FREE_EVENTS`: API Key Secret from Amadeus API

- `API_ACCESS_TOKEN_TICKETED_EVENTS`: API Access Token from PredictHQ API

- `API_TOKEN_MAPBOX`: API Token from Mapbox
- `API_URL_TEMPL_MAPBOX`: API Url from Mapbox

```env
// .env
API_KEY=''
API_HOST_FLIGHT='skyscanner-skyscanner-flight-search-v1.p.rapidapi.com'
API_HOST_GEO='wft-geo-db.p.rapidapi.com'
API_HOST_HOTELS='hotels4.p.rapidapi.com'

API_ACCESS_TOKEN_FREE_EVENTS=''
API_KEY_FREE_EVENTS=''
API_KEY_SECRET_FREE_EVENTS=''

API_ACCESS_TOKEN_TICKETED_EVENTS=''

API_TOKEN_MAPBOX=''
API_URL_TEMPL_MAPBOX=''
```

## Authors

- [Joan Carrión](https://github.com/JCarri14)
- [Daniel Casado](https://github.com/danielcasadofauli)
