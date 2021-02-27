class Environment {
  static String imageAssets = 'assets/images/';
  static String logoAssets = 'assets/logo/';
  static String iconAssets = 'assets/icons/';
  static String flareAssets = 'assets/flares/';

  static Map<String, String> headerPost = {};

  // production
  static String baseUrl = 'https://api.tesmasif.pikobar.jabarprov.go.id/api';
  static String clientId = 'pikobar-tesmasif-checkin';
  static String loginUrl =
      'https://sso.digitalservice.jabarprov.go.id/auth/realms/jabarprov/protocol/openid-connect/token';
  static String audKey = 'tes-masif-checkin';

  // staging
  static String stagingUrl = 'https://tesmasif-api.rover.digitalservice.id/api';
  static String stagingclientId = 'tes-masif-web';
  static String loginStagingUrl =
      'https://keycloak.digitalservice.id/auth/realms/jabarprov/protocol/openid-connect/token';
}
