import 'package:dartz/dartz.dart';
import 'package:flutter_project/data/datasources/user_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/entities/user_fixture.dart';
import '../../services/graphql/mock_graphql_client.dart';
import '../../services/graphql/mock_graphql_query_result.dart';

void main() {
  const login = 'login';
  final user = UserFixture.model;
  final graphQLClient = MockGraphQLClient();
  final userDataSource = UserDataSourceImpl(graphQLClient: graphQLClient);
  final queryOptions = QueryOptions(document: gql('''
      query GetUser(\$login: String!) {
        user(login: \$login) {
          avatarUrl
          bio
        }
      }
    '''), variables: const {
    'login': login,
  });
  final queryResult = MockGraphQLQueryResult();
  final graphQLResponse = {
    "user": {
      "avatarUrl": "${user.avatarUrl}",
      "bio": "${user.bio}",
    }
  };

  test('Should return a user on success', () async {
    when(
      () => graphQLClient.query(queryOptions),
    ).thenAnswer((_) async => queryResult);

    when(
      () => queryResult.data,
    ).thenReturn(graphQLResponse);

    final result = await userDataSource.getUserInfo(login: login);
    expect(result, Right(user));
  });
}
