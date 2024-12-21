class SeminarDDL{
  int? _SeminarID;
  String? _SeminarTitle;

  int? get SeminarID => _SeminarID;

  set SeminarID(int? value) {
    _SeminarID = value;
  }

  String? get SeminarTitle => _SeminarTitle;

  set SeminarTitle(String? value) {
    _SeminarTitle = value;
  }
}