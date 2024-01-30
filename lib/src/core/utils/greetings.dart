import 'dart:math';

String getGreeting() {
  Map<String, List<String>> greetings = {
    'morning': [
      '¡Buenos días! 🌞',
      'Good morning! ☀️',
      'Bonjour! 🌅',
      'Rise and shine! 🌄',
      'Top of the morning to you! 🌤️',
      'Guten Morgen! 🌼',
      'Morning sunshine! 🌅',
      'Wakey, wakey! ☕',
      'Hello, world! 🌞',
      'Buongiorno! 🌤️',
    ],
    'afternoon': [
      '¡Buenas tardes! 🌇',
      'Good afternoon! 🌅',
      'Bonjour! 🌆',
      'Afternoon delight! 🌞',
      'Hola, buenas tardes! 🌄',
      'Guten Tag! 🌻',
      "Sun's still shining! 🌤️",
      'Hey there, good lookin\'! 😊',
      'Buenas! 🌅',
      'Ciao! 🌇',
    ],
    'night': [
      '¡Buenas noches! 🌙',
      'Good night! 🌌',
      'Bonne nuit! 🌠',
      'Sweet dreams! 🌜',
      'Nighty night! 🌃',
      'Gute Nacht! 🌌',
      'Sleep tight! 🌙',
      'Buonanotte! 🌃',
      'Stars shining bright! ✨',
      'See you in the morning! 🌙',
    ],
    'original': [
      'Hola, ¿cómo estás hoy?',
      'Que tengas un día lleno de alegría.',
      'Sonríe, es un nuevo día.',
      'Que tu día esté lleno de éxitos.',
      '¡La vida es hermosa!',
      'Disfruta cada momento.',
      'Eres increíble, no lo olvides.',
      'Sé agradecido por hoy.',
      'Haz que hoy cuente.',
      'La felicidad está en las pequeñas cosas.',
    ],
    'cute': [
      '¡Tienes una sonrisa adorable!',
      'Eres más dulce que un pastelito.',
      'Tu bondad ilumina mi día.',
      'Eres tan especial como un arcoíris.',
      'Tus ojos brillan como estrellas.',
      'Eres el sol de mi día.',
      'Eres mi rayo de sol.',
      'Tu alegría es contagiosa.',
      'Eres tan lindo/a como un peluche.',
      'Tus abrazos son como magia.',
    ],
  };

  String timeOfDay = _getTimeOfDay();
  String category = _getRandomCategory();

  List<String> selectedGreetings = greetings[timeOfDay] ?? [];
  selectedGreetings.addAll(greetings[category] ?? []);

  if (selectedGreetings.isNotEmpty) {
    return selectedGreetings[Random().nextInt(selectedGreetings.length)];
  } else {
    return '¡Hola!';
  }
}

String _getTimeOfDay() {
  // Obtener la hora actual
  DateTime now = DateTime.now();

  // Determinar la parte del día
  if (now.hour >= 6 && now.hour < 12) {
    return 'morning';
  } else if (now.hour >= 12 && now.hour < 18) {
    return 'afternoon';
  } else {
    return 'night';
  }
}

String _getRandomCategory() {
  // Devolver 'original' o 'cute' al azar
  return Random().nextBool() ? 'original' : 'cute';
}
