import 'package:flutter/material.dart';

class PersonFormBottomSheet extends StatefulWidget {
  const PersonFormBottomSheet({Key? key}) : super(key: key);

  @override
  _PersonFormBottomSheetState createState() => _PersonFormBottomSheetState();
}

class _PersonFormBottomSheetState extends State<PersonFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _telephoneController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ajouter une personne',
              //style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _prenomController,
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un prénom';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _telephoneController,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un numéro de téléphone';
                }
                // Vous pouvez ajouter une validation plus poussée pour le numéro de téléphone ici
                return null;
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Traitement du formulaire
                  print('Nom: ${_nomController.text}');
                  print('Prénom: ${_prenomController.text}');
                  print('Téléphone: ${_telephoneController.text}');
                  // Fermer le BottomSheet
                  Navigator.of(context).pop();
                }
              },
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}

