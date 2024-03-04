import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_manage_management/core/network/api_status_type.dart';
import 'package:task_manage_management/features/passcode/domain/cubit/passcode_cubit.dart';
import 'package:task_manage_management/features/passcode/presentation/widgets/passcode_button_widget.dart';
import 'package:task_manage_management/features/task_management/presentation/screens/task_management_screen.dart';
import 'package:task_manage_management/main_injector_container.dart';

class PasscodeScreen extends StatelessWidget {
  const PasscodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PasscodeCubit>(),
      child: BlocListener<PasscodeCubit, PasscodeState>(
        listener: (context, state) {
          if (state.checkPasscodeStatus == ApiStatusType.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const TaskManagementScreen(),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(100),
                    Text(
                      'Enter Passcode',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(42),
                    BlocBuilder<PasscodeCubit, PasscodeState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var i = 0; i < 6; i++)
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: i < state.passcode.length
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const Gap(16),
                            SizedBox(
                              height: 20,
                              child: state.error != null
                                  ? Text(
                                      'Incorrect passcode!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Colors.red,
                                          ),
                                    )
                                  : null,
                            )
                          ],
                        );
                      },
                    ),
                    const Gap(16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 262,
                      ),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 3,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          if (index == 9) {
                            return const SizedBox.shrink();
                          }
                          if (index == 10) {
                            return PasscodeButtonWidget.text(
                              context: context,
                              onTap: () =>
                                  context.read<PasscodeCubit>().enterDigit('0'),
                              text: '0',
                            );
                          }
                          if (index == 11) {
                            return PasscodeButtonWidget(
                              onTap: () =>
                                  context.read<PasscodeCubit>().deleteDigit(),
                              child: const Center(
                                child: Icon(Icons.backspace_outlined),
                              ),
                            );
                          }
                          return PasscodeButtonWidget.text(
                            context: context,
                            onTap: () => context
                                .read<PasscodeCubit>()
                                .enterDigit('${index + 1}'),
                            text: '${index + 1}',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
