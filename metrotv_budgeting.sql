-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2025 at 08:01 AM
-- Server version: 10.4.22-MariaDB-log
-- PHP Version: 8.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `metrotv_budgeting`
--

-- --------------------------------------------------------

--
-- Table structure for table `budgets`
--

CREATE TABLE `budgets` (
  `id_budget` int(11) NOT NULL,
  `budget_name` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `periode_from` date DEFAULT NULL,
  `periode_to` date DEFAULT NULL,
  `pic` varchar(100) DEFAULT NULL,
  `dept` varchar(100) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `rejection_reason` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `budgets`
--

INSERT INTO `budgets` (`id_budget`, `budget_name`, `description`, `periode_from`, `periode_to`, `pic`, `dept`, `template_id`, `status`, `rejection_reason`, `created_by`, `created_at`, `updated_at`) VALUES
(16, 'Duit', 'MBG', '2025-10-07', '2025-10-31', NULL, 'Keuangan', 26, 'Approved', NULL, 1, '2025-10-07 00:34:01', '2025-10-07 00:41:41'),
(20, 'outdoor bansos', 'Pembagian bansos', '2025-11-01', '2025-11-08', NULL, 'Media Service', 30, 'Approved', NULL, 1, '2025-10-15 23:51:41', '2025-10-15 23:54:28'),
(22, 'Budget Mangan', 'mangannn', '2025-10-20', '2025-10-25', NULL, 'Makanan', 28, 'Approved', NULL, 3, '2025-10-19 20:58:21', '2025-10-26 23:18:36'),
(24, 'budget', 'budget', '2025-10-27', '2025-10-27', NULL, 'budget', 32, 'Approved', 'tolak', 1, '2025-10-27 00:42:11', '2025-10-27 01:05:56'),
(27, 'template', 'descs', '2025-10-01', '2025-10-02', NULL, 'depart', 32, 'Rejected', 'c', 1, '2025-10-27 02:09:27', '2025-10-27 02:44:02'),
(28, 'metro this week october', 'metro this week minggu ke 4', '2025-10-27', '2025-10-31', NULL, 'produksi', 33, 'Pending', NULL, 1, '2025-10-27 02:40:56', '2025-10-27 02:41:53');

-- --------------------------------------------------------

--
-- Table structure for table `budget_approvals`
--

CREATE TABLE `budget_approvals` (
  `id_approval` int(11) NOT NULL,
  `budget_id` int(11) NOT NULL,
  `approved_by` int(11) NOT NULL,
  `status` enum('Pending','Approved','Rejected','SendBack') DEFAULT 'Pending',
  `comment` text DEFAULT NULL,
  `approved_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `budget_approvals`
--

INSERT INTO `budget_approvals` (`id_approval`, `budget_id`, `approved_by`, `status`, `comment`, `approved_at`) VALUES
(1, 1, 1, 'Approved', 'Budget telah disetujui sesuai proposal', '2025-08-01 01:48:12'),
(2, 2, 1, 'Pending', NULL, '2025-08-04 01:48:12'),
(3, 3, 1, 'Approved', 'Disetujui dengan revisi minor', '2025-07-27 01:48:12'),
(4, 4, 1, 'Pending', NULL, '2025-08-05 01:48:12'),
(5, 5, 1, 'SendBack', 'Perlu revisi pada item catering', '2025-08-03 01:48:12'),
(6, 6, 1, 'Approved', 'Budget disetujui penuh', '2025-07-30 01:48:12');

-- --------------------------------------------------------

--
-- Table structure for table `budget_items`
--

CREATE TABLE `budget_items` (
  `id_budget_item` int(11) NOT NULL,
  `budget_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(150) DEFAULT NULL,
  `short_desc` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `unit_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `unit` varchar(50) DEFAULT NULL,
  `top_price` decimal(15,2) DEFAULT NULL,
  `bottom_price` decimal(15,2) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `budget_items`
--

INSERT INTO `budget_items` (`id_budget_item`, `budget_id`, `item_id`, `item_name`, `short_desc`, `qty`, `unit_price`, `unit`, `top_price`, `bottom_price`, `amount`, `created_at`, `updated_at`) VALUES
(13, 16, 3, 'Catering', 'Konsumsi untuk crew dan talent', 2, '10000000.00', 'Box', '10000000.00', '10000000.00', '20000000.00', '2025-10-07 07:34:01', '2025-10-07 07:34:01'),
(14, 16, 6, 'transportasi', 'ongkos kru harian', 1, '60000000.00', 'Hari', '60000000.00', '60000000.00', '60000000.00', '2025-10-07 07:34:01', '2025-10-07 07:34:01'),
(15, 16, 5, 'Venue Rental', 'Sewa venue untuk acara', 1, '3000000000.00', 'Hari', '3000000000.00', '3000000000.00', '3000000000.00', '2025-10-07 07:34:02', '2025-10-07 07:34:02'),
(16, 20, 3, 'Catering', 'Konsumsi untuk crew dan talent', 3, '10000000.00', 'Box', '10000000.00', '10000000.00', '30000000.00', '2025-10-16 06:51:42', '2025-10-16 06:51:42'),
(17, 20, 8, 'Pemasangan Panggung', 'Jasa dan material', 1, '6000000.00', 'Paket', '6000000.00', '6000000.00', '6000000.00', '2025-10-16 06:51:42', '2025-10-16 06:51:42'),
(18, 20, 1, 'Sound System', 'Audio equipment untuk acara', 1, '800000000.00', 'Paket', '800000000.00', '800000000.00', '800000000.00', '2025-10-16 06:51:42', '2025-10-16 06:51:42'),
(19, 20, 5, 'Venue Rental', 'Sewa venue untuk acara', 1, '3000000000.00', 'Hari', '3000000000.00', '3000000000.00', '3000000000.00', '2025-10-16 06:51:42', '2025-10-16 06:51:42'),
(20, 20, 2, 'Lighting Equipment', 'Peralatan pencahayaan panggung', 1, '600000000.00', 'Paket', '600000000.00', '600000000.00', '600000000.00', '2025-10-16 06:51:42', '2025-10-16 06:51:42'),
(21, 22, 5, 'Venue Rental', 'Sewa venue untuk acara', 1, '3000000000.00', 'Hari', '3000000000.00', '3000000000.00', '3000000000.00', '2025-10-20 03:58:21', '2025-10-20 03:58:21'),
(22, 22, 3, 'Catering', 'Konsumsi untuk crew dan talent', 1, '10000000.00', 'Box', '10000000.00', '10000000.00', '10000000.00', '2025-10-20 03:58:21', '2025-10-20 03:58:21'),
(27, 24, 10, 'item', 'item', 10, '123123123.00', '1', '123123123.00', '123123123.00', '1231231230.00', '2025-10-27 07:42:11', '2025-10-27 07:42:11'),
(28, 24, 9, 'Tes', 'tes', 2, '200.00', 'tes', '200.00', '200.00', '400.00', '2025-10-27 07:42:12', '2025-10-27 07:42:12'),
(33, 27, 10, 'item', 'item', 10, '123123123.00', '1', '123123123.00', '123123123.00', '1231231230.00', '2025-10-27 09:09:28', '2025-10-27 09:09:28'),
(34, 27, 9, 'Tes', 'tes', 2, '200.00', 'tes', '200.00', '200.00', '400.00', '2025-10-27 09:09:28', '2025-10-27 09:09:28'),
(35, 27, 5, 'Venue Rental', 'Sewa venue', 1, '200000000.00', 'Hari', '200000000.00', '150000000.00', '200000000.00', '2025-10-27 09:10:06', '2025-10-27 09:10:06'),
(36, 28, 11, 'narasumber', 'narasumber', 1, '2500000.00', 'Paket', '2500000.00', '2500000.00', '2500000.00', '2025-10-27 09:40:56', '2025-10-27 09:40:56'),
(37, 28, 2, 'Lighting Equipment', 'Peralatan pencahayaan panggung', 1, '600000000.00', 'Paket', '600000000.00', '600000000.00', '600000000.00', '2025-10-27 09:40:56', '2025-10-27 09:40:56'),
(38, 28, 6, 'transportasi', 'ongkos kru harian', 1, '60000000.00', 'Hari', '60000000.00', '60000000.00', '60000000.00', '2025-10-27 09:40:56', '2025-10-27 09:40:56'),
(39, 28, 3, 'Catering', 'Konsumsi untuk crew dan talent', 50, '10000000.00', 'Box', '10000000.00', '5000000.00', '500000000.00', '2025-10-27 09:41:24', '2025-10-27 09:41:31'),
(40, 28, 1, 'Sound System', 'Audio equipment untuk acara', 1, '800000000.00', 'Paket', '800000000.00', '500000000.00', '800000000.00', '2025-10-27 09:41:46', '2025-10-27 09:41:46');

-- --------------------------------------------------------

--
-- Table structure for table `event_programs`
--

CREATE TABLE `event_programs` (
  `id_event_program` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(20) NOT NULL,
  `pic_user_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `event_programs`
--

INSERT INTO `event_programs` (`id_event_program`, `name`, `category`, `pic_user_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Bansosss', 'On Air', 3, 'duit buat pinjoll', '2025-08-26 23:48:15', '2025-10-19 21:36:36'),
(2, 'tes', 'Off Air', 1, 'p', '2025-09-07 23:38:20', '2025-09-08 02:38:20'),
(3, 'mbg', 'On Air', 2, 'mangan', '2025-09-08 00:27:10', '2025-09-08 00:41:42'),
(4, 'webinar', 'On Air', 2, 'online seminar', '2025-09-24 23:44:35', '2025-09-24 23:44:35'),
(10, 'program', 'Off Air', 2, 'event', '2025-10-17 00:43:10', '2025-10-17 00:43:10'),
(11, 'program', 'On Air', 7, 'program', '2025-10-27 00:20:03', '2025-10-27 00:20:03'),
(12, 'metro this week', 'Off Air', 2, 'metro this week', '2025-10-27 02:38:41', '2025-10-27 02:38:41');

-- --------------------------------------------------------

--
-- Table structure for table `master_items`
--

CREATE TABLE `master_items` (
  `id_item` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bottom_price` decimal(15,2) DEFAULT NULL,
  `top_price` decimal(15,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_items`
--

INSERT INTO `master_items` (`id_item`, `item_name`, `unit_id`, `bottom_price`, `top_price`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Sound System', 2, '500000000.00', '800000000.00', 'Audio equipment untuk acara', '2025-08-19 07:08:04', '2025-09-16 16:38:06'),
(2, 'Lighting Equipment', 2, '300000000.00', '600000000.00', 'Peralatan pencahayaan panggung', '2025-08-19 07:08:04', '2025-09-16 16:38:00'),
(3, 'Catering', 3, '5000000.00', '10000000.00', 'Konsumsi untuk crew dan talent', '2025-08-19 07:08:04', '2025-09-16 16:37:27'),
(5, 'Venue Rental', 1, '150000000.00', '200000000.00', 'Sewa venue', '2025-08-19 07:08:04', '2025-10-16 02:31:53'),
(6, 'transportasi', 1, '30000000.00', '60000000.00', 'ongkos kru harian', '2025-08-19 00:24:35', '2025-10-16 02:42:24'),
(8, 'Pemasangan Panggung', 2, '5000000.00', '6000000.00', 'Jasa dan material', '2025-10-15 23:47:00', '2025-10-15 23:47:00'),
(9, 'Tes', 4, '100.00', '200.00', 'tes', '2025-10-17 02:00:41', '2025-10-17 10:20:26'),
(10, 'item', 5, '123123123.00', '123123123.00', 'item', '2025-10-27 00:19:14', '2025-10-27 00:19:14'),
(11, 'narasumber', 2, '2000000.00', '2500000.00', 'narasumber', '2025-10-27 02:38:04', '2025-10-27 02:38:04');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_08_06_093543_create_budgets_table', 1),
(2, '2025_01_01_000001_create_units_table', 2),
(3, '2025_08_21_000000_create_or_align_event_programs_table', 3),
(4, '2025_08_21_000100_add_pic_user_to_event_programs_table', 4),
(5, '2025_09_03_000000_create_templates_table', 5),
(6, '2025_09_03_000001_create_template_items_table', 6),
(7, '2025_10_22_000000_create_password_otps_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `password_otps`
--

CREATE TABLE `password_otps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `used_at` timestamp NULL DEFAULT NULL,
  `ip` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_otps`
--

INSERT INTO `password_otps` (`id`, `user_id`, `code`, `expires`, `expires_at`, `used_at`, `ip`, `user_agent`, `created_at`, `updated_at`) VALUES
(1, 7, '872708', NULL, '2025-10-22 21:46:40', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', '2025-10-22 21:36:40', '2025-10-22 21:36:40');

-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

CREATE TABLE `templates` (
  `id_template` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_program_id` bigint(20) UNSIGNED NOT NULL,
  `pic_user_id` int(11) NOT NULL,
  `category` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `templates`
--

INSERT INTO `templates` (`id_template`, `name`, `event_program_id`, `pic_user_id`, `category`, `description`, `created_at`, `updated_at`) VALUES
(5, 'a', 1, 1, 'On Air', 'a', '2025-09-09 02:20:14', '2025-09-09 02:20:14'),
(12, 'testing', 2, 1, 'On Air', 'p', '2025-09-14 06:10:30', '2025-09-14 06:10:30'),
(16, 'duitduitduit', 1, 3, 'On Air', 'duit', '2025-09-15 00:08:18', '2025-09-15 00:12:34'),
(26, 'bansos duit duit duit duit duit ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt', 3, 2, 'On Air', 'mangan bang', '2025-09-26 21:29:35', '2025-10-05 21:35:10'),
(27, 'testingggggggggggggggggggggggggggggg ggggggggggggggg gggggggggg ggggggggggggggggggggggggggggggg', 2, 1, 'Off Air', 'p', '2025-09-27 07:10:49', '2025-09-27 07:10:49'),
(28, 'mbg', 3, 3, 'On Air', 'mangannn', '2025-09-27 08:35:16', '2025-09-27 08:35:16'),
(29, 'ada', 1, 3, 'On Air', 'duit', '2025-09-27 08:42:15', '2025-10-06 21:10:42'),
(30, 'Outdoor', 1, 1, 'Off Air', 'Pembagian bansos', '2025-10-15 23:49:07', '2025-10-15 23:49:07'),
(31, 'event', 10, 2, 'On Air', 'event', '2025-10-17 01:59:48', '2025-10-17 01:59:48'),
(32, 'template', 11, 7, 'Off Air', 'program', '2025-10-27 00:20:19', '2025-10-27 00:20:19'),
(33, 'template metro this week', 12, 2, 'Off Air', 'metro this week', '2025-10-27 02:39:16', '2025-10-27 02:39:16');

-- --------------------------------------------------------

--
-- Table structure for table `template_items`
--

CREATE TABLE `template_items` (
  `id_template_item` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `short_desc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `template_items`
--

INSERT INTO `template_items` (`id_template_item`, `template_id`, `item_id`, `qty`, `item_name`, `unit`, `unit_price`, `short_desc`, `created_at`, `updated_at`) VALUES
(3, 16, 6, 12, 'transportasi', '', '600000.00', 'ongkos kru harian', '2025-09-15 00:08:27', '2025-09-15 00:08:27'),
(4, 16, 4, 1, 'Talent Fee', '', '50000000.00', 'Honor untuk talent atau pembicara', '2025-09-15 00:11:44', '2025-09-15 00:11:44'),
(13, 29, 3, 2, 'Catering', 'Box', '10000000.00', 'Konsumsi untuk crew dan talent', '2025-10-03 02:20:07', '2025-10-06 21:10:28'),
(14, 29, 1, 1, 'Sound System', 'Paket', '800000000.00', 'Audio equipment untuk acara', '2025-10-03 02:20:14', '2025-10-03 02:20:14'),
(15, 28, 5, 1, 'Venue Rental', 'Hari', '3000000000.00', 'Sewa venue untuk acara', '2025-10-03 02:20:36', '2025-10-03 02:20:36'),
(16, 28, 3, 1, 'Catering', 'Box', '10000000.00', 'Konsumsi untuk crew dan talent', '2025-10-03 02:20:39', '2025-10-03 02:20:39'),
(18, 29, 1, 1, 'Sound System', 'Paket', '800000000.00', 'Audio equipment untuk acara', '2025-10-03 03:21:27', '2025-10-03 03:21:27'),
(20, 27, 6, 1, 'transportasi', 'Hari', '60000000.00', 'ongkos kru harian', '2025-10-03 04:04:30', '2025-10-03 04:04:30'),
(21, 27, 5, 1, 'Venue Rental', 'Hari', '3000000000.00', 'Sewa venue untuk acara', '2025-10-03 04:04:32', '2025-10-03 04:04:32'),
(22, 27, 1, 2, 'Sound System', 'Paket', '800000000.00', 'Audio equipment untuk acara', '2025-10-03 04:04:50', '2025-10-03 04:13:20'),
(23, 27, 3, 2, 'Catering', 'Box', '10000000.00', 'Konsumsi untuk crew dan talent', '2025-10-03 04:13:30', '2025-10-03 04:13:32'),
(24, 26, 3, 2, 'Catering', 'Box', '10000000.00', 'Konsumsi untuk crew dan talent', '2025-10-05 21:18:12', '2025-10-05 21:18:14'),
(25, 26, 6, 1, 'transportasi', 'Hari', '60000000.00', 'ongkos kru harian', '2025-10-05 21:18:16', '2025-10-05 21:18:16'),
(26, 26, 5, 1, 'Venue Rental', 'Hari', '3000000000.00', 'Sewa venue untuk acara', '2025-10-05 21:18:18', '2025-10-05 21:18:18'),
(27, 30, 3, 3, 'Catering', 'Box', '10000000.00', 'Konsumsi untuk crew dan talent', '2025-10-15 23:49:16', '2025-10-15 23:50:05'),
(28, 30, 8, 1, 'Pemasangan Panggung', 'Paket', '6000000.00', 'Jasa dan material', '2025-10-15 23:49:24', '2025-10-15 23:49:24'),
(29, 30, 1, 1, 'Sound System', 'Paket', '800000000.00', 'Audio equipment untuk acara', '2025-10-15 23:49:27', '2025-10-15 23:49:27'),
(30, 30, 5, 1, 'Venue Rental', 'Hari', '3000000000.00', 'Sewa venue untuk acara', '2025-10-15 23:49:30', '2025-10-15 23:49:30'),
(31, 30, 2, 1, 'Lighting Equipment', 'Paket', '600000000.00', 'Peralatan pencahayaan panggung', '2025-10-15 23:49:35', '2025-10-15 23:49:35'),
(32, 31, 2, 4, 'Lighting Equipment', 'Paket', '600000000.00', 'Peralatan pencahayaan panggung', '2025-10-20 02:04:27', '2025-10-21 00:04:01'),
(33, 31, 9, 10, 'Tes', 'tes', '200.00', 'tes', '2025-10-20 02:10:53', '2025-10-21 00:03:59'),
(34, 32, 10, 10, 'item', '1', '123123123.00', 'item', '2025-10-27 00:20:30', '2025-10-27 00:24:57'),
(35, 32, 9, 2, 'Tes', 'tes', '200.00', 'tes', '2025-10-27 00:20:34', '2025-10-27 00:24:53'),
(36, 33, 11, 1, 'narasumber', 'Paket', '2500000.00', 'narasumber', '2025-10-27 02:39:25', '2025-10-27 02:39:38'),
(37, 33, 2, 1, 'Lighting Equipment', 'Paket', '600000000.00', 'Peralatan pencahayaan panggung', '2025-10-27 02:39:43', '2025-10-27 02:39:43'),
(38, 33, 6, 1, 'transportasi', 'Hari', '60000000.00', 'ongkos kru harian', '2025-10-27 02:39:48', '2025-10-27 02:39:48');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id_unit` bigint(20) UNSIGNED NOT NULL,
  `unit_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id_unit`, `unit_name`) VALUES
(5, '1'),
(3, 'Box'),
(1, 'Hari'),
(2, 'Paket'),
(4, 'tes');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_level_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `name`, `email`, `username`, `password`, `user_level_id`) VALUES
(1, 'Administrator', 'admin@metrotv.com', 'admin123', '$2y$12$HWO.sphxUibgl/My6C1QguJpaHoiyGT6oWq5OHbgdTAd3e3Y/zb.a', 1),
(2, 'John Doe', 'john@metrotv.com', 'john123', '$2y$12$KjzsZ/7xmHI5ATuExwZ1w.41pjDMZu/bAXDBi7ZHbM0qEJIBInjfS', 2),
(3, 'Hacker', 'anonim@metrotv.com', 'anonimous', '$2y$12$NhZ1LE/6sz2qOAlbUKI5deHBBNwXWoauvYNZyHFead9G0IAkWMbmO', 4),
(7, 'Muhamad Arya Praseptya', 'm.arya.praseptya@gmail.com', 'Arya123', '$2y$12$AcITXh2cEKRN/4Cf3mwFru3x0G2b6Kl9R5gkPJwRbE0AWQ7.fEt06', 1),
(8, 'hermanto', 'hermanto@metrotvnews.com', 'hermanto1st', '$2y$12$Ndks4mYUsU3UvfWhfYP3Ne7lL8a69Iq39DPDN5wQJeiedJkN2xoW.', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_levels`
--

CREATE TABLE `user_levels` (
  `id_level` int(11) NOT NULL,
  `level_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_levels`
--

INSERT INTO `user_levels` (`id_level`, `level_name`) VALUES
(1, 'Admin'),
(2, 'Staff'),
(3, 'Manager'),
(4, 'Director');

-- --------------------------------------------------------

--
-- Table structure for table `user_level_access`
--

CREATE TABLE `user_level_access` (
  `id_access` int(11) NOT NULL,
  `user_level_id` int(11) NOT NULL,
  `feature_name` varchar(100) DEFAULT NULL,
  `access` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `budgets`
--
ALTER TABLE `budgets`
  ADD PRIMARY KEY (`id_budget`),
  ADD KEY `template_id` (`template_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `budget_approvals`
--
ALTER TABLE `budget_approvals`
  ADD PRIMARY KEY (`id_approval`),
  ADD KEY `budget_id` (`budget_id`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `budget_items`
--
ALTER TABLE `budget_items`
  ADD PRIMARY KEY (`id_budget_item`),
  ADD KEY `budget_id` (`budget_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `idx_budget_items_budget_id` (`budget_id`),
  ADD KEY `idx_budget_items_item_id` (`item_id`);

--
-- Indexes for table `event_programs`
--
ALTER TABLE `event_programs`
  ADD PRIMARY KEY (`id_event_program`),
  ADD KEY `pic_user_id` (`pic_user_id`);

--
-- Indexes for table `master_items`
--
ALTER TABLE `master_items`
  ADD PRIMARY KEY (`id_item`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_otps`
--
ALTER TABLE `password_otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `password_otps_user_id_index` (`user_id`);

--
-- Indexes for table `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id_template`),
  ADD KEY `templates_event_program_id_foreign` (`event_program_id`),
  ADD KEY `templates_pic_user_id_foreign` (`pic_user_id`);

--
-- Indexes for table `template_items`
--
ALTER TABLE `template_items`
  ADD PRIMARY KEY (`id_template_item`),
  ADD KEY `template_items_template_id_foreign` (`template_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id_unit`),
  ADD UNIQUE KEY `units_unit_name_unique` (`unit_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `user_level_id` (`user_level_id`);

--
-- Indexes for table `user_levels`
--
ALTER TABLE `user_levels`
  ADD PRIMARY KEY (`id_level`);

--
-- Indexes for table `user_level_access`
--
ALTER TABLE `user_level_access`
  ADD PRIMARY KEY (`id_access`),
  ADD KEY `user_level_id` (`user_level_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `budgets`
--
ALTER TABLE `budgets`
  MODIFY `id_budget` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `budget_approvals`
--
ALTER TABLE `budget_approvals`
  MODIFY `id_approval` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `budget_items`
--
ALTER TABLE `budget_items`
  MODIFY `id_budget_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `event_programs`
--
ALTER TABLE `event_programs`
  MODIFY `id_event_program` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `master_items`
--
ALTER TABLE `master_items`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `password_otps`
--
ALTER TABLE `password_otps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `templates`
--
ALTER TABLE `templates`
  MODIFY `id_template` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `template_items`
--
ALTER TABLE `template_items`
  MODIFY `id_template_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id_unit` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_levels`
--
ALTER TABLE `user_levels`
  MODIFY `id_level` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_level_access`
--
ALTER TABLE `user_level_access`
  MODIFY `id_access` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `budgets`
--
ALTER TABLE `budgets`
  ADD CONSTRAINT `budgets_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id_template`),
  ADD CONSTRAINT `budgets_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `budget_approvals`
--
ALTER TABLE `budget_approvals`
  ADD CONSTRAINT `budget_approvals_ibfk_1` FOREIGN KEY (`budget_id`) REFERENCES `budgets` (`id_budget`),
  ADD CONSTRAINT `budget_approvals_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `budget_items`
--
ALTER TABLE `budget_items`
  ADD CONSTRAINT `budget_items_ibfk_1` FOREIGN KEY (`budget_id`) REFERENCES `budgets` (`id_budget`),
  ADD CONSTRAINT `budget_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `master_items` (`id_item`);

--
-- Constraints for table `event_programs`
--
ALTER TABLE `event_programs`
  ADD CONSTRAINT `event_programs_ibfk_1` FOREIGN KEY (`pic_user_id`) REFERENCES `users` (`id_user`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `master_items`
--
ALTER TABLE `master_items`
  ADD CONSTRAINT `master_items_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id_unit`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `templates`
--
ALTER TABLE `templates`
  ADD CONSTRAINT `templates_event_program_id_foreign` FOREIGN KEY (`event_program_id`) REFERENCES `event_programs` (`id_event_program`) ON UPDATE CASCADE,
  ADD CONSTRAINT `templates_pic_user_id_foreign` FOREIGN KEY (`pic_user_id`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE;

--
-- Constraints for table `template_items`
--
ALTER TABLE `template_items`
  ADD CONSTRAINT `template_items_template_id_foreign` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id_template`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_level_id`) REFERENCES `user_levels` (`id_level`);

--
-- Constraints for table `user_level_access`
--
ALTER TABLE `user_level_access`
  ADD CONSTRAINT `user_level_access_ibfk_1` FOREIGN KEY (`user_level_id`) REFERENCES `user_levels` (`id_level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
