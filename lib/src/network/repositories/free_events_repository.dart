abstract class FreeEventsRepository {
  Future<List<dynamic>> getFreeSightEvents(String latitude, String longitude, int numberOfEvents);
  Future<List<dynamic>> getFreeNightlifeEvents(String latitude, String longitude, int numberOfEvents);
  Future<List<dynamic>> getFreeRestaurantEvents(String latitude, String longitude, int numberOfEvents);
  Future<List<dynamic>> getFreeShoppingEvents(String latitude, String longitude, int numberOfEvents);
}