import 'dart:async';
import 'package:shopisan/model/user_model.dart';
import 'package:shopisan/model/api_model.dart';
import 'package:shopisan/api_connection/api_connection.dart';
import 'package:shopisan/dao/user_dao.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate ({
    required String username,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(
        username: username,
        password: password
    );
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken ({
    required User user
  }) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future <void> deleteToken({
    required int id
  }) async {
    await userDao.deleteUser(id);
  }

  Future <bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }

  Future <String> getAuthToken() async {
    Map<dynamic, dynamic>? user = await userDao.getUser(0);
    return user?['token'];
  }
}