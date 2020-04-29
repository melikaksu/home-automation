class User{
  final String userUid;
//  final String providerDetails;
//  final String userName;
//  final String photoUrl;
//  final String userPassword;
  //final String userEmail;

//  final List<ProviderDetails> providerData;

  User(this.userUid,);

}


class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails,this.userName, this.photoUrl,this.userEmail, this.providerData);
}
class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}

