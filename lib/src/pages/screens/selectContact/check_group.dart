import 'package:flutter/material.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/contact_model.dart';
import 'package:helloworld/src/pages/screens/selectContact/button_card.dart';
import 'package:helloworld/src/pages/screens/selectContact/contact_card.dart';

class CheckGroup extends StatefulWidget {
  List<ContactModel> groups = [];
  CheckGroup({Key? key, required this.groups}) : super(key: key);
  @override
  _CheckGroupState createState() => _CheckGroupState();
}

class _CheckGroupState extends State<CheckGroup> {
  List<ContactModel> groups = [];
  TextEditingController _txtController = TextEditingController();
  bool _next = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    // print(groups.length.toString());
    // print(widget.groups.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDarkGreen,
        title: Text(
          "Create Group",
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: (_next == true)
                  ? TextButton(
                      onPressed: () {},
                      child: Text(
                        "CREATE",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Column(children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text("Set name the new chat",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              SizedBox(
                width: screenHeight * 0.8,
                child: TextField(
                  // controller: _txtController,
                  onChanged: (value) {
                    if (value.length > 0) {
                      setState(() {
                        _next = true;
                      });
                    } else
                      setState(() {
                        _next = false;
                      });
                  },
                  decoration:
                      InputDecoration(hintText: "Group Name (Required)"),
                ),
              ),
            ]),
            Text("${widget.groups.length} participants"),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.groups.length,
                  itemBuilder: (context, index) => ContactCard(
                        contactModel: widget.groups[index],
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
