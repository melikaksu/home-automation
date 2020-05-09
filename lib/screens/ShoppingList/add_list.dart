import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/models/user.dart';
import 'package:homesweethome/services/list_service.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  var myChildSize = Size.zero;
  final GlobalKey _cardKey = GlobalKey();
  Size cardSize;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
  }

  getSizeAndPosition() {
    RenderBox _cardBox = _cardKey.currentContext.findRenderObject();
    cardSize = _cardBox.size;

    print(cardSize);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<MyList> myList;
    final listProvider = Provider.of<ListService>(context);

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _nameController;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(
                FontAwesomeIcons.bars,
                color: Color(0xff2d386b),
              ),
              onPressed: () => Scaffold.of(context).openDrawer());
        }),
        centerTitle: true,
        title: Text(
          '... LİSTESİ',
          style: TextStyle(
              fontFamily: "hadowsIntoLight",
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25,
              color: Color(0xff2d386b)),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.shareAlt,
                color: Color(0xff2d386b),
              ),
              onPressed: () {}),
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: listProvider.fetchProductsAsStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            myList = snapshot.data.documents
                .map<MyList>((doc) => MyList.fromMap(doc.data, doc.documentID))
                .toList();
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // separatorBuilder: (context, int index) => Divider(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(child: Text("${index + 1}")),
                          subtitle: Text(user.userUid),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Form(
                      key: _formKey,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: MeasureSize(
                              onChange: (Size size) {
                                setState(() {
                                  myChildSize = size;
                                });
                              },
                              child: ListTile(
                                key: _cardKey,
                                title: TextFormField(
                                  validator: (value) => value.isEmpty
                                      ? 'Eleman eklemediniz!'
                                      : null,
                                  controller: _nameController,
                                  showCursor: true,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    prefixIcon: Icon(FontAwesomeIcons.listAlt),
                                    hintText: 'Aklınızda ne var? ',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                          color: Colors.cyan, width: 2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Colors.cyan),
                                    ),
                                  ),
                                  onChanged: (a) {},
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            colorBrightness: Brightness.dark,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.cyan),
                                borderRadius: new BorderRadius.circular(20.0)),
                            color: Colors.greenAccent,
                            child: Text(
                              'Ekle',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

typedef void OnWidgetSizeChange(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
