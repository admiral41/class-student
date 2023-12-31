import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/common/snackbar/my_snackbar.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/presentation/view_model/course_view_model.dart';

class AddCourseView extends ConsumerWidget {
  AddCourseView({super.key});

  final gap = const SizedBox(height: 8);
  final courseController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseState = ref.watch(courseViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (courseState.showMessage) {
        showSnackBar(message: 'Course Added', context: context);
        ref.read(courseViewModelProvider.notifier).resetMessage(false);
      }
    });

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Add Course',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            TextFormField(
              controller: courseController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Course Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter course';
                }
                return null;
              },
            ),
            gap,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  CourseEntity course =
                      CourseEntity(courseName: courseController.text);
                  ref.read(courseViewModelProvider.notifier).addCourse(course);
                },
                child: const Text('Add Course'),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List of Courses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            courseState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: courseState.courses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            courseState.courses[index].courseName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            courseState.courses[index].courseId ?? 'No id',
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 12,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // ref
                              //     .read(batchViewModelProvider.notifier)
                              //     .deleteBatch(
                              //         batchState.batches[index].batchId);
                            },
                          ),
                        );
                      },
                    ),
                  ),
            // batchState.showMessage
            //     ? showSnackBar(message: 'Batch Added', context: context)
            //     : Container(),
          ],
        ),
      ),
    );
  }
}
