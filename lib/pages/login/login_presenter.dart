import '../../data/rest_data.dart';
import '../../models/user.dart';

abstract class LogInPageContract{
  void onLogInSuccess(User user);
  void onLogInError(String error);
}

class LogInPagePresenter{
  LogInPageContract _view;
  RestData api = new RestData();
  LogInPagePresenter(this._view);

  doLogin(String username,String password){
    api.login(username, password)?.
    then((user) => _view.onLogInSuccess(user)).
    catchError((onError)=>_view.onLogInError(onError.toString()));
  }
}