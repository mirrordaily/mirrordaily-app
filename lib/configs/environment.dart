import 'package:mirrordaily_app/configs/base_config.dart';
import 'package:mirrordaily_app/configs/dev_config.dart';
import 'package:mirrordaily_app/configs/prod_config.dart';

enum BuildFlavor { production, development }

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  late BaseConfig config;
  late BuildFlavor flavor = BuildFlavor.development;

  initConfig(BuildFlavor buildFlavor) {
    config = _getConfig(buildFlavor);
  }

  BaseConfig _getConfig(BuildFlavor buildFlavor) {
    flavor = buildFlavor;
    switch (buildFlavor) {
      case BuildFlavor.production:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
