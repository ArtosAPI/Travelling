import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser {
  FirebaseUser._(this.name, this.email, this.password, this.likedCards);
  static FirebaseUser? ins;
  String name, email, password;
  List<dynamic> likedCards;
  static late String id;

  static Future<bool> signIn(String email, String password) async {
    try {
      final creds = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      id = await getUserId(creds.user!.email!);
      final user =
          await FirebaseFirestore.instance.collection('Users').doc(id).get();

      ins = FirebaseUser._(
        user.data()!['name'],
        user.data()!['email'],
        user.data()!['password'],
        user.data()!['likedCards'],
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signUp(String email, String name, String password,
      List<String> likedCards) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final creds = {
        'email': email,
        'password': password,
        'name': name,
        'likedCards': likedCards
      };
      final createdUser =
          await FirebaseFirestore.instance.collection('Users').add(creds);
      final user = await createdUser.get();

      ins = FirebaseUser._(
        user.data()!['name'],
        user.data()!['email'],
        user.data()!['password'],
        user.data()!['likedCards'],
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  void updateLikedCards(List<dynamic> likedCards) {
    this.likedCards = likedCards;
  }
}

// void createUser(FirebaseUser user) {
//   FirebaseFirestore.instance.collection('Users').add({
//     'name': user.name,
//     'email': user.email,
//     'password': user.password,
//     'likedCards': user.likedCards
//   });
// }

void updateLikedCards(List<dynamic> likedCards) async {
  final updatedUser = await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseUser.id)
      .get();

  final updatedLikedCards = updatedUser.data();
  FirebaseUser.ins!.updateLikedCards(likedCards);
  updatedLikedCards!['likedCards'] = FirebaseUser.ins!.likedCards;

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseUser.id)
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
