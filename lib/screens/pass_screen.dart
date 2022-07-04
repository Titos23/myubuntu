import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/models.dart';
import 'empty_pass_screen.dart';
import '../components/pass_tile.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Sold Pass')),
        actions: [
          Padding (
            padding: EdgeInsets.only(right: 20),child: 
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  final maanager = Provider.of<AppStateManager>(context, listen: false);
                  maanager.signout();
                },
              ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<PassManager>(context, listen: false);
          manager.createNewItem();
        },
      ),
      body: buildpassScreen(),
    );
  }

  Widget buildpassScreen() {
    return Consumer<PassManager>(
      builder: (context, manager, child) {
          return FutureBuilder(
            future: manager.getItems(),
            builder: (context, AsyncSnapshot<List<PassItem>> snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if(snapshot.data?.length == 0) {
                  return EmptyPassScreen();
                }
                if (snapshot.data?.length != null){
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          return PassTile(
                            key: Key(item.id),
                            item: item);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16.0);
                        },
                      ),
                    );
                }           
              } 
              
              
              return EmptyPassScreen();
              
  }
            
          );
      },
    );
  }
}
