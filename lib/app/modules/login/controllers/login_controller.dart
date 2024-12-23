import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poleks/app/base/base_controller.dart';

import '../../../data/user_data.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/local_storage.dart';
import '../../../utils/realtime_database.dart';
import '../../../values/local_storage_values.dart';

class LoginController extends BaseController {
  final List<String> _scopes = <String>['email'];
  final RealtimeDatabase _database = RealtimeDatabase();

  void signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: _scopes).signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);

    var userData = UserData(
      uuid: user.user!.uid,
      name: user.user!.displayName!,
      email: user.user!.email!,
      photoUrl: user.user!.photoURL
    );

    _database.isUserExist(email: user.user!.email!).then((isExist) async {
      if(isExist){
        LocalStorage.saveValue(LocalStorageValues.USER, userData.toJson());
        Get.offAllNamed(Routes.HOME);
      } else {
        await FirebaseAuth.instance.signOut();
        showErrorToast("Anda tidak memiliki akses aplikasi");
      }
    });
  }
}
