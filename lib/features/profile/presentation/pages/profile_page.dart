import 'dart:io';
import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:a2zjewelry/features/profile/domain/entities/profile_entity.dart';
import 'package:a2zjewelry/features/profile/presentation/providers/profile_providers.dart';
import 'package:a2zjewelry/features/profile/presentation/widgets/profile_editable_widgets.dart';
import 'package:a2zjewelry/features/profile/presentation/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late Future<Box<ProfileResModel>> _profileBoxFuture;
  File? _imageFile;
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    _profileBoxFuture = Hive.openBox<ProfileResModel>('profileBox');
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    bioController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final profileNotifier = ref.watch(profileProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(onPressed: (){context.go('/start/home');}, icon: Icon(Icons.arrow_back)),
      ),
      body: profileState.loading
          ? const Center(child: CircularProgressIndicator())
          : profileState.error != null
              ? Center(child: Text('Error: ${profileState.error}'))
              : SingleChildScrollView(
                  child: FutureBuilder<Box<ProfileResModel>>(
                    future: _profileBoxFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final box = snapshot.data!;
                        final profileResModel = box.get('profile');

                        if (profileResModel != null) {
                          emailController.text = profileResModel.email ?? '';
                          firstNameController.text = profileResModel.firstName ?? '';
                          lastNameController.text = profileResModel.lastName ?? '';
                          bioController.text = profileResModel.bio ?? '';

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileImage(
                                  initialImage: profileResModel.avatar,
                                  edit: profileNotifier.isEditing,
                                  onImagePicked: (imageFile) {
                                    setState(() {
                                      _imageFile = imageFile;
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),
                                profileNotifier.isEditing
                                    ? EditableProfile(
                                        emailController: emailController,
                                        firstNameController: firstNameController,
                                        lastNameController: lastNameController,
                                        bioController: bioController,
                                        formKey: GlobalKey<FormState>(),
                                      )
                                    : ViewProfile(
                                        email: emailController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        bio: bioController.text,
                                      ),
                                const SizedBox(height: 20),
                                if (profileNotifier.isEditing)
                                  ProfileActions(
                                    onSave: (context) async {
                                      await profileNotifier.updateUser(
                                        ProfileEntity(
                                          email: emailController.text,
                                          first_name: firstNameController.text,
                                          last_name: lastNameController.text,
                                          bio: bioController.text,
                                          avatar: _imageFile?.path ?? profileResModel.avatar,
                                        ),
                                        _imageFile,
                                      );
                                    },
                                    onCancel: () {
                                      profileNotifier.setEditing(false);
                                    },
                                  )
                                else
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        profileNotifier.setEditing(true);
                                      },
                                      child: const Text('Edit Profile'),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        } else {
                            
                          return const Center(child: Text('No profile data found'));
                        }
                      } else {
                        
                        return const Center(child: Text('No profile data available'));
                      }
                    },
                  ),
                ),
    );
  }
}
