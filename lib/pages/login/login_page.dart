import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/database_helper.dart';
import '../../models/user.dart';
import 'login_presenter.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> implements LogInPageContract {
  late BuildContext _ctx;
  late bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  late String _username, _password;

  late LogInPagePresenter _presenter;

  _LogInPageState() {
    _presenter = new LogInPagePresenter(this);
  }

  void _submit(){
    late final form;
    form = formKey.currentState;

    if(form.validate()){
      setState((){
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text){
    scaffoldKey.currentState?.showSnackBar(new SnackBar(content: new Text("text")));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("LogIn"),
      color: Colors.blueGrey,
    );
    var loginForm = new Column(
      children: <Widget>[
        new Text(
          "Log In Via SQFlite",
          textScaleFactor: 3.0,
        ),
        new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val!,
                  decoration: new InputDecoration(labelText: "Enter User Name..."),
                 ),
                ),
                new Padding(padding: const EdgeInsets.all(10.0),
                  child: new TextFormField(
                    onSaved: (val) => _password = val!,
                    decoration: new InputDecoration(labelText: "Enter Password..."),
                  ),
                ),
              ],
            )),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(title: new Text("Login"),),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLogInError(String error) {
    // TODO: implement onLogInError
    _showSnackBar(error);
    setState((){
      _isLoading = false;
    });
  }

  @override
  void onLogInSuccess(User user) async{
    // TODO: implement onLogInSuccess
    _showSnackBar(user.toString());
    setState((){
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
