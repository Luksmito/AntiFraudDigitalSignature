
class TutorialFlow {
  final int nSteps;
  List<bool> tutorialSteps = [];
  int actualStep = 0;

  TutorialFlow({required this.nSteps}) : 
    tutorialSteps = List.generate(nSteps, (index) => index == 0);
  
  void nextStep() {
      tutorialSteps[actualStep] = false;
      if (actualStep != nSteps-1) tutorialSteps[actualStep + 1] = true;
      actualStep++;
  }
}