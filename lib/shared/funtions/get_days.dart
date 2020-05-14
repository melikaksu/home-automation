 getMonday(DateTime now){
     while (now.weekday != 1) {
      now = now.subtract(Duration(days: 1));
    }
 }

 getSunday(DateTime now){
     while (now.weekday != 7) {
      now = now.add(Duration(days: 1));
    }
 
 }