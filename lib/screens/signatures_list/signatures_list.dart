import 'package:crypto_id/components/standard_screen.dart';
import 'package:flutter/material.dart';
import 'package:crypto_id/controllers/other_keys_controller.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../components/sign_list_item.dart';
import '../../data/styles.dart';

class SignaturesListPage extends StatefulWidget {
  const SignaturesListPage(
      {super.key,
      required this.changePageCallback,
      required this.isFirstTimeTutorial,

      });
  final bool isFirstTimeTutorial;
  final Function(int) changePageCallback;
  @override
  State<SignaturesListPage> createState() => _SignaturesListPageState();
}

class _SignaturesListPageState extends State<SignaturesListPage> {
  var columnWidgets = <Widget>[];
  var otherKeysHelper = OtherKeysHelper();
  Future<void>? _future;
  final _one = GlobalKey();
  final _two = GlobalKey();

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
      _buildAddButton(),
      const SizedBox(height: 15),
    ];
  }

  void _buildSignaturesList(List<Map<String, dynamic>> aux) {
    columnWidgets = [
      _buildAddButton(),
      const SizedBox(height: 15),
    ];

    for (var element in aux) {
      columnWidgets.add(
        SignListItem(
            people: OtherKeys.fromMap(element), deleteCallback: deleteKey),
      );
      columnWidgets.add(const SizedBox(height: 15));
    }
  }

  Widget _buildAddButton() {
    return Showcase(
      key: _two,
      title: "Adicionar assinaturas",
      description:
          "Clique aqui para ser redirecionado para a tela de adicionar assinaturas",
      child: Row(
        children: [
          const Spacer(),
          TextButton(
            style: ButtonStyle(
              fixedSize: const MaterialStatePropertyAll(Size(257, 32)),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary),
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
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text('Adicionar assinatura', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _future = getOtherKeys();
    if (widget.isFirstTimeTutorial) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([_one, _two]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StandardScreen(
      keys: [_one, _two],
      child: Showcase(
        targetPadding: const EdgeInsets.only(bottom: 100),
        key: _one,
        title: "Assinaturas cadastradas",
        description:
            "Aqui irão aparecer os itens para você validar a assinatura de chaves de outras pessoas que você cadastrou.",
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(36, 20, 36, 0),
          child: FutureBuilder(
            future: _future,
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return _buildLoadingUI();
                default:
                  return Column(crossAxisAlignment:CrossAxisAlignment.center,children: columnWidgets);
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.center,
      children: [
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

class SignaturesList extends StatefulWidget {
  final Function(int) changePageCallback;
  final bool isFirstTimeTutorial;
  final VoidCallback setShowTutorialCallback;


  const SignaturesList(
      {super.key,
      required this.changePageCallback,
      required this.isFirstTimeTutorial,
      required this.setShowTutorialCallback,});

  @override
  State<SignaturesList> createState() => _SignaturesListState();
}

class _SignaturesListState extends State<SignaturesList> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        onFinish: widget.setShowTutorialCallback,
        builder: Builder(builder: (context) {
          return SignaturesListPage(
            changePageCallback: widget.changePageCallback,
            isFirstTimeTutorial: widget.isFirstTimeTutorial,
          );
        }));
  }
}
