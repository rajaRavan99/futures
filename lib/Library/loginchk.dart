import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CheckLogin {

  static dynamic chkauth() async{

    if (_auth.currentUser != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('umobile', _auth.currentUser!.phoneNumber.toString());
      await prefs.setString('gid',  _auth.currentUser!.uid);
      return _auth.currentUser;
    }
    else
      return null;
  }

}