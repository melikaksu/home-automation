

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homesweethome/models/user.dart';



class AuthService{

final FirebaseAuth _auth=FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


///////////////////////////////////////////

User _userFromFirebaseUser(FirebaseUser user)=>
    user!=null
    ? User(user.uid)
    : null;

///////////////////////////////////////////

Stream<User> get onAuthStateChanged =>_auth.onAuthStateChanged.map(_userFromFirebaseUser);


///////////////////////////////////////////


Future registerWithEmail(String email,String password) async{

  try{
    AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user=result.user;
    
    // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100); 
    return _userFromFirebaseUser(user);
  }

  catch(e){
    print(e.toString());
    return null;
  }

}
///////////////////////////////////////////



Future forgorPassword (String email) async {

await _auth.sendPasswordResetEmail(email: email);

}



///////////////////////////////////////////



Future signInWithEmail (String email,String password) async{
  try {
    AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user=result.user;
    return _userFromFirebaseUser(user) !=null;
  }
  catch (e){
    print(e.toString());
    return null;

  }
}

/////////////////////////////////////////////



Future signInWithGoogle() async{

final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

final AuthResult authResult = await _auth.signInWithCredential(credential);
final FirebaseUser user = authResult.user;

assert(!user.isAnonymous);
assert(await user.getIdToken() != null);

final FirebaseUser currentUser = await _auth.currentUser();

assert(user.uid == currentUser.uid);

return 'signInWithGoogle succeeded: ${user.uid}';

}
///////////////////////////////////////////

Future signOutGoogle() async{
  try{
  await googleSignIn.signOut();
  await _auth.signOut();
  print("User Sign Out");}
  catch(e){
    print(e.toString());
    return null;}
  
}

///////////////////////////////////////////
Future<User> signInAnonymously() async {
    final authResult = await _auth.signInAnonymously();
    return _userFromFirebaseUser(authResult.user);
  }

}