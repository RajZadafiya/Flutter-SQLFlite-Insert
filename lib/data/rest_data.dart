import '../models/user.dart';
import '../utils/network_util.dart';

class RestData{
  NetworkUtil _networkUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL+"/";

  Future<User>? login(String username,String password){
    return new Future.value(new User(username, password));
  }
}