import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../ui/pages/surveys/surveys.dart';

class SurveyItem extends StatelessWidget {
  final SurveyViewModel viewModel;

  const SurveyItem(this.viewModel);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2,
                color: Colors.black,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '22 Fev 2021',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                viewModel.question,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SurveyViewModel>('viewModel', viewModel));
  }
}
