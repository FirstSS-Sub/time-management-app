import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_app/entity/models.dart';
import 'package:time_management_app/entity/type_bloc.dart';
import 'package:time_management_app/register.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DTypeBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム"), // <- (※2)
      ),
      body: StreamBuilder<List<DType>>(
        stream: _bloc.typeStream,
        builder: (BuildContext context, AsyncSnapshot<List<DType>> snapshot) {
          if (snapshot.data.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                DType typeList = snapshot.data[index];
                debugPrint("$index");
                return Card(
                  child: ListTile(
                    //leading: Icon(Icons.list),
                    title: Text("${typeList.name}"),
                    subtitle: Text('sub_'+index.toString()),
                    trailing: Icon(Icons.edit),
                  ),
                );
              }
            );
          }else{
            return Center(child: Text("作業が登録されていません"),);
          }
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        // tooltip: 'Next',
        // child: Icon(Icons.arrow_right),
        label: Text('Add'),
        icon: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Register()
          )
        ),
      ),
    );
  }
}