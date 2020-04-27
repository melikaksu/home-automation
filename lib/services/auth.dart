

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homesweethome/models/user_details.dart';
import 'package:homesweethome/services/database.dart';



class AuthService{

final FirebaseAuth _auth=FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();



///////////////////////////////////////////

User _userFromFirebaseUser(FirebaseUser at)=>at!=null
    ? User(at.uid): null;

///////////////////////////////////////////

Stream<User> get user {
  return _auth.onAuthStateChanged
//      .map((FirebaseUser user)=> _userFromFirebaseUser(user));
         .map(_userFromFirebaseUser);
}

///////////////////////////////////////////
Future signAnon () async {
  try{
     AuthResult result=await _auth.signInAnonymously();
     FirebaseUser user=result.user;
     return _userFromFirebaseUser(user);
  }
  catch(e){
    print(e.toString());
    return null;
  }
}

///////////////////////////////////////////

Future registerWithEmail(String email,String password) async{

  try{
    
    AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user=result.user;
    
    await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
    
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

Future signOut() async {
  try{
    return await _auth.signOut();


  }
  catch(e){
    print(e.toString());
    return null;
  }
}
///////////////////////////////////////////

Future signInWithEmail (String email,String password) async{
  try {
    AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user=result.user;
    return _userFromFirebaseUser(user);
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
  await googleSignIn.signOut();
  await _auth.signOut();
  print("User Sign Out");
}

///////////////////////////////////////////

Future<FirebaseUser> signInGoogleNew() async{

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser userDetails = authResult.user;
  ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

  List<ProviderDetails> providerData = new List<ProviderDetails>();

  providerData.add(providerInfo);

  UserDetails details = new UserDetails(
    userDetails.providerId,
    userDetails.displayName,
    userDetails.photoUrl,
    userDetails.email,
    providerData,
  );


  return userDetails;
}


}