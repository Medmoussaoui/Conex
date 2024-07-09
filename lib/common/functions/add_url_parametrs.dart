String addParametersToUrl(String baseUrl, Map<String, String> params) {
  // Create a Uri from the base URL
  Uri uri = Uri.parse(baseUrl);
  // Append the query parameters
  final newUri = uri.replace(queryParameters: {...uri.queryParameters, ...params});
  // Return the new URL as a string
  return newUri.toString();
}