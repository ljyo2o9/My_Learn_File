String url =
    'url';

String serviceKey =
    'service';

String pageSetting = '&pageNo=1&numOfRows=20&dataType=JSON';

String xy = '&nx=67&ny=101';

final DateTime realTime = DateTime.now();

final String date = realTime.year.toString() +
    (realTime.month >= 10 ? '' : '0') +
    realTime.month.toString() +
    (realTime.day >= 10 ? '' : '0') +
    realTime.day.toString();

final String nowHour = realTime.minute >= 30
    ? '${realTime.hour >= 10 ? '' : '0'}${realTime.hour}00'
    : '${realTime.hour - 1 >= 10 ? '' : '0'}${realTime.hour - 1}00';
