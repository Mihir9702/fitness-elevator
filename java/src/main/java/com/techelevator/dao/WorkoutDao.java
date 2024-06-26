package com.techelevator.dao;

import com.techelevator.model.Workout;
import java.util.List;

public interface WorkoutDao {
  void startWorkout(int userId);
  void endWorkout(int userId);
  List<Workout> getWorkouts(int userId);
  Workout getCurrentWorkout(int userId);
}
