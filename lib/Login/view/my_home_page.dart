import 'package:flutter/material.dart';
import 'package:flutter_mvp/Login/Presenter/HomePresenter.dart';
import 'package:flutter_mvp/Login/Presenter/PresenterView.dart';
import 'package:flutter_mvp/Login/model/model.dart';
import 'package:flutter_mvp/Login/view/MyErrorWidget.dart';
import 'package:provider/provider.dart';

import '../services/remote/response/ApiStatus.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements PresenterView  {

  HomePresenter? _presenter;

  User? _payment;

  bool? _isLoading;

  _MyHomePageState() {
    _presenter = HomePresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter?.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    // List<Data>? users = controller.users(context);
    // bool isLoading = controller.isLoading(context); ChangeNotifierProvider
    return Scaffold(
      appBar: AppBar(
        title: Text('MVP Demo'),
      ),
      body: _isLoading == true
          ? Container(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: CircularProgressIndicator())),
         )
          :_getUsersListView(_payment?.data),
    );
  }

  Widget _getUsersListView(List<Data>? users) {
    return ListView.builder(
        itemCount: users?.length,
        itemBuilder: (context, position) {
          return _getUserListItem(users![position]);
        });
  }
  Widget _getUserListItem(Data item) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Image.network(item.avatar!),
        title: Text(
          item.firstName! + " " + item.lastName!,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        subtitle: Text(
          item.email!,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        trailing: Text('ID: ' + item.id.toString()),
      ),
    );

  }

  @override
  void showError() {
    // TODO: implement showError
    print("error occured");
    _isLoading = false;
  }

  @override
  void showListDetail(User items) {
    // TODO: implement showListDetail

    print("details: $items");
    setState(() {
      _payment = items;
      _isLoading = false;
    });
  }

}
