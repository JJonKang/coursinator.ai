CREATE TABLE `users` (
  `id` integer PRIMARY KEY,
  `username` varchar(255) UNIQUE,
  `password_hash` varchar(255),
  `email` varchar(255) UNIQUE,
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `user_settings` (
  `id` integer PRIMARY KEY,
  `user_id` integer,
  `school` varchar(255),
  `major` varchar(255),
  `minor` varchar(255),
  `preferences` json,
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `courses` (
  `id` integer PRIMARY KEY,
  `course_code` varchar(255),
  `course_name` varchar(255),
  `description` text,
  `credits` integer,
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `classes` (
  `id` integer PRIMARY KEY,
  `course_id` integer,
  `instructor_id` integer,
  `semester` varchar(255),
  `schedule` json,
  `location` varchar(255),
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `instructors` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `email` varchar(255),
  `department` varchar(255),
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `user_classes` (
  `id` integer PRIMARY KEY,
  `user_id` integer,
  `class_id` integer,
  `added_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `instructor_ratings` (
  `id` integer PRIMARY KEY,
  `instructor_id` integer,
  `user_id` integer,
  `rating` float,
  `review` text,
  `sentiment_score` float,
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `instructor_statistics` (
  `id` integer PRIMARY KEY,
  `instructor_id` integer,
  `average_grade` float,
  `positive_reviews` integer,
  `negative_reviews` integer,
  `last_updated` timestamp,
  `is_active` boolean
);

CREATE TABLE `course_dependencies` (
  `id` integer PRIMARY KEY,
  `course_id` integer,
  `dependent_course_id` integer,
  `dependency_type` varchar(255),
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `degree` (
  `id` integer PRIMARY KEY,
  `degree_type` varchar(255),
  `name` varchar(255),
  `department` varchar(255),
  `description` text,
  `created_at` timestamp,
  `is_active` boolean
);

CREATE TABLE `required_courses` (
  `study_id` integer,
  `course_id` integer,
  `requirement_type` boolean,
  `is_active` boolean
);

ALTER TABLE `users` ADD FOREIGN KEY (`id`) REFERENCES `user_settings` (`user_id`);

CREATE TABLE `user_settings_degree` (
  `user_settings_major` varchar,
  `degree_name` varchar,
  PRIMARY KEY (`user_settings_major`, `degree_name`)
);

ALTER TABLE `user_settings_degree` ADD FOREIGN KEY (`user_settings_major`) REFERENCES `user_settings` (`major`);

ALTER TABLE `user_settings_degree` ADD FOREIGN KEY (`degree_name`) REFERENCES `degree` (`name`);


CREATE TABLE `user_settings_degree(1)` (
  `user_settings_minor` varchar,
  `degree_name` varchar,
  PRIMARY KEY (`user_settings_minor`, `degree_name`)
);

ALTER TABLE `user_settings_degree(1)` ADD FOREIGN KEY (`user_settings_minor`) REFERENCES `user_settings` (`minor`);

ALTER TABLE `user_settings_degree(1)` ADD FOREIGN KEY (`degree_name`) REFERENCES `degree` (`name`);


ALTER TABLE `classes` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

ALTER TABLE `classes` ADD FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`);

ALTER TABLE `user_classes` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `user_classes` ADD FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

ALTER TABLE `instructor_ratings` ADD FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`);

ALTER TABLE `instructor_ratings` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `instructor_statistics` ADD FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`);

ALTER TABLE `course_dependencies` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

ALTER TABLE `course_dependencies` ADD FOREIGN KEY (`dependent_course_id`) REFERENCES `courses` (`id`);

ALTER TABLE `required_courses` ADD FOREIGN KEY (`study_id`) REFERENCES `degree` (`id`);

ALTER TABLE `required_courses` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);
