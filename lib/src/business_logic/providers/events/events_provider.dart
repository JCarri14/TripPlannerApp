//SERVICE
import 'package:flutter/material.dart';

import '../../../network/services.dart';

import '../../../network/api/api_response.dart';


//MODELS
import '../../models.dart';

class EventProvider with ChangeNotifier {
  FreeEventsService _freeEventsService;
  TicketedEventsService _ticketedEventsService;

  Map<ContentType, List<Event>> eventsData = new Map();
  List<Event> selectedEvents = [];
  ContentType currentCategoryType;
  Status fetchState;
  String eventsError = "";

  EventProvider() {
    _freeEventsService = FreeEventsService();
    _ticketedEventsService = TicketedEventsService();
    currentCategoryType = ContentType.SIGHT;
    eventsData.forEach((key, value) {
      eventsData[key] = [];
    });
  }

  ContentType getCategoryKey(String value) {
    return categories.keys.firstWhere(
    (k) => categories[k] == value, orElse: () => categories.keys.first);
  }

  Map<ContentType, List<Event>> get events {
    return eventsData;
  }

  List<Event> get categoryEvents {
    return eventsData[currentCategoryType] != null ? eventsData[currentCategoryType]: [];
  }

  String get currentCategory {
    return categories[currentCategoryType];
  }

  Status get fetchStatus {
    return fetchState;
  }

  bool get isLoading {
    return fetchState == Status.LOADING;
  }

  bool get isLoaded {
    return fetchState == Status.COMPLETED;
  }

  bool get isError {
    return fetchState == Status.ERROR;
  }
  
  String get fetchError {
    return eventsError;
  }

  void addSelectedEvent(Event event) {
    selectedEvents.add(event);
  }

  void setCurrentCategory(String category) {
    currentCategoryType = getCategoryKey(category);
    notifyListeners();
  }

  void fetchEvents({ContentType eventType, String latitude, String day, String longitude}) {
    print("General fetch");
    switch (eventType) {
      case ContentType.SIGHT:
        fetchFreeSightEvents(latitude, longitude, 5);
        break;
      case ContentType.NIGHT_LIFE:
        fetchFreeNightlifeEvents(latitude, longitude, 5);
        break;
        case ContentType.RESTAURANT:
          fetchFreeRestaurantEvents(latitude, longitude, 5);
          break;
        case ContentType.SHOPPING:
          fetchFreeShoppingEvents(latitude, longitude, 5);
          break;
        case ContentType.EXPOSITION:
          fetchTicketedExpoEvents(latitude, longitude, day, 5);
          break;
        case ContentType.CONCERT:
          fetchTicketedConcertEvents(latitude, longitude, day, 5);
          break;
        case ContentType.FESTIVAL:
          fetchTicketedFestivalEvents(latitude, longitude, day, 5);
          break;
        case ContentType.ART:
          fetchTicketedArtEvents(latitude, longitude, day, 5);
          break;
        case ContentType.SPORT:
          fetchTicketedSportEvents(latitude, longitude, day, 5);
          break;
      default:
    }
  }

  fetchFreeSightEvents(String latitude, String longitude, int numberOfEvents) async {
    if (eventsData[ContentType.SIGHT] == null || eventsData[ContentType.SIGHT].isEmpty) {
      fetchState = Status.LOADING;
      try {
        eventsData[ContentType.SIGHT] = await _freeEventsService.getFreeSightEvents(latitude, longitude, numberOfEvents);
        fetchState = Status.COMPLETED;
      } catch (e) {
        eventsError += e.toString();
        fetchState = Status.ERROR;
        
        print(e);
      }
      notifyListeners();
    }
  }

  fetchFreeNightlifeEvents(String latitude, String longitude, int numberOfEvents) async {
    if (eventsData[ContentType.NIGHT_LIFE] == null || eventsData[ContentType.NIGHT_LIFE].isEmpty) {
      fetchState = Status.LOADING;
      try {
        fetchState = Status.COMPLETED;
        eventsData[ContentType.NIGHT_LIFE] = await _freeEventsService.getFreeNightlifeEvents(latitude, longitude, numberOfEvents);
      } catch (e) {
        eventsError = e.toString();
        fetchState = Status.ERROR;
        print(e);
      }
      notifyListeners();
    }
  }
  
  fetchFreeRestaurantEvents(String latitude, String longitude, int numberOfEvents) async {
    if (eventsData[ContentType.RESTAURANT] == null || eventsData[ContentType.RESTAURANT].isEmpty) {
      fetchState = Status.LOADING;
    
      try {
        fetchState = Status.COMPLETED;
        eventsData[ContentType.RESTAURANT] = await _freeEventsService.getFreeRestaurantEvents(latitude, longitude, numberOfEvents);
      } catch (e) {
        eventsError = e.toString();
        fetchState = Status.ERROR;
        print(e);
      }
      notifyListeners();
    }
  }

  fetchFreeShoppingEvents(String latitude, String longitude, int numberOfEvents) async {
    if (eventsData[ContentType.SHOPPING] == null || eventsData[ContentType.SHOPPING].isEmpty) {
      fetchState = Status.LOADING;

      try {
        fetchState = Status.COMPLETED;
        eventsData[ContentType.SHOPPING] = await _freeEventsService.getFreeShoppingEvents(latitude, longitude, numberOfEvents);
      } catch (e) {
        eventsError = e.toString();
        fetchState = Status.ERROR;
        print(e);
      }
      notifyListeners();
    }
  }

  fetchTicketedExpoEvents(String latitude, String longitude, String day, int numberOfEvents) async {
    fetchState = Status.LOADING;
    try {
      //var id = await _ticketedEventsService.getPlaceId(double.parse(longitude), double.parse(latitude));
      eventsData[ContentType.EXPOSITION] = await _ticketedEventsService.getTicketedExpoEvents(
        day, latitude + "," + longitude, numberOfEvents);
      fetchState = Status.COMPLETED;
    } catch (e) {
      eventsError = e.toString();
      fetchState = Status.ERROR;
      print(e);
    }
    notifyListeners();
  }

  fetchTicketedConcertEvents(String latitude, String longitude, String day, int numberOfEvents) async {
    fetchState = Status.LOADING;
    try {
      //var id = await _ticketedEventsService.getPlaceId(double.parse(longitude), double.parse(latitude));
      eventsData[ContentType.CONCERT] = await _ticketedEventsService.getTicketedConcertEvents(
        day, latitude + "," + longitude, numberOfEvents);
      fetchState = Status.COMPLETED;
    } catch (e) {
      eventsError = e.toString();
      fetchState = Status.ERROR;
      print(e);
    }
    notifyListeners();
  }

  fetchTicketedFestivalEvents(String latitude, String longitude, String day, int numberOfEvents) async {
    fetchState = Status.LOADING;
    try {
      fetchState = Status.COMPLETED;
      //var id = await _ticketedEventsService.getPlaceId(double.parse(longitude), double.parse(latitude));
      eventsData[ContentType.FESTIVAL] = await _ticketedEventsService.getTicketedFestivalEvents(
        day, latitude + "," + longitude, numberOfEvents);
    } catch (e) {
      eventsError = e.toString();
      fetchState = Status.ERROR;
      print(e);
    }
    notifyListeners();
  }

  fetchTicketedArtEvents(String latitude, String longitude, String day, int numberOfEvents) async {
    fetchState = Status.LOADING;
    try {
      fetchState = Status.COMPLETED;
      //var id = await _ticketedEventsService.getPlaceId(double.parse(longitude), double.parse(latitude));
      eventsData[ContentType.ART] = await _ticketedEventsService.getTicketedArtEvents(
        day, latitude + "," + longitude, numberOfEvents);
    } catch (e) {
      eventsError = e.toString();
      fetchState = Status.ERROR;
      print(e);
    }
    notifyListeners();
  }

  fetchTicketedSportEvents(String latitude, String longitude, String day, int numberOfEvents) async {
    fetchState = Status.LOADING;
    try {
      fetchState = Status.COMPLETED;
      //var id = await _ticketedEventsService.getPlaceId(double.parse(longitude), double.parse(latitude));
      eventsData[ContentType.SPORT] = await _ticketedEventsService.getTicketedSportEvents(
        day, latitude + "," + longitude, numberOfEvents);
    } catch (e) {
      eventsError = e.toString();
      fetchState = Status.ERROR;
      print(e);
    }
    notifyListeners();
  }
}