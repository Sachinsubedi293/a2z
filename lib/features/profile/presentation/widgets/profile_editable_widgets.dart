import 'package:flutter/material.dart';

class EditableProfile extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController bioController;
  final GlobalKey<FormState> formKey;

  const EditableProfile({
    super.key,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.bioController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(emailController, 'Email', Icons.email),
          _buildTextField(firstNameController, 'First Name', Icons.person),
          _buildTextField(lastNameController, 'Last Name', Icons.person_outline),
          _buildMultiLineTextField(bioController, 'Bio', Icons.edit),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          hintText: 'Enter your $label',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        validator: (value) =>
            value!.isEmpty ? 'Please enter your $label' : null,
      ),
    );
  }

  Widget _buildMultiLineTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          hintText: 'Enter your $label',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        maxLines: 5,
        validator: (value) =>
            value!.isEmpty ? 'Please enter your $label' : null,
      ),
    );
  }
}

class ViewProfile extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String bio;

  const ViewProfile({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileDetail('Email:', email),
        _buildProfileDetail('First Name:', firstName),
        _buildProfileDetail('Last Name:', lastName),
        _buildProfileDetail('Bio:', bio),
      ],
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '$label $value',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
