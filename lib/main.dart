import 'package:flutter/material.dart';
import 'package:flutter_project/services/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'app/router/router.dart';
import 'app/router/routes.dart';

Future<void> main() async {
  await graphQLConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLConfig.client,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.splash,
        routes: routes,
      ),
    );
  }
}
