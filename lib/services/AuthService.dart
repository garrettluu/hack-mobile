import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> authStateChanges() {
    return _auth.authStateChanges();
  }

  // Start the google sign in flow and return the firebase user when finished
  Future<User> googleSignIn() async {
    //Get google account
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    //Get authentication details
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    //Generate Auth credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    //Get the firebase user and return
    UserCredential authResult = await _auth.signInWithCredential(credential);
    User user = authResult.user;
    return user;
  }

  void signOut() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
  }
}

// Create singleton for auth service
final AuthService authService = AuthService();
