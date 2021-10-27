abstract class IConfig {
  String getBaseUrl();
}

class StgConfig implements IConfig {
  @override
  String getBaseUrl() {
    return 'http://localhost:8080/api/v1';
  }
}

class ProdConfig implements IConfig {
  @override
  String getBaseUrl() {
    return 'http://localhost:8081/api/v1';
  }
}