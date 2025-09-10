class ConvertDate {
  DateTime datetime;

  final mounthName = [
    'Janvier',
    'Fevrier',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Aougt',
    'Septembre',
    'Octobre',
    'Novembre',
    'Decembre',
  ];

  ConvertDate({required this.datetime});

  String formatFR() {
    String dateString = datetime.toString();
    dateString = (dateString.split(' '))[0];
    List date = dateString.split('-');
    String mounth = getMounthName(int.parse(date[1]));
    return '${date[2]} $mounth ${date[0]}';
  }

  String getMounthName(int i) {
    return mounthName[i - 1];
  }
}
