import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'package:mirrordaily_app/configs/environment.dart';

class GraphQLProvider extends GetxService {
  late GraphQLClient client;

  @override
  void onInit() {
    super.onInit();

    final HttpLink httpLink = HttpLink(Environment().config.graphqlPath);

    client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: httpLink,
    );
  }

  Future<GraphQLProvider> init() async {
    return this;
  }

  Future<QueryResult> query(String query,
      {Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );

    final result = await client.query(options);
    return result;
  }

  Future<QueryResult> mutate(String mutation,
      {Map<String, dynamic>? variables}) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );

    final result = await client.mutate(options);
    return result;
  }
}
