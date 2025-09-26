import 'package:flutter/material.dart';

class PlaylistForm {
  static build({
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController descritpionController,
  }) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: _inputDecoration("Nom"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: descritpionController,
            decoration: _inputDecoration("Description"),
            validator: (value) {
              return null;
            },
          ),
        ],
      ),
    );
  }

  static InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      label: Text(label),
      border: OutlineInputBorder(),
    );
  }
}
