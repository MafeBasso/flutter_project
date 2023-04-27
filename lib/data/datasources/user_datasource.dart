import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/entities/user_extention.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class UserDataSource {
  Future<User> getUserInfo({required String login});
}

class UserDataSourceImpl implements UserDataSource {
  const UserDataSourceImpl({required GraphQLClient graphQLClient})
      : _graphQLClient = graphQLClient;
  final GraphQLClient _graphQLClient;

  @override
  Future<User> getUserInfo({required String login}) async {
    final response = await _graphQLClient.query(QueryOptions(document: gql('''
      query GetUser(\$login: String!) {
        user(login: \$login) {
          avatarUrl
          bio
        }
      }
    '''), variables: {
      'login': login,
    }));

    return UserExtensions.fromMap(response.data as Map);
  }
}
