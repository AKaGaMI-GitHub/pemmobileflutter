import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:latihan/Model/errMsg.dart';
import 'package:latihan/Services/apiStatic.dart';
import 'package:latihan/UI/homePage.dart';

const users = const {
  'test@gmail.com': '00000',
};

class LoginPage extends StatelessWidget {
  static var routeName = "login";
  late ErrorMSG res;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      var params = {
        'email': data.name,
        'password': data.password,
      };
      res = await ApiStatic.signIn(params);
      if (res.success == true) {
        print("oke");
      } else {
        return res.message;
      }
      return '';
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return "User doesn't exists";
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
