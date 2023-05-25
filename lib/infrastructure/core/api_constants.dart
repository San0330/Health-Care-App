class ApiConstants {
  const ApiConstants._();

  // API URL for the local server or hosted server
  static const String baseUrl = "http://192.168.0.103:4000/api";

  // only if there is any key based feature on server
  static const String apiKey = "my-api-key";

  // URL and Keys for infermedica API
  static const String diagnosisApiUrl =
      'https://api.infermedica.com/v2/diagnosis';
  static const String diagnosisAppId = "";
  static const String diagnosisAppKey = "";

  // Google maps key
  static const String googleMapsApi = "";

  // url/path of the static image on server
  static String imageUrl(String imageName) => '$baseUrl/image/$imageName';
}
