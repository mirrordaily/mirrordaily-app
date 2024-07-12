import 'package:mirrordaily_app/configs/base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  // TODO: implement graphqlPath
  String get graphqlPath =>
      "https://daily-gql-dev-axzdcnzvtq-de.a.run.app/api/graphql";
}
