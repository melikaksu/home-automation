import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/shared/funtions/get_total_outgoing.dart';

 getListLength(List<Outgoing> list){
 List<String> type=["Seyahat","Sağlık","Alışveriş"];  
 int length=0;
  for( int i=0;i<list.length;i++){

    if(list[i].outgoingdType=="Seyahat"){
      
      print(getTotalOutgoing(list)); }
  }
  return length;

}