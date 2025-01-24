class Functions{
  String formateDate(String date){
    date = date.split(" ")[0];
    var dt = date.split("-");
    DateTime selectedDate = DateTime(int.parse(dt[0]),
        int.parse(dt[1]), int.parse(dt[2]));
    String formattedDate =
        "${selectedDate.day.toString().padLeft(
        2, '0')}-${selectedDate.month.toString().padLeft(
        2, '0')}-${selectedDate.year}";
    return formattedDate;
  }
}