import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/providers/base_gql_provider.dart';
import 'package:mirrordaily_app/app/data/providers/grapg_ql_provider.dart';
import 'package:mirrordaily_app/core/values/gql_query.dart';

class CategoryGqlProvider extends BaseGQLProvider{
  Future<List<Category>> getCategoryBySectionSlug(
      {required String? slug}) async {
    final query = GQLQuery.getCategoriesBySectionSlug;
    final result = await executeQuery(query, variables: {'slug': slug});

    if (result.hasException ||
        result.data == null ||
        result.data?['categories'] == null) {
      return [];
    }
    final categoryList = result.data?['categories'] as List<dynamic>;

    return categoryList.map((e) => Category.fromJson(e)).toList();
  }

}