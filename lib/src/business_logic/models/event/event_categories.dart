enum ContentType {
  ART,
  COMMERCIAL,
  CONCERT,
  EXPOSITION,
  RESTAURANT,
  SHOPPING,
  SIGHT,
  NIGHT_LIFE,
  FESTIVAL,
  SPORT,
}

enum FreeEventCategory {SIGHTS, NIGHTLIFE, RESTAURANT, SHOPPING}


const Map<ContentType, String> categories = {
  ContentType.ART: "art",
  ContentType.COMMERCIAL: "commercial",
  ContentType.CONCERT: "concert",
  ContentType.EXPOSITION: "exposition",
  ContentType.FESTIVAL: "festival",
  ContentType.RESTAURANT: "restaurant",
  ContentType.SHOPPING: "shopping",
  ContentType.SIGHT: "sight",
  ContentType.NIGHT_LIFE: "night life",
  ContentType.SPORT: "sport",
};