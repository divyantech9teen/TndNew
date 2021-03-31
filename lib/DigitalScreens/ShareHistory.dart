import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/DigitalComponent/LoadinComponent.dart';
import 'package:the_national_dawn/DigitalComponent/NoDataComponent.dart';
import 'package:the_national_dawn/DigitalComponent/ShareHistoryComponent.dart';

class ShareHistory extends StatefulWidget {
  @override
  _ShareHistoryState createState() => _ShareHistoryState();
}

class _ShareHistoryState extends State<ShareHistory> {
  List<ShareClass> shareClass = new List();
  List<ShareClass> searchShareClass = new List();
  bool _isSearching = false, isfirst = false;
  bool isLoading = true;

  TextEditingController _controller = TextEditingController();

  final globalKey = new GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text('Share History');
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  void initState() {
    _getSharedHistory();
  }

  _getSharedHistory() async {
    Future res = Services.GetShareHistory();
    res.then((data) async {
      if (data != null && data.length > 0) {
        setState(() {
          isLoading = false;
          shareClass = data;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: "Something went Wrong",
          backgroundColor: Colors.red,
          gravity: ToastGravity.TOP);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: buildAppBar(context),
        body: Container(
          margin: EdgeInsets.only(top: 7),
          height: MediaQuery.of(context).size.height,
          child: isLoading
              ? LoadinComponent()
              : shareClass.length > 0 && shareClass != null
                  ? searchShareClass.length != 0
                      ? ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: searchShareClass.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ShareHistoryComponent(
                                searchShareClass[index], index);
                          },
                        )
                      : _isSearching && isfirst
                          ? ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: searchShareClass.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ShareHistoryComponent(
                                    searchShareClass[index], index);
                              },
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: shareClass.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ShareHistoryComponent(
                                    shareClass[index], index);
                              },
                            )
                  : NoDataComponent(),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: false, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          if (this.icon.icon == Icons.search) {
            this.icon = new Icon(
              Icons.close,
              color: Colors.white,
            );
            this.appBarTitle = new TextField(
              controller: _controller,
              style: new TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search, color: Colors.white),
                  hintText: "Search...",
                  hintStyle: new TextStyle(color: Colors.white)),
              onChanged: searchOperation,
            );
            _handleSearchStart();
          } else {
            _handleSearchEnd();
          }
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Share History",
      );
      _isSearching = false;
      isfirst = false;
      searchShareClass.clear();
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchShareClass.clear();
    if (_isSearching != null) {
      isfirst = true;
      for (int i = 0; i < shareClass.length; i++) {
        String data = shareClass[i].Name;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchShareClass.add(shareClass[i]);
        }
      }
    }
    setState(() {});
  }
}
