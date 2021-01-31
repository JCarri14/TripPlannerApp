abstract class BaseRepository<Type> {
  Future<List<dynamic>> getAll();
  Future<Type> getById(String id);
  Future<Type> getByName(String name);
}