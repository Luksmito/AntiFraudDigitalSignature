import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/components/screen_title.dart';
import 'package:todo_list/controllers/other_keys_controller.dart';
import '../data/people.dart';
import '../components/sign_list_item.dart';
import '../data/styles.dart';

class SignaturesList extends StatefulWidget {
  const SignaturesList({super.key, required this.changePageCallback});

  final Function(int) changePageCallback;

  @override
  State<SignaturesList> createState() => _SignaturesListState();
}

class _SignaturesListState extends State<SignaturesList>
    with TickerProviderStateMixin {
  var pessoas = <OtherKeys>[];
  var columnWidgets = <Widget>[];
  var otherKeysHelper = OtherKeysHelper();
  var isLoading = true;
  late AnimationController controllerCircularProgressBar;

  Future<void> getOtherKeys() async {
    var aux = await otherKeysHelper.getAllItems();
    pessoas.clear();
    columnWidgets.clear();
    columnWidgets.add(const ScreenTitle(title: "Assinaturas"));
      columnWidgets.add(
        TextButton(
          style: ButtonStyle(
              fixedSize: const MaterialStatePropertyAll(Size(257, 32)),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary)))),
          onPressed: () {
            widget.changePageCallback(1);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add), // Ícone
              const SizedBox(width: 8), // Espaço entre o ícone e o texto
              Text('Adicionar assinatura',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                  ), 
                  // Texto do botão
            ],
          ),
        ),
      );
      columnWidgets.add(const SizedBox(height: 15,));
    for (var element in aux) {
      columnWidgets.add(SignListItem(people: OtherKeys.fromMap(element)));
      columnWidgets.add(const SizedBox(
        height: 15,
      ));
    }
    //controllerCircularProgressBar.dispose();
    controllerCircularProgressBar.stop();
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    columnWidgets.clear();
    controllerCircularProgressBar = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controllerCircularProgressBar.repeat(reverse: true);
    columnWidgets.add(const ScreenTitle(title: "Assinaturas"));
    
  }

  @override
  void dispose() {
    controllerCircularProgressBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getOtherKeys();
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
      child: FutureBuilder(
        future: getOtherKeys(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Column(
                children: [
                  const ScreenTitle(title: "Assinaturas"),
                  TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)))),
                    onPressed: () {
                      widget.changePageCallback(1);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add), // Ícone
                        const SizedBox(
                            width: 8), // Espaço entre o ícone e o texto
                        Text('Adicionar assinatura',
                            style: Theme.of(context)
                      .textTheme
                      .labelMedium
                  ), // Texto do botão
                      ],
                    ),
                  ),
                  const SizedBox(height: 300),
                  Center(
                    child: CircularProgressIndicator(
                      value: controllerCircularProgressBar.value,
                      backgroundColor: Colors.grey,
                      color: primaryColor,
                    ),
                  )
                ],
              );
            case ConnectionState.none:
            default:
              return Column(children: columnWidgets);
          }
        }),
      ),
    );
  }
}
