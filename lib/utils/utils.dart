import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//! display the drawer
void displayDrawer(BuildContext context) {
  Scaffold.of(context).openDrawer();
}

//! file picker
Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}

//! convert a string 24 hour time to 12 hour
String convert24HourTo12Hour(String time24) {
  final DateFormat formatter = DateFormat('h:mm a');
  final DateTime dateTime = DateFormat('HH:mm').parse(time24);
  final String formattedTime = formatter.format(dateTime);
  return formattedTime;
}

//! format date
String formatDate(DateTime dateTime) {
  final DateFormat formatter = DateFormat("d'th,' MMMM");
  return formatter.format(dateTime);
}

// generate random 6 digit
String generateRandomSix() {
  Random random = Random();
  int randomNumber = random.nextInt(900000) + 100000;
  return randomNumber.toString();
}

//! DEACTIVATING THE BACK BUTTON/SWIPE
Future<bool> stopWillPop() async => false;

String removeLastCharacters(
    String originalString, int numberOfCharactersToRemove) {
  if (originalString.length <= numberOfCharactersToRemove) {
    // If the original string length is less than or equal to the number of characters to remove,
    // return an empty string as there won't be any characters left.
    return '';
  } else {
    // Calculate the new length of the string after removing the characters.
    int newLength = originalString.length - numberOfCharactersToRemove;

    // Use the substring method to get the desired portion of the original string.
    String result = originalString.substring(0, newLength);

    return result;
  }
}
