import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:provider/provider.dart';

class  AllOutgoing extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Outgoing> _outgoing=Provider.of<List<Outgoing>>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 480,
            child: ListView.builder(
                  itemCount: _outgoing.length,
                  itemBuilder: (BuildContext contex, int index) {
                    return containerWitgetofOutgoing(
                    context: context, index: index, list: _outgoing );
                  },
                )
           ),
        ],
      ),
    );
  }
}
