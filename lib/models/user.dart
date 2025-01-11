import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User_Provider with ChangeNotifier {
  User_Model user;
  //notifyListeners();
  User_Provider({ required this.user,});

  add_person(Person p){
    user.add_person(p);
    notifyListeners();
  }
}

class User_Model {
  final String email;
  final Timestamp createdAt;
  final List<Person> personnes;
  final String phoneNumber;
  final String displayName;

  User_Model({
    required this.email,
    required this.createdAt,
    required this.personnes,
    required this.phoneNumber,
    required this.displayName,
  });

  add_person(Person p){
    personnes.add(p);
  }

  // Méthode pour convertir un Map en une instance de User
  factory User_Model.fromMap(Map<String, dynamic> map) {
    return User_Model(
      email: map['email'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      personnes: (map['personnes'] as List<dynamic>?)
          ?.map((person) => Person.fromMap(person as Map<String, dynamic>))
          .toList() ??
          [],
      phoneNumber: map['phone'] ?? '',
      displayName: map['name'] ?? '',
    );
  }

  // Méthode pour convertir une instance de User en Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'createdAt': createdAt,
      'personnes': personnes.map((person) => person.toMap()).toList(),
      'phone': phoneNumber,
      'name': displayName,
    };
  }

}

class Person {
  final String nom;
  final String telephone;

  Person({
    required this.nom,
    required this.telephone,
  });

  // Méthode pour convertir un Map en une instance de Person
  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      nom: map['nom'] ?? '',
      telephone: map['telephone'] ?? '',
    );
  }

  // Méthode pour convertir une instance de Person en Map
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'telephone': telephone,
    };

  }

}

class User_Info {
  final String displayName;
  final String telephone;
  final String email;
  final String uid;

  User_Info({
    required this.displayName,
    required this.telephone,
    required this.email,
    required this.uid,
  });

  // Convertir UserInfo en Map
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'telephone': telephone,
      'email': email,
      'uid': uid,
    };
  }

  // Créer un objet UserInfo à partir d'une Map
  factory User_Info.fromMap(Map<String, dynamic> map) {
    return User_Info(
      displayName: map['displayName'] ?? '',
      telephone: map['telephone'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
    );
  }
}
