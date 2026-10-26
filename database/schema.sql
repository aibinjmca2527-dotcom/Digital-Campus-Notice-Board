-- ============================================================
-- Database Creation Script for Digital Campus Notice Board
-- Project: College Notice Board Management System
-- Authors: Jeeval Jolly Jacob & Aibin Joseph
-- ============================================================

CREATE DATABASE IF NOT EXISTS `college_notice_board` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `college_notice_board`;

-- ------------------------------------------------------------
-- Table: users
-- Description: Stores registered student and user account records
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `notices`;
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(20) DEFAULT NULL,
    `department` VARCHAR(100) DEFAULT NULL,
    `role` VARCHAR(20) NOT NULL DEFAULT 'student',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_users_email` (`email`),
    INDEX `idx_users_role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- Table: admin
-- Description: Dedicated administrative portal accounts
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_admin_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- Table: notices
-- Description: Stores notices, announcements, events, and articles
-- ------------------------------------------------------------
CREATE TABLE `notices` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `category` VARCHAR(50) NOT NULL, -- 'event', 'announcement', 'article'
    `status` VARCHAR(20) NOT NULL DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
    `user_id` INT NOT NULL,
    `author_name` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `reviewed_at` TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT `fk_notices_user` FOREIGN KEY (`user_id`) 
        REFERENCES `users` (`id`) ON DELETE CASCADE,
    INDEX `idx_notices_status` (`status`),
    INDEX `idx_notices_category` (`category`),
    INDEX `idx_notices_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- SEED DATA FOR DEMO & TESTING
-- ============================================================

-- Default Administrator
-- Login: admin@college.edu / admin123
INSERT INTO `admin` (`full_name`, `email`, `password`) VALUES
('Chief Administrator', 'admin@college.edu', 'admin123');

-- Demo Student Users
-- Passwords: student123
INSERT INTO `users` (`full_name`, `email`, `password`, `phone`, `department`, `role`) VALUES
('Aibin Joseph', 'aibin@college.edu', 'student123', '+91 9876543210', 'Computer Applications', 'student'),
('Jeeval Jolly Jacob', 'jeeval@college.edu', 'student123', '+91 9876543211', 'Computer Science & Engineering', 'student'),
('Sarah Smith', 'sarah.smith@college.edu', 'student123', '+91 9876543212', 'Information Technology', 'student');

-- Sample Notices (Approved, Pending, and Rejected)
INSERT INTO `notices` (`title`, `description`, `category`, `status`, `user_id`, `author_name`, `created_at`, `reviewed_at`) VALUES
(
    'Annual Tech Fest 2026: CodeStorm Hackathon',
    'Join us for the 24-hour National Level Hackathon with prizes worth INR 1,00,000. Themes include AI/ML, Web3, and Green Computing. Open to all engineering and MCA students. Register before Friday at the college auditorium.',
    'event',
    'approved',
    1,
    'Aibin Joseph',
    NOW() - INTERVAL 2 DAY,
    NOW() - INTERVAL 1 DAY
),
(
    'End Semester Examination Schedule Released',
    'The timetable for the upcoming End Semester Examinations (Even Semester 2026) has been officially published by the Controller of Examinations. Please verify your hall tickets and dates on the college portal.',
    'announcement',
    'approved',
    2,
    'Jeeval Jolly Jacob',
    NOW() - INTERVAL 1 DAY,
    NOW() - INTERVAL 12 HOUR
),
(
    'Demystifying Cloud Architecture in Modern Computing',
    'An insightful technical writeup detailing scalable microservice architectures, container orchestration with Kubernetes, and serverless computing paradigms for aspiring software architects.',
    'article',
    'approved',
    1,
    'Aibin Joseph',
    NOW() - INTERVAL 3 DAY,
    NOW() - INTERVAL 2 DAY
),
(
    'Robotics & IoT Workshop - Hands-on Session',
    'A two-day weekend hands-on workshop covering Arduino, Raspberry Pi, sensor integration, and MQTT protocols. Kits will be provided to registered teams in Lab 304.',
    'event',
    'pending',
    3,
    'Sarah Smith',
    NOW() - INTERVAL 4 HOUR,
    NULL
);
