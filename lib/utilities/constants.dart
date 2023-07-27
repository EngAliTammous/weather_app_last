import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50,
  letterSpacing: 14,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
const kSecondaryColor = Color(0xff74cace);

const kApiKey = 'e29d628497e22dc419694e40c27e9e87';

// Get the current date and time
DateTime now = DateTime.now();
// Get the day name
String dayName = DateFormat('EEEE').format(now); // EEEE gives full day name, E gives abbreviated day name
