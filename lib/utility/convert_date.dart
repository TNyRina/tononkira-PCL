class ConvertDate {
  DateTime datetime;

  final _mounthName = [
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

  String fullFormatFR() {
    String dateString = _getDateString(datetime);
    List date = dateString.split('-');
    String mounth = _getMounthName(int.parse(date[1]));
    
    return '${date[2]} $mounth ${date[0]}';
  }

  String _getDateString(DateTime date) {
    String dateString = datetime.toString();

    return (dateString.split(' '))[0];
  }

  String _getMounthName(int i) {
    return _mounthName[i - 1];
  }
}
