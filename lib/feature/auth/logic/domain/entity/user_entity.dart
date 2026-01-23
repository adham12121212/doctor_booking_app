
class UserEntity{
  final String name;
  final String email;
  final String uid;

  UserEntity( {required this.email,required this.name,required this.uid});

  toEntity(){
    return UserEntity(uid: uid, name: name, email: email,);
  }

  toMap(){
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

}