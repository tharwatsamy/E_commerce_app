import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier
{
  bool isAdmin =false ;
  changeIsAdmin(bool value )
  {
    isAdmin=value;
    notifyListeners();
  }
}