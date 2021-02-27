
// Extending the String class functionality
extension Strip on String {
  String stripPrefix(String strip) {
    if (this.startsWith(strip)) {
      return this.substring(strip.length);
    } else {
      return this;
    }
  }
}


String getDomain(String input) {
  var inputUrl = input
      .stripPrefix("http://")
      .stripPrefix("https://")
      .stripPrefix("www.")
      .stripPrefix("WWW.");

  return inputUrl.split(".")[0];
}