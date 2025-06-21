import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:mirrordaily_app/app/data/providers/grapg_ql_provider.dart';

abstract class BaseGQLProvider extends GetxService {
  final GraphQLProvider graphQLProvider = Get.find();

  Future<QueryResult> executeQuery(String query,
      {Map<String, dynamic>? variables}) async {
    return await graphQLProvider.query(query, variables: variables);
  }

  Future<QueryResult> executeMutation(String mutation,
      {Map<String, dynamic>? variables}) async {
    return await graphQLProvider.mutate(mutation, variables: variables);
  }
}
