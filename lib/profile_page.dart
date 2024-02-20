import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/main.dart';
import 'package:mentalhealth_support_system/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //sign out
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
      (Route<dynamic> route) => false, // Clear the navigation history
    );
  }

  void showErrorMessageDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void deleteAccount(BuildContext context, String email) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Account Deletion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Please enter your password to confirm account deletion:'),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                String enteredPassword = passwordController.text;

                // Get the current user
                User? user = FirebaseAuth.instance.currentUser;

                // Create a credential with the entered password
                AuthCredential credential = EmailAuthProvider.credential(
                    email: email, password: enteredPassword);

                // Reauthenticate user with the credential
                user!.reauthenticateWithCredential(credential).then((_) {
                  // If reauthentication is successful, proceed with account deletion
                  user.delete().then((_) {
                    Navigator.of(context).pop();
                    signOut();
                    AlertDialog(
                      title: const Text('Account Deleted'),
                      content: const Text(
                          'Your account has been deleted successfully.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );

                    // Example: Navigator.pushReplacementNamed(context, '/login');
                  }).catchError((error) {
                    // Handle account deletion error
                    // Example: showErrorMessage('Failed to delete account');
                    Navigator.of(context).pop();
                    showErrorMessageDialog(context, "Failed to delete account");
                  });
                }).catchError((error) {
                  // Handle reauthentication error
                  // Example: showErrorMessage('Incorrect password');
                  Navigator.of(context).pop();
                  showErrorMessageDialog(context, "Incorrect password");
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String firstName = widget.userData['first name'] ?? 'Default First Name';
    String lastName = widget.userData['last name'] ?? 'Default Last Name';
    String email = widget.userData['email'] ?? 'default email';
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Your Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 225, 198)),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 94, 50),
        actions: [
          // Three dots icon for options menu
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selected option here
              if (value == 'update') {
                // Perform update account action
              } else if (value == 'delete') {
                deleteAccount(context, email);
                // Perform delete action
              } else if (value == 'logout') {
                // Perform logout action
                signOut();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'update',
                child: Text('Update Account'), // Update option
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout',
                    style: TextStyle(
                        color: Colors.red)), // Highlighted logout option
              ),
            ],
            icon: const Icon(Icons.more_vert,
                color: Colors.black), // Three dots icon
          ),
        ],
      ),
      body: _buildBody(context, firstName, lastName),
      backgroundColor: const Color.fromARGB(255, 233, 232, 236),
    );
  }

  Widget _buildBody(BuildContext context, String firstName, String lastName) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
            width: double.infinity,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.04), // Adjust the spacing as needed
          CircleAvatar(
            radius: 70,
            child: ClipOval(
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset(
                  'images/charess2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "$firstName $lastName",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontFamily: 'Arial',
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
