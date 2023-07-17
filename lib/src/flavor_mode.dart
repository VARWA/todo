class FlavorMode {
  FlavorModes flavorModeValue = FlavorModes.prod;

  FlavorMode._();

  static final FlavorMode _instance = FlavorMode._();

  factory FlavorMode() => _instance;
}

enum FlavorModes {
  prod,
  dev,
}
