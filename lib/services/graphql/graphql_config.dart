import 'package:flutter/material.dart';
import 'package:flutter_project/app/constants/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  late ValueNotifier<GraphQLClient> client;

  init() async {
    await initHiveForFlutter();

    final HttpLink httpLink = HttpLink(
      Constants.gitHubGraphQLAPI,
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${Constants.gitHubToken}',
    );

    final Link link = authLink.concat(httpLink);

    client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}

final graphQLConfig = GraphQLConfig();