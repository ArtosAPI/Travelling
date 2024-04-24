import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MyUser {
  MyUser._(this.name, this.email, this.password, this.likedCards);
  static late final MyUser ins;
  String name, email, password;
  List<dynamic> likedCards;
  static late String id;

  static void init() async {
    final creds = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'ptektov@gmail.com', password: 'pavel1');
    id = await getUserId(creds.user!.email!);
    final user =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();

    ins = MyUser._(
      user.data()!['name'],
      user.data()!['email'],
      user.data()!['password'],
      user.data()!['likedCards'],
    );
  }

  void updateLikedCards(List<dynamic> likedCards) {
    this.likedCards = likedCards;
  }
}

void createUser(MyUser user) {
  FirebaseFirestore.instance.collection('Users').add({
    'name': user.name,
    'email': user.email,
    'password': user.password,
    'likedCards': user.likedCards
  });
}

void updateLikedCards(List<dynamic> likedCards) async {
  final updatedUser =
      await FirebaseFirestore.instance.collection('Users').doc(MyUser.id).get();

  final updatedLikedCards = updatedUser.data();
  MyUser.ins.updateLikedCards(likedCards);
  updatedLikedCards!['likedCards'] = MyUser.ins.likedCards;
  print(updatedLikedCards!['likedCards']);

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(MyUser.id)
      .set(updatedLikedCards);
}

Future<String> getUserId(String email) async {
  final snaps = FirebaseFirestore.instance.collection('Users').snapshots();

  await for (final a in snaps) {
    for (final b in a.docs) {
      if (b['email'] == email) {
        return b.id;
      }
    }
  }
  return 'none';
}
