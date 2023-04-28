import 'package:dartz/dartz.dart';
import 'package:flutter_project/app/failure/failure.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/entities/user_extention.dart';
import 'package:flutter_project/services/graphql/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class UserDataSource {
  Future<Either<Failure, User>> getUserInfo({required String login});
}

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({GraphQLClient? graphQLClient})
      : _graphQLClient = graphQLClient ?? graphQLConfig.client.value;
  final GraphQLClient _graphQLClient;

  @override
  Future<Either<Failure, User>> getUserInfo({required String login}) async {
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

    if(response.data == null) return Left(GetUserInfoFailure());

    return Right(UserExtensions.fromMap(response.data as Map));
  }
}
