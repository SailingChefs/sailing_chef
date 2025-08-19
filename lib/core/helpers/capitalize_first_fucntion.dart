String capitalizeEachWord(String input) {
  if (input.isEmpty) {
    return input;
  }

  final words = input.split(' ');

  for (var i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
  }

  return words.join(' ');
}
