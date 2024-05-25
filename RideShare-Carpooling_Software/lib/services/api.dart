const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf6248afb1e4f511394d3391d2e89514f8c60e';

getRouteUrl(String startpoint, String endpoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startpoint&end=$endpoint');
}
