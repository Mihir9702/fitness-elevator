BEGIN TRANSACTION;
DROP TABLE IF EXISTS users,
user_profiles,
workouts,
exercises,
equipments,
workout_exercises,
schedules;
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username varchar(50) NOT NULL UNIQUE,
  password_hash varchar(200) NOT NULL,
  role varchar(50) NOT NULL
);
CREATE TABLE user_profiles (
  user_profile_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users (user_id),
  first_name varchar(50),
  last_name varchar(50),
  email varchar(200),
  profile_picture varchar(500) default '',
  goal varchar(50) not null
);
CREATE TABLE exercises (
  exercise_id SERIAL PRIMARY KEY,
  equipment_id int references equipments (equipment_id),
  exercise_name varchar(100) NOT NULL,
  exercise_duration_minutes int,
  reps int NOT NULL,
  weight NUMERIC(5, 2) NOT NULL
);
CREATE TABLE workouts (
  workout_id SERIAL PRIMARY KEY,
  start_time DATE NOT NULL,
  end_time DATE,
  user_profile_id int REFERENCES user_profiles (user_profile_id)
);
CREATE TABLE workout_exercises(
  workout_id int REFERENCES workouts (workout_id) NOT NULL,
  exercise_id int REFERENCES exercises (exercise_id) NOT NULL
);
CREATE TABLE equipments (
  equipment_id SERIAL PRIMARY KEY,
  equipment_name varchar(100),
  used_time_minutes int
);
CREATE TABLE schedules (
  schedule_id SERIAL PRIMARY KEY,
  title varchar(100) NOT NULL,
  instructor varchar(50) NOT NULL,
  description varchar (200),
  startTime time NOT NULL,
  classDate date NOT NULL,
  duration_minutes int
);
COMMIT TRANSACTION;