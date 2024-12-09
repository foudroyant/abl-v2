import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User_Provider with ChangeNotifier {
  User_Model user;
  //notifyListeners();
  User_Provider({ required this.user,});
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