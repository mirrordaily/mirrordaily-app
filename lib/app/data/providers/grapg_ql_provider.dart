import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'package:mirrordaily_app/configs/environment.dart';

class GraphQLProvider extends GetxService {
  late GraphQLClient client;

  @override
  void onInit() {
    super.onInit();

    final HttpLink httpLink = HttpLink(
      Environment().config.graphqlPath,
      defaultHeaders: {
        'Content-Type': 'application/json; charset=utf-8',
        'X-Apollo-Operation-Name': 'post' // 設置 Content-Type
      },
    );

    client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: httpLink,
        queryRequestTimeout:const Duration(minutes: 1)
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
    print('mutate start');
    final result = await client.mutate(options);
    print('mutate finish');
    return result;
  }
}
