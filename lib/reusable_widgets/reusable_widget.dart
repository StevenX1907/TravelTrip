import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPassWordType,
    TextEditingController controller, bool isDarkMode) {
  Color textColor = isDarkMode ? Colors.white : Colors.black.withOpacity(0.9);
  Color labelColor = isDarkMode ? Colors.white : Colors.black.withOpacity(0.9);
  Color fillColor = isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.3);
  return TextField(
    controller: controller,
    obscureText: isPassWordType,
    enableSuggestions: !isPassWordType,
    autocorrect: !isPassWordType,
    cursorColor: Colors.black,
    style: TextStyle(color: textColor),
    decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54),
        labelText: text,
        labelStyle: TextStyle(color: labelColor),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: fillColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: isPassWordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

TextField reusableTextField1(String text, IconData icon, bool isPassWordType,
    TextEditingController controller,
    {String? nationality}) {
  return TextField(
    controller: controller,
    obscureText: isPassWordType,
    enableSuggestions: !isPassWordType,
    autocorrect: !isPassWordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.black54),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      suffixIcon: nationality != null
          ? CountryCodePicker(
              onChanged: print,
              initialSelection: nationality,
              favorite: ['+886', 'TW'],
              showCountryOnly: true,
              showOnlyCountryWhenClosed: true,
              flagDecoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(90),
              ),
            )
          : null,
    ),
    keyboardType: isPassWordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 30,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          isLogin ? 'LOG IN' : 'SIGN UP',
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black;
              } else {
                return Colors.white;
              }
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))))),
  );
}

Container nextButton(BuildContext context, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 30,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: const Text(
        'Submit',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black;
          } else {
            return Colors.white;
          }
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    ),
  );
}