import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_manage_management/features/task_management/domain/entities/task.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: CachedNetworkImage(
            width: 36,
            height: 36,
            fit: BoxFit.cover,
            imageUrl:
                'https://source.unsplash.com/collection/${task.id}/200x200',
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.white,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.shade200,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const Gap(4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
