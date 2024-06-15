import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/helper/local_data.dart';
import '../models/mission_model.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  Future<List<TaskModel>> fetchTasks() async {
    try {
      return List<TaskModel>.from((await _store
              .collection('tasks')
              .where('userId', isEqualTo: currentUser.id)
              .get())
          .docs
          .map((e) => TaskModel.fromJson(e.data())));
    } catch (e) {
      throw e;
    }
  }

  Future<void> addTask(Map<String, dynamic> data) async {
    try {
      final id = _store.collection('tasks').doc().id;
      data['id'] = id;
      await _store.collection('tasks').doc(id).set(data);
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _store.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<void> editTask(Map<String, dynamic> data) async {
    try {
      await _store.collection('tasks').doc(data['id']).update(data);
    } catch (e) {
      throw e;
    }
  }

  Future<void> addMission(Map<String, dynamic> data) async {
    try {
      data['id'] = _store.collection('missions').doc().id;
      final task = TaskModel.fromJson(
          (await _store.collection('tasks').doc(data['taskId']).get()).data()!);
      task.missions.add(data['id']);
      await _store
          .collection('tasks')
          .doc(data['taskId'])
          .update(task.toJson())
          .then((value) async {
        await _store.collection('missions').doc(data['id']).set(data);
      });
    } catch (e) {
      log('this test: $e');
    }
  }

  Future<List<MissionModel>> fetchMissions(List<String> missionsIds) async {
    final data = await _store
        .collection('missions')
        .where('id', whereIn: missionsIds)
        .get();

    return List<MissionModel>.from(
        data.docs.map((e) => MissionModel.fromJson(e.data())));
  }
}
