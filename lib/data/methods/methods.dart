import 'package:cloud_firestore/cloud_firestore.dart';

String? emailValidator(String? value) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (value == null || value.isEmpty) {
    return 'email field can\'t be empty';
  } else if (!regex.hasMatch(value)) {
    return 'please enter a valid email';
  } else {
    return null;
  }
}

String? securityCodeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Security code can\'t be empty';
  } else if (value.length < 4) {
    return 'Security code must be at least 4 characters long';
  } else {
    return null;
  }
}

Future<String?> resetsecurityCodeValidator(String? value) async {
  if (value == null || value.isEmpty) {
    return 'Security code field can\'t be empty';
  } else if (value.length < 4) {
    return 'Security code can\'t be less than 4 digits';
  } else {
    // Fetch the security code from Firestore (replace `adminCollection` with your collection name)
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('securitycode', isEqualTo: value)
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        return null; // Codes match
      } else {
        return 'Incorrect security code';
      }
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password can\'t be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
    return 'Password must contain at least one digit';
  }
  return null;
}

String? confirmPassValidator(String? value, String? originalPassword) {
  if (value == null || value.isEmpty) {
    return 'confirm your password';
  } else if (value != originalPassword) {
    return 'password does not match';
  } else {
    return null;
  }
}

String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter the  name';
  } else if (value.trim().length < 2) {
    return 'Name must be at least 2 characters long';
  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Name can only contain letters and spaces';
  } else if (value.length > 50) {
    return 'Name cannot be longer than 50 characters';
  }
  return null;
}

String? validateVideoLink(String? value) {
  //returns null to make it not manditory
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  const urlPattern =
      r'^(http(s)?:\/\/)?(www\.)?([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,6}\/?[a-zA-Z0-9#?&=_-]+$';
  final regex = RegExp(urlPattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid URL';
  }
  final videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'webm'];
  final isVideoLink =
      videoExtensions.any((ext) => value.toLowerCase().endsWith(ext));
  final isStreamingPlatform = value.contains('youtube.com') ||
      value.contains('vimeo.com') ||
      value.contains('youtu.be') ||
      value.contains('dailymotion.com');

  if (!isVideoLink && !isStreamingPlatform) {
    return 'Please enter a valid video link (e.g., .mp4, .mov, or a YouTube/Vimeo link)';
  }
  return null;
}

String? validate(String? value, String? errorMessage) {
  if (value == null || value.trim().isEmpty) {
    return errorMessage;
  } else {
    return null;
  }
}

String? validateDate(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter the release date';
  }
  // Regular expression to match the date format dd-MM-yyyy

  final RegExp dateRegExp = RegExp(
    r'^([0-2][0-9]|(3)[0-1])/((0)[0-9]|(1)[0-2])/\d{4}$',
  );

  if (!dateRegExp.hasMatch(value)) {
    return 'Enter a valid date in\n dd-MM-yyyy format';
  }

  // Split the date into day, month, and year
  final parts = value.split('/');
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);

  // Additional checks for days per month
  if (month == 2) {
    // Check for leap year
    final isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    if (day > (isLeapYear ? 29 : 28)) {
      return 'February can have up to ${isLeapYear ? 29 : 28} days';
    }
  } else if ([4, 6, 9, 11].contains(month)) {
    if (day > 30) {
      return ' have only 30 days';
    }
  }

  return null;
}

String? validateDuration(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the duration\n of movie';
  }
  final RegExp durationRegExp = RegExp(
    r'^([0-9]|[0-1][0-9]|2[0-3]):[0-5][0-9]$',
  );

  if (!durationRegExp.hasMatch(value)) {
    return 'Enter a valid duration in hh:mm format';
  }

  final parts = value.split(':');
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);

  if (hours < 0 || hours > 23) {
    return 'Hours should be between 00 and 23';
  }

  if (minutes < 0 || minutes > 59) {
    return 'Minutes should be between 00 and 59';
  }

  return null;
}
