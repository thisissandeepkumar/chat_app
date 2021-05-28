import 'dart:io';

import 'package:chat_app/providers/authProvider.dart';
import 'package:chat_app/services/media_service.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:chat_app/services/snackbar_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late double maxWidth;
  late double maxHeight;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool isImageSelected;
  late File? finalPickedFile;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    isImageSelected = false;
    finalPickedFile = null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
          child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: Container(
          alignment: Alignment.center,
          child: _uiComponents(),
        ),
      )),
    );
  }

  Widget _uiComponents() {
    return Builder(
      builder: (BuildContext _context) {
        authProvider = Provider.of<AuthProvider>(_context);
        SnackBarService.instance.buildContext = _context;
        return Container(
          width: maxWidth,
          height: maxHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _headingTitle(),
                _profilePictureHolder(),
                _registrationUI(),
                _registerButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _headingTitle() {
    return Container(
      width: maxWidth,
      padding: EdgeInsets.only(
        left: 25.0,
        right: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s get going!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Please enter your details',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePictureHolder() {
    return GestureDetector(
      onTap: () async {
        File? pickedFile = await MediaService.instance.getImageFromLibrary();
        if (pickedFile != null) {
          setState(() {
            finalPickedFile = pickedFile;
            isImageSelected = true;
          });
        }
      },
      child: Container(
        height: maxHeight * 0.18,
        margin: EdgeInsets.only(
          top: 25.0,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
            image: isImageSelected
                ? DecorationImage(image: FileImage(finalPickedFile!))
                : null),
        child: Center(
          child: isImageSelected
              ? Text(
                  'Image Selected',
                )
              : Text(
                  'Tap to pick Image',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _registrationUI() {
    return Container(
      height: maxHeight * 0.4,
      padding: EdgeInsets.only(
        left: 25.0,
        right: 25.0,
      ),
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: "Name",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _registerButton() {
    return GestureDetector(
      onTap: () {
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          authProvider.registerUserWithEmailAndPassword(
              nameController.text,
              emailController.text,
              passwordController.text,
              finalPickedFile,
              null);
        }
      },
      child: Container(
        height: maxHeight * 0.065,
        width: maxWidth,
        margin: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            'Register',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
