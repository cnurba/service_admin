/// Describe method of secure storage.
abstract class ITokenStorage {
  /// Get token.
  Future<String?> read();
  /// Save token.
  Future<void> save(String token);
  /// Clear storage.
  Future<void> clear();
}
