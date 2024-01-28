import 'package:get/get.dart';

class UserLogged {
  static Rxn<Map<String, dynamic>> user = Rxn(null);

  static setUser(Map<String, dynamic> data) {
    user.value = data;
  }

  static Map<String, dynamic> getUser() {
    return user.value!;
  }
}
