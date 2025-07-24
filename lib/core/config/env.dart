enum AppEnvironment { development, production, test }

class Env {
  static late String baseUrl;

  static void setEnvironment(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.development:
        baseUrl = 'http://192.168.1.100:8000/api/';
        break;
      case AppEnvironment.production:
        baseUrl = 'http://192.168.1.100:8000/api/';
        break;
      case AppEnvironment.test:
        baseUrl = 'http://192.168.1.100:8000/api/';
        break;
    }
  }
}