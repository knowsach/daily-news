class Constants {
  Constants._();
  static Constants _instance = Constants._();
  factory Constants() => _instance;

  final String api = 'https://newsapi.org/v2/top-headlines?';
  final String apiKey = 'cc21bae149414cfebf78d82e238ff507';
}
