import 'package:flutter/material.dart';
import 'package:crypto_id/components/screen_title.dart';
import 'package:crypto_id/controllers/other_keys_controller.dart';
import '../../components/sign_list_item.dart';
import '../../data/styles.dart';

class SignaturesList extends StatefulWidget {
  const SignaturesList({super.key, required this.changePageCallback});

  final Function(int) changePageCallback;

  @override
  State<SignaturesList> createState() => _SignaturesListState();
}

class _SignaturesListState extends State<SignaturesList> {
  var columnWidgets = <Widget>[];
  var otherKeysHelper = OtherKeysHelper();
  Future<void>? _future;

  void deleteKey(int id) async {
    await otherKeysHelper.deleteItem(id);
    _future = getOtherKeys();
    setState(() {});
  }

  Future<void> getOtherKeys() async {
    List<Map<String, dynamic>> aux;
    try {
      aux = await otherKeysHelper.getAllItems();
    } catch (e) {
      _buildErrorUI();
      return;
    }

    _buildSignaturesList(aux);
  }

  void _buildErrorUI() {
    columnWidgets = [
      const ScreenTitle(title: "Assinaturas"),
      _buildAddButton(),
      const SizedBox(height: 15),
    ];
  }

  void _buildSignaturesList(List<Map<String, dynamic>> aux) {
    columnWidgets = [
      const ScreenTitle(title: "Assinaturas"),
      _buildAddButton(),
      const SizedBox(height: 15),
    ];

    for (var element in aux) {
      columnWidgets.add(
        SignListItem(people: OtherKeys.fromMap(element), deleteCallback: deleteKey),
      );
      columnWidgets.add(const SizedBox(height: 15));
    }
  }

  Widget _buildAddButton() {
    return TextButton(
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(257, 32)),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
        foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
      onPressed: () {
        widget.changePageCallback(1);
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children:  [
          Icon(Icons.add),
          SizedBox(width: 8),
          Text('Adicionar assinatura', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _future = getOtherKeys();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
      child: FutureBuilder(
        future: _future,
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _buildLoadingUI();
            default:
              return Column(children: columnWidgets);
          }
        }),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Column(
      children: [
        const ScreenTitle(title: "Assinaturas"),
        _buildAddButton(),
        const SizedBox(height: 300),
        const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
