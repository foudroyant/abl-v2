import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../home/screnn.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _createUserInFirestore(User user) async {
    try {
      // Créez un document utilisateur dans Firestore
      CollectionReference users = FirebaseFirestore.instance.collection(
          'users');

      // Vérifiez si l'utilisateur existe déjà dans Firestore
      DocumentSnapshot snapshot = await users.doc(user.uid).get();
      if (!snapshot.exists) {
        // Créez un nouveau document avec des informations de base
        await users.doc(user.uid).set({
          'email': user.email,
          'displayName': user.displayName,
          'createdAt': FieldValue.serverTimestamp(),
          'personnes' : [
            {
              'nom': "Moi",
              'telephone': "",
            }
          ]
        });

        print("Utilisateur créé dans Firestore !");
      }
    } catch (e) {
      print("Erreur lors de la création de l'utilisateur dans Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                if (state is SignedIn) {
                  // Utilisateur connecté avec succès
                  // Créez un utilisateur dans Firestore ici
                  _createUserInFirestore(state.user!);
                }
              })
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/institut.png'),
                ),
              );
            },

            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Bienvenu sur ABL, veuillez-vous connecter!')
                    : const Text('Bienvenu sur ABL, Veuillez-vous inscrire!'),
              );
            },

            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/institut.png'),
                ),
              );
            },
          );
        }

        return const MyHomePage(title: 'ABL',);
      },
    );
  }
}