import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TutorialModal extends StatelessWidget {
  final Widget child;
  final bool highlight;
  const TutorialModal({super.key, required this.child, required this.highlight});

  Widget decideWhichWidget() {
    if (highlight) {
      return GestureDetector(
        onTap: () {
          // Não faz nada quando toca no fundo escuro
        },
        child: Stack(
          children: [
            // Elemento do tutorial (tornando apenas ele interativo)
            child,
          ],
        ),
      );
    } else {
      return Stack(
          children: [
            // Elemento do tutorial (tornando apenas ele interativo)
            child,
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: decideWhichWidget()
    );
  }
}

/*Classe criada para colocar nos elementos que terão um tutorial*/
class TutorialStep extends StatefulWidget {
  final Widget child;
  final String message;
  final bool highlight;
  final double boxHeight;
  final double boxWidth;
  final double heightText;
  final double padding;
  final double leftText;

  const TutorialStep({
    super.key,
    required this.child,
    required this.message,
    required this.boxWidth,
    required this.boxHeight,
    this.highlight = false,
    this.heightText = -35,
    this.padding = 0,
    this.leftText = 0
  });

  @override
  State<TutorialStep> createState() => _TutorialStepState();
}

class _TutorialStepState extends State<TutorialStep> {
  bool _showStep = false;

  @override
  void initState() {
    super.initState();
    _showStep = widget
        .highlight; // Defina _showStep inicialmente com base no valor de highlight
    if (widget.highlight) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(TutorialStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.highlight != oldWidget.highlight) {
      if (widget.highlight) {
        _startAnimation();
      } else {
        setState(() {
          _showStep = false;
        });
      }
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showStep = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          if (widget.highlight) // Destaque visual se necessário
            AnimatedOpacity(
                opacity: _showStep ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  clipBehavior: Clip.none,
                  width: widget.boxWidth,
                  height: widget.boxHeight,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 5,
                    ),
                  ),
                )),
          if (widget.highlight)
            Positioned(
                top: widget.heightText,
                left: widget.leftText,
                child: AnimatedOpacity(
                  opacity: _showStep ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.red.withOpacity(0.8),
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          Container(padding: EdgeInsets.all(widget.highlight ? widget.padding : 0),child: widget.child),
        ],
    );
  }
}
