String checkForFormat(String input) {
  var parts = input.split(" ");
  for (var part in parts) {
    switch (part.toLowerCase()) {
      case "en":
        return "Engelsk";
      case "da":
        return "Dansk";
      case "id":
        return "Idræt";
      case "ma":
        return "Matematik";
      case "sp":
        return "Spansk";
      case "de1":
        return "Design & arkitektur";
    }
  }
  return input;
}
