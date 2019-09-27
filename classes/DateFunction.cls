public class DateFunction {
     
  public static Integer Myday(Date startDate, Date endDate){
  Integer i = 0;
	DateTime startTDate = DateTime.newInstance(startDate.year(), startDate.month(), startDate.day());
      DateTime endTDate = DateTime.newInstance(endDate.year(), endDate.month(), endDate.day());
      List<DateTime> lst = new List<DateTime>();
    while (startTDate <= endTDate) {
        if (startTDate.format('E') != 'Sat' && startTDate.format('E') != 'Sun') {
            lst.add(startTDate);
            i++;
        }
        startTDate = startTDate.addDays(1);
    }
	System.debug('======' + i);System.debug('==lst====' + lst);
    return i;
}
}