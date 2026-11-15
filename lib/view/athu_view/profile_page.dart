
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? profileImage;

  final ImagePicker picker = ImagePicker();

  // Pick Profile Image
  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          profileImage = File(image.path);
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to select image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xff172B4D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: const Color(0xff172B4D),
                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                children: [

                  // Profile Picture
                  GestureDetector(
                    onTap: pickImage,

                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: profileImage != null
                                  ? FileImage(profileImage!)
                                  : null,
                              child: profileImage == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: pickImage,
                                child: const CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.camera_alt, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                        CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.white,

                          backgroundImage:
                          profileImage != null
                              ? FileImage(profileImage!)
                              : null,

                          child: profileImage == null
                              ? const Icon(
                            Icons.person,
                            size: 65,
                            color: Color(0xff172B4D),
                          )
                              : null,
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,

                          child: Container(
                            padding: const EdgeInsets.all(7),

                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Your Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'yourname@gmail.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Edit Profile Button
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18),

                    label: const Text('Edit Profile'),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: statsCard('05', 'My Posts'),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: statsCard('03', 'Lost Items'),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: statsCard('02', 'Found Items'),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Account Settings
            sectionTitle('Account Settings'),

            const SizedBox(height: 12),

            menuTile(
              Icons.person_outline,
              'Personal Information',
                  () {},
            ),

            menuTile(
              Icons.notifications_none,
              'Notifications',
                  () {},
            ),

            menuTile(
              Icons.lock_outline,
              'Privacy & Security',
                  () {},
            ),

            menuTile(
              Icons.settings_outlined,
              'Settings',
                  () {},
            ),

            const SizedBox(height: 22),

            // Support
            sectionTitle('Support'),

            const SizedBox(height: 12),

            menuTile(
              Icons.help_outline,
              'Help & Support',
                  () {},
            ),

            menuTile(
              Icons.info_outline,
              'About FindIt',
                  () {},
            ),

            const SizedBox(height: 25),

            // Logout
            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Firebase Logout will be added later',
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),

                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Statistics Card
  Widget statsCard(String number, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 5,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        children: [

          Text(
            number,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff172B4D),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Section Title
  Widget sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Color(0xff172B4D),
        ),
      ),
    );
  }

  // Settings Menu
  Widget menuTile(
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xff172B4D),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Colors.grey,
        ),

        onTap: onTap,
      ),
    );
  }
}
