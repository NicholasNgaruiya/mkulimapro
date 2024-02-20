import '../../models/user_account.dart';

class ControllerManagement {
  UserAccount? userAccount;
  void setUserAccount({required UserAccount userAccount}) {
    this.userAccount = userAccount;
  }
  UserAccount getUserAccount()=> userAccount!;

}