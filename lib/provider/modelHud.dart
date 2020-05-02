import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier
{
  bool isLoading =false;

  changeisLoading(bool value)
  {
    isLoading=value;
    notifyListeners();
  }
}