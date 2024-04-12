import 'package:crypto_id/components/screen_title.dart';
import 'package:crypto_id/controllers/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/my_keys_controller.dart';

class ManageMyKeys extends StatefulWidget {
  const ManageMyKeys({super.key});

  @override
  State<ManageMyKeys> createState() => _ManageMyKeysState();
}

class DeleteNotifier with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class MyKeyListTile extends StatelessWidget {
  
  final int id;
  final String name;
  final void Function(int) deleteCallback;

  const MyKeyListTile({super.key, required this.id, required this.name, required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 0.5),
        ),
        child: ListTile(
            tileColor: Theme.of(context).colorScheme.onSecondary,
            trailing: IconButton(
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: () async { deleteCallback(id);},
            ),
            title: Text(
              name,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            onTap: () {}),
      );
  }
}

class _ManageMyKeysState extends State<ManageMyKeys> {
  MyKeysHelper myKeysHelper = MyKeysHelper();
  List<Widget> myKeysTiles = [];

  DeleteNotifier deleteNotifier = DeleteNotifier();

  bool wasLoaded = false;

  void deleteKey (int id) async {
    DataBaseController().getTables();
    myKeysHelper.deleteItem(id);
    await takeMyKeys(context);
    deleteNotifier.notify();
  }

  Future<void> takeMyKeys(BuildContext context) async {
    var aux = await myKeysHelper.getAllItems();
    myKeysTiles.clear();
    for (var element in aux) {
      var key = MyKey().fromMap(element);
      myKeysTiles.add(MyKeyListTile(id: key.id, name: key.name, deleteCallback: deleteKey,));
    }
    wasLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!wasLoaded) takeMyKeys(context);
    return Hero(
      tag: 'Administrar minhas chaves',
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 0.5),
          ),
          child: ListTile(
            title: Text(
              'Administrar minhas chaves',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            subtitle: Text(
              'Aperte aqui para excluir chaves',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            tileColor: Theme.of(context).colorScheme.onSecondary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Scaffold(
                        backgroundColor: Theme.of(context).colorScheme.onSecondary,
                        appBar: AppBar(
                          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
                            backgroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            title: const ScreenTitle(title: 'Administrar chaves')),
                        body: ListenableBuilder(
                          listenable: deleteNotifier,
                          builder: (context, snapshot) {
                            return Column(
                              children: myKeysTiles,
                            );
                          }
                        ),
                      ),
                  );
                  
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
