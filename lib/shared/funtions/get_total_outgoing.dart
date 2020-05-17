import 'package:homesweethome/models/outgoing.dart';

int getTotalOutgoing(List<Outgoing> list){

int totalOutgoing=0;   

for(var i=0;i<list.length;i++){
totalOutgoing = totalOutgoing+ list[i].outgoingQuan;
}

return totalOutgoing;

}