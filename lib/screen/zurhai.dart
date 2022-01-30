import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bogdzonhov/screen/cond.dart';
import 'package:bogdzonhov/screen/book.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:bogdzonhov/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Zurhai extends StatefulWidget {
  // LoginScreen({Key? key}) : super(key: key);

  @override
  State<Zurhai> createState() => _ZurhaiState();
}

class _ZurhaiState extends State<Zurhai> {
  final _formKey = GlobalKey<FormState>();
  var bday;
  var gender;
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String dropdownValue = 'One';
  bool _isLoading = false;
  final myBirtController = TextEditingController();
  String _dropDownValue = "";
  @override
  void dispose() {
    myBirtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Color(0xFFB4091E),
        leading: IconButton(
          icon: Icon(Icons.view_headline, color: Colors.black),
          onPressed: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Book()));
          },
        ),
        bottomOpacity: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(13),
          ),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[],
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    bool checkedBox = false;
    return Stack(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: totalWidth * 0.1, top: totalHeight * 0),
        child: Container(
          // color: Color.fromARGB(50, 200, 50, 20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: totalWidth * 0, top: totalHeight * 0.15),
                child: Image.asset('assets/budd.png', width: 150),
              ),
              Container(child: Text("Төрсөн өдөр")),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: totalWidth * 0, top: totalHeight * 0),
                  child: SizedBox(
                    height: 100,
                    width: totalWidth * 0.8,
                    child: TextFormField(
                      controller: myBirtController,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1911, 3, 5),
                            maxTime: DateTime(2022, 1, 7), onCancel: () {
                          //set toast message here
                          myBirtController.text = "";
                        }, onChanged: (date) {
                          var newFormat = DateFormat("yyyy-MM-dd");
                          String updatedDt = newFormat.format(date);
                          print(updatedDt);
                          myBirtController.text = updatedDt.toString();
                          print('change $date');
                        }, onConfirm: (date) {
                          var newFormat = DateFormat("yyyy-MM-dd");
                          String updatedDt = newFormat.format(date);
                          print(updatedDt);
                          myBirtController.text = updatedDt.toString();
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Төрсөн он',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Color(0xFFF8FAFB),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0xFFB4091E))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0xFFB4091E))),
                      ),
                      validator: (bdayValue) {
                        if (bdayValue!.isEmpty) {
                          return 'Please enter email';
                        }
                        bday = bdayValue;
                        return null;
                      },
                      cursorColor: Color(0xFF30C6CC),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                EdgeInsets.only(left: totalWidth * 0.1, top: totalHeight * 0.4),
            child: Container(
              margin: EdgeInsets.only(top: 30),
              // color: Color.fromARGB(50, 200, 50, 20),
              child: Column(
                children: <Widget>[
                  Container(child: Text("Хүйс нь")),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: totalWidth * 0, top: totalHeight * 0),
                      child: SizedBox(
                        height: 60,
                        width: totalWidth * 0.8,
                        child:

                            /* TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Хүйс',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Color(0xFFF8FAFB),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0xFFB4091E))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color(0xFFB4091E))),
                      ),
                      cursorColor: Color(0xFF30C6CC),
                    ),*/
                            Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xFFB4091E)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    15.0) //                 <--- border radius here
                                ),
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            hint: _dropDownValue == null
                                ? Text('Dropdown')
                                : Text(
                                    _dropDownValue,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.blue),
                            items: ['Эрэгтэй', 'Эмэгтэй'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _dropDownValue = val as String;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: totalWidth * 0.1, top: totalHeight * 0.1),
                      child: SizedBox(
                        height: 50,
                        width: totalWidth * 0.8,
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _check();
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFF6AC19),
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text('ҮЗЭХ')),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  void _check() async {
    setState(() {
      _isLoading = true;
    });

    var data = {'birthday': myBirtController.text};

    var res = await Network().checkData(data, '/lunar');

    var encodeFirst = json.encode(res.body);

    var body = json.decode(encodeFirst);
    String str = body.toString();
    final jsonData = json.decode(str);

    String newyear = "2022 -"+ jsonData['year'].toString();
    String display_name=jsonData['year_display_name'].toString();

    if (_dropDownValue == 'Эрэгтэй') {
      _dropDownValue = 'male';
    } else {
      _dropDownValue = 'female';
    }

    var dvalie = _dropDownValue;
    String ny = newyear.toString();
    var data1 = {'q': ny, 'gender': _dropDownValue};

    print("data111111111111111" + data1.toString());


    var res1=await Network().forThirdApi();



    List body1 =await json.decode(res1.body.toString());

    for(int i=0;i<body1.length;i++){

if(body1[i]["onsar"].toString()==jsonData['year'].toString()
    &&body1[i]["huis"].toString()==_dropDownValue.toString()
    ){

  print("here is your content tailbar:"+body1[i]["tailbar"].toString());


}else{
  //print("year not found in list");
}

    }




    setState(() {
      _isLoading = false;
    });
  }
}
