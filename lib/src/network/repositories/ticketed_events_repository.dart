abstract class TicketedEventsRepository {
  Future<String> getPlaceId(double longitude, double latitude);
  Future<List<dynamic>> getTicketedExpoEvents(String day, String id, int numberOfEvents);
  Future<List<dynamic>> getTicketedConcertEvents(String day, String id, int numberOfEvents);
  Future<List<dynamic>> getTicketedFestivalEvents(String day, String id, int numberOfEvents);
  Future<List<dynamic>> getTicketedArtEvents(String day, String id, int numberOfEvents);
  Future<List<dynamic>> getTicketedSportEvents(String day, String id, int numberOfEvents);
}