String formatTimeDifference(String timestampString) {
  // Convert the timestamp string to a DateTime object
  DateTime timestamp =
      DateTime.fromMillisecondsSinceEpoch(int.parse(timestampString));

  // Get the current time
  DateTime now = DateTime.now();

  // Calculate the difference between the current time and the timestamp
  Duration difference = now.difference(timestamp);

  // Convert the difference into a human-readable format
  if (difference.inSeconds < 60) {
    return 'a few seconds ago';
  } else if (difference.inMinutes == 1) {
    return 'a minute ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours == 1) {
    return 'an hour ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays == 1) {
    return 'a day ago';
  } else {
    return '${difference.inDays} days ago';
  }
}
