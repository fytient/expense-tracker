String convertDateToString(DateTime dateTime) {
  
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();
  String yyyyMMdd = year + month + day;
  return yyyyMMdd;
}
