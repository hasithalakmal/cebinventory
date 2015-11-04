-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 26, 2010 at 01:28 PM
-- Server version: 5.1.37
-- PHP Version: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `plethora_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE IF NOT EXISTS `adjustments` (
  `user_name` varchar(50) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `available_quantity` varchar(10) NOT NULL,
  `adjustment_no` varchar(20) NOT NULL,
  `remarks` varchar(255) NOT NULL,
  `approved` varchar(8) NOT NULL,
  `status` varchar(10) NOT NULL,
  `actual_quantity` varchar(10) NOT NULL,
  PRIMARY KEY (`user_name`,`item_code`,`adjustment_no`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auctioning_list`
--

CREATE TABLE IF NOT EXISTS `auctioning_list` (
  `auction_no` varchar(15) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `item_code` varchar(15) NOT NULL,
  `status` varchar(10) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `remarks` varchar(255) NOT NULL,
  `price` varchar(15) NOT NULL,
  `value` varchar(15) NOT NULL,
  `selling_price` varchar(15) NOT NULL,
  `cause_for_auction` varchar(255) NOT NULL,
  `approved` varchar(10) NOT NULL,
  PRIMARY KEY (`auction_no`,`user_name`,`item_code`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `category_item_last`
--

CREATE TABLE IF NOT EXISTS `category_item_last` (
  `category` varchar(25) NOT NULL,
  `item` varchar(25) NOT NULL,
  `last` varchar(25) NOT NULL,
  PRIMARY KEY (`category`,`item`,`last`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `category_item_master`
--

CREATE TABLE IF NOT EXISTS `category_item_master` (
  `category` varchar(50) NOT NULL,
  `category_code` varchar(20) NOT NULL,
  `item` varchar(50) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  PRIMARY KEY (`category_code`,`item_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cost_centre_master`
--

CREATE TABLE IF NOT EXISTS `cost_centre_master` (
  `cost_centre_id` varchar(20) NOT NULL,
  `cost_centre_name` varchar(50) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cost_centre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `item_master`
--

CREATE TABLE IF NOT EXISTS `item_master` (
  `item_code` varchar(20) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL,
  `is_inventory` varchar(1) NOT NULL,
  `is_capital` varchar(1) NOT NULL,
  `price` varchar(20) DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  `depreciation_rate` varchar(10) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `vendor` varchar(100) NOT NULL,
  `location` varchar(50) NOT NULL,
  `composite` varchar(50) DEFAULT NULL,
  `composite_code` varchar(20) DEFAULT NULL,
  `critical` varchar(10) DEFAULT NULL,
  `unit_of_measure` varchar(25) DEFAULT NULL,
  `image` longblob,
  `remarks` varchar(255) DEFAULT NULL,
  `safety_stock` varchar(50) DEFAULT NULL,
  `reorder_level` varchar(50) DEFAULT NULL,
  `maximum_stock` varchar(50) DEFAULT NULL,
  `abc` varchar(10) DEFAULT NULL,
  `warranty_expiry_date` date NOT NULL,
  `service_start_date` varchar(50) NOT NULL,
  `service_end_date` date NOT NULL,
  `lead_time` varchar(10) NOT NULL,
  PRIMARY KEY (`item_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `openning_stock`
--

CREATE TABLE IF NOT EXISTS `openning_stock` (
  `doc_number` varchar(255) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `receive_date` varchar(255) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `doc_date` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `confirmed` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`doc_number`,`item_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE IF NOT EXISTS `owner` (
  `user_name` varchar(50) NOT NULL,
  `section_id` varchar(20) DEFAULT NULL,
  `owner_first_name` varchar(50) NOT NULL,
  `owner_last_name` varchar(50) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `user_role` varchar(20) DEFAULT NULL,
  `cost_id` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `approved` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `owner_item_master`
--

CREATE TABLE IF NOT EXISTS `owner_item_master` (
  `user_name` varchar(50) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `cost_id` varchar(20) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `unit_of_measure` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT '',
  `section_id` varchar(20) NOT NULL,
  `freeze` varchar(20) NOT NULL,
  `conflict_flag` varchar(2) NOT NULL,
  `lended` varchar(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_name`,`item_code`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `request_item`
--

CREATE TABLE IF NOT EXISTS `request_item` (
  `user_name` varchar(50) DEFAULT NULL,
  `item_description` varchar(255) DEFAULT NULL,
  `quantity` varchar(10) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `request_id` varchar(20) NOT NULL,
  `approved` varchar(1) NOT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `section_master`
--

CREATE TABLE IF NOT EXISTS `section_master` (
  `section_id` varchar(25) NOT NULL,
  `section_name` varchar(50) NOT NULL,
  `status` varchar(25) DEFAULT NULL,
  `centre_id` varchar(50) NOT NULL,
  `center_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`section_id`,`centre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `status_change_requests`
--

CREATE TABLE IF NOT EXISTS `status_change_requests` (
  `item_code` varchar(20) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `current_status` varchar(20) NOT NULL DEFAULT '',
  `requested_status` varchar(20) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL,
  `cause` varchar(255) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `available_quantity` varchar(10) NOT NULL,
  `date` varchar(20) NOT NULL DEFAULT '',
  `approved` varchar(8) NOT NULL,
  PRIMARY KEY (`item_code`,`user_name`,`date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_category_item`
--

CREATE TABLE IF NOT EXISTS `stock_category_item` (
  `category` varchar(50) DEFAULT NULL,
  `category_code` varchar(20) NOT NULL,
  `item` varchar(50) DEFAULT NULL,
  `item_code` varchar(20) NOT NULL,
  PRIMARY KEY (`category_code`,`item_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_item_last`
--

CREATE TABLE IF NOT EXISTS `stock_item_last` (
  `category` varchar(25) NOT NULL,
  `item` varchar(25) NOT NULL,
  `last` varchar(10) NOT NULL,
  PRIMARY KEY (`category`,`item`,`last`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_detail`
--

CREATE TABLE IF NOT EXISTS `transaction_detail` (
  `doc_number` varchar(20) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `unit_of_measure` varchar(20) DEFAULT NULL,
  `quantity` varchar(10) DEFAULT NULL,
  `wbno` varchar(20) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`doc_number`,`item_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_header`
--

CREATE TABLE IF NOT EXISTS `transaction_header` (
  `doc_number` varchar(20) NOT NULL,
  `doc_date` varchar(20) NOT NULL,
  `transaction_type` varchar(20) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `issue_to` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `request_no` varchar(20) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`doc_number`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `verification`
--

CREATE TABLE IF NOT EXISTS `verification` (
  `verification_no` varchar(20) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `date` varchar(20) NOT NULL,
  `remarks` varchar(255) NOT NULL,
  `approved` varchar(8) NOT NULL,
  `requested_status` varchar(25) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '',
  `actual_quantity` varchar(20) NOT NULL,
  `available_quantity` varchar(20) NOT NULL,
  PRIMARY KEY (`verification_no`,`user_name`,`item_code`,`requested_status`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
