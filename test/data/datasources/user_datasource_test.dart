import 'package:dartz/dartz.dart';
import 'package:flutter_project/app/failure/failure.dart';
import 'package:flutter_project/data/datasources/user_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/entities/user/user_fixture.dart';
import '../../services/graphql/mock_graphql_client.dart';
import '../../services/graphql/mock_graphql_query_result.dart';

void main() {
  const maxRepositories = 3;
  const login = 'login';
  final user = UserFixture.model;
  final graphQLClient = MockGraphQLClient();
  final userDataSource = UserDataSourceImpl(graphQLClient: graphQLClient);
  final queryOptions = QueryOptions(document: gql('''
      query GetUser(\$login: String!, \$maxRepositories: Int!) {
        user(login: \$login) {
          avatarUrl
          bio
          repositories(first: \$maxRepositories) {
            nodes {
              name
            }
          }
        }
      }
    '''), variables: const {
    'login': login,
    'maxRepositories': maxRepositories,
  });
  final queryResult = MockGraphQLQueryResult();
  final graphQLResponse = {
    "user": {
      "avatarUrl": "${user.avatarUrl}",
      "bio": "${user.bio}",
      "repositories": {
        "nodes": user.repositories!
            .map((repo) => Map.fromEntries([MapEntry("name", repo.name)]))
            .toList()
      }
    }
  };

  test('Should return a user on success', () async {
    when(
      () => graphQLClient.query(queryOptions),
    ).thenAnswer((_) async => queryResult);

    when(
      () => queryResult.data,
    ).thenReturn(graphQLResponse);

    final result = await userDataSource.getUserInfo(
        login: login, maxRepositories: maxRepositories);
    expect(result, Right(user));
  });

  test('Should return a GetUserInfoFailure on null', () async {
    when(
      () => graphQLClient.query(queryOptions),
    ).thenAnswer((_) async => queryResult);

    when(
      () => queryResult.data,
    ).thenReturn(null);

    final result = await userDataSource.getUserInfo(
        login: login, maxRepositories: maxRepositories);
    expect(result, Left(GetUserInfoFailure()));
  });
}
