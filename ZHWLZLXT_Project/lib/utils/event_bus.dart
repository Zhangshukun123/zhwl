import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

import '../entity/user_entity.dart';

EventBus eventBus = EventBus();

Map<TreatmentType, User> userMap = {};

TabController? tabController;


bool? electrotherapyIsRunIng = false;


String unltrasonicPw = "1";
