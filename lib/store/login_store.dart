import "package:mobx/mobx.dart";

//1 - definir a outra parte
part 'login_store.g.dart';

//2 - criar uma classe juntando as duas partes
class LoginStore = _LoginStore with _$LoginStore;

//3 - criar nossa classe principal
abstract class _LoginStore with Store {
  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool passWordVisible = true;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void togllePasswordVisibility() => passWordVisible = !passWordVisible;

  Future<void> login() async {
    loading = true;
    await Future.delayed(const Duration(seconds: 2));

    loading = true;
    loggedIn = true;
    email = "";
    password = "";
  }

  @action
  void logOut() {
    loggedIn = false;
  }

  @computed
  Function() get loginPressed =>
      (isEmailValid && isPasswordValid && !loading) ? login : () {};

  @computed
  bool get isEmailValid => email.contains("@");

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @computed
  bool get isPasswordValid => password.length >= 6;
}
