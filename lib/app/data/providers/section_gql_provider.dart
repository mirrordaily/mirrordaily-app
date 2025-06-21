import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/providers/base_gql_provider.dart';

import 'package:mirrordaily_app/core/values/gql_query.dart';

class SectionGqlProvider extends BaseGQLProvider {
  Future<List<Section>> getSectionList() async {
    final query = GQLQuery.getSections;
    final result = await executeQuery(query);
    if (result.hasException || result.data == null) {
      return [];
    }
    final dataList = result.data!['sections'] as List<dynamic>;
    return dataList.map((e) => Section.fromJson(e)).toList();
  }
}
