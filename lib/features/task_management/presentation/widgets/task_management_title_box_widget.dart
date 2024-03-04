import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TaskManagementTitleBoxWidget extends StatelessWidget {
  const TaskManagementTitleBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(60),
                Text(
                  'Hi! User',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(4),
                Text(
                  'What are you going to do today?',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(48),
              ],
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }
}
