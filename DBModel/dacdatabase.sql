-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.20-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for dac
CREATE DATABASE IF NOT EXISTS `dac` /*!40100 DEFAULT CHARACTER SET ascii */;
USE `dac`;

-- Dumping structure for table dac.allergies
CREATE TABLE IF NOT EXISTS `allergies` (
  `ALLERGY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ALLERGY_NAME` varchar(50) NOT NULL,
  `ALLERGY_DESCRIPTION` varchar(50) NOT NULL,
  PRIMARY KEY (`ALLERGY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.allergies: ~8 rows (approximately)
/*!40000 ALTER TABLE `allergies` DISABLE KEYS */;
REPLACE INTO `allergies` (`ALLERGY_ID`, `ALLERGY_NAME`, `ALLERGY_DESCRIPTION`) VALUES
	(1, 'Penicillin', 'Antibiotic allergy'),
	(2, 'Sulfa Drug', 'Antibiotic allergy'),
	(3, 'Tetracycline', 'Antibiotic allergy'),
	(4, 'Codeine', 'Opiate'),
	(5, 'NSAID', 'NSAID'),
	(6, 'Phenytoin', 'Antiseizure '),
	(7, 'Carbamazepine', 'Antiseizure '),
	(8, 'Latex', 'Latex'),
	(9, 'Cephalosporins', 'related to penicillin'),
	(10, 'IV contrast dye', 'IV contrast dye');
/*!40000 ALTER TABLE `allergies` ENABLE KEYS */;

-- Dumping structure for table dac.appointment
CREATE TABLE IF NOT EXISTS `appointment` (
  `APPOINTMENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PATIENT_ID` int(11) NOT NULL,
  `DOCTOR_ID` int(11) NOT NULL,
  `APPOINTMENT_TIME` time NOT NULL,
  `APPOINTMENT_DATE` date NOT NULL,
  PRIMARY KEY (`APPOINTMENT_ID`),
  KEY `PATIENT_ID` (`PATIENT_ID`),
  KEY `DOCTOR_ID` (`DOCTOR_ID`),
  CONSTRAINT `FK_APPOINTMENT_doctor` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_APPOINTMENT_patient` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.appointment: ~3 rows (approximately)
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
REPLACE INTO `appointment` (`APPOINTMENT_ID`, `PATIENT_ID`, `DOCTOR_ID`, `APPOINTMENT_TIME`, `APPOINTMENT_DATE`) VALUES
	(1, 11, 10, '10:30:00', '2017-04-21'),
	(2, 11, 2, '08:15:00', '2017-05-15'),
	(3, 11, 6, '10:45:00', '2016-11-15');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;

-- Dumping structure for table dac.doctor
CREATE TABLE IF NOT EXISTS `doctor` (
  `DOCTOR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DOC_NAME` varchar(50) NOT NULL,
  `DOC_SPECIALTY` varchar(50) NOT NULL,
  `DOC_PHONE_NUMBER` varchar(50) NOT NULL,
  `DOC_ADDRESS` varchar(50) NOT NULL,
  `DOC_CITY` varchar(50) NOT NULL,
  `DOC_STATE` varchar(50) NOT NULL,
  `DOC_ZIP` varchar(50) NOT NULL,
  PRIMARY KEY (`DOCTOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.doctor: ~16 rows (approximately)
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
REPLACE INTO `doctor` (`DOCTOR_ID`, `DOC_NAME`, `DOC_SPECIALTY`, `DOC_PHONE_NUMBER`, `DOC_ADDRESS`, `DOC_CITY`, `DOC_STATE`, `DOC_ZIP`) VALUES
	(1, 'Dr. Robert B. Rook', 'Family Practice', '501-329-2946', '919 Locust Street ', 'Conway', 'AR', '72034'),
	(2, 'Dr. David Naylor', 'Family Practice', '501-329-3824', '2425 Dave Ward Drive', 'Conway', 'AR', '72034'),
	(3, 'Dr. Bart Thornberry', 'Family Practice', '501-327-2611', '2869 College Ave', 'Conway', 'AR', '72034'),
	(4, 'Dr. Laura Massey', 'Family Practice', '501-327-1325', '437 Denison Street', 'Conway', 'AR', '72034'),
	(5, 'Dr. Smith John D', 'Family Practice', '501-329-3824 ', '2425 Dave Ward Drive', 'Conway', 'AR', '72034'),
	(6, 'Dr. Bowlin Randa', 'Family Practice ', '501-329-3824', '2425 Dave Ward Drive', 'Conway', 'AR', '72034'),
	(7, 'Dr.  Kelly Staley ', 'Family Practice', '501-327-6000', '2505 College Ave', 'Conway', 'AR', '72034'),
	(8, 'Dr. David A. Martin', 'Family Practice', '501-932-5060', '3025 Fountain Drive #100', 'Conway', 'AR', '72034'),
	(9, 'Dr. Ross Rex W', 'Family Practice', '501-329-2948', '1 Medical Lane', 'Conway', 'AR', '72034'),
	(10, 'Dr. Brad Tilley', 'Family Practice', '501-327-1150', '495 Hogan Lane #1', 'Conway', 'AR', '72034'),
	(11, 'Dr. Tyrone Lee', 'Pulmonology', '501-327-9532', '3700 W. College Ave', 'Conway', 'AR', '72034'),
	(12, 'Dr. Richard F. Griffiths', 'Endocrinology', '501-552-4763', '701 N University Ave Ste 201', 'Little Rock', 'AR', '72205'),
	(13, 'Dr. Jennifer Middleton', 'Psychiatry', '501-336-8300', '350 Salem Rd', 'Conway', 'AR', '72034'),
	(14, 'Dr. James Thomas', 'Cardiology', '501-205-8389', '650 United Dr Ste 300', 'Conway', 'AR', '72032'),
	(15, 'Dr. Keith Schluterman', 'Neurology', '501-932-0352', '2200 Ada Street, Suite 305', 'Conway', 'AR', '72034'),
	(16, 'Dr. Karl Landberg', 'Gastroenterology', '501-336-9620', '1375 Old Morrilton Hwy', 'Conway', 'AR', '72032');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;

-- Dumping structure for table dac.drug_interaction
CREATE TABLE IF NOT EXISTS `drug_interaction` (
  `DRUG_INTERACTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RXCUI` int(11) NOT NULL,
  `INTER_RXCUI` int(11) NOT NULL,
  `INTER_DESCRIPTION` varchar(500) NOT NULL,
  PRIMARY KEY (`DRUG_INTERACTION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.drug_interaction: ~194 rows (approximately)
/*!40000 ALTER TABLE `drug_interaction` DISABLE KEYS */;
REPLACE INTO `drug_interaction` (`DRUG_INTERACTION_ID`, `RXCUI`, `INTER_RXCUI`, `INTER_DESCRIPTION`) VALUES
	(1, 435, 5487, 'Albuterol may increase the hypokalemic activities of Hydrochlorothiazide'),
	(2, 435, 18631, 'Albuterol may increase the QTc-prolonging activities of Azithromycin'),
	(3, 435, 72625, 'Duloxetine may increase the tachycardic activities of Albuterol'),
	(4, 435, 8787, 'Propranolol may decrease the bronchodilatory activities of Albuterol'),
	(5, 435, 703, 'Albuterol may increase the QTc-prolonging activities of Amiodarone'),
	(6, 435, 1760, 'Bromocriptine may increase the hypertensive activities of Albuterol'),
	(7, 301543, 29046, 'The serum concentration of Advair can be increased when it is combined with Lisinopril'),
	(8, 301543, 5487, 'Advair may increase the hypokalemic activities of Hydrochlorothiazide'),
	(9, 301543, 596, 'The risk or severity of adverse effects can be increased when Alprazolam is combined with Advair'),
	(10, 301543, 18631, 'Advair may increase the QTc-prolonging activities of Azithromycin'),
	(11, 301543, 3640, 'The metabolism of Advair can be decreased when combined with Doxycycline'),
	(12, 301543, 161, 'The serum concentration of Advair can be increased when it is combined with Acetaminophen'),
	(13, 301543, 10582, '"The serum concentration of Advair can be decreased when it is combined with Levothyroxine'),
	(14, 301543, 72625, 'The risk or severity of adverse effects can be increased when Advair is combined with Duloxetine'),
	(15, 301543, 11170, 'The metabolism of Advair can be decreased when combined with Verapamil'),
	(16, 301543, 8787, 'The serum concentration of Advair can be increased when it is combined with Propranolol'),
	(17, 301543, 703, 'The serum concentration of Advair can be increased when it is combined with Amiodarone'),
	(18, 301543, 83367, 'The serum concentration of Advair can be increased when it is combined with Atorvastatin'),
	(19, 301543, 10689, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Advair'),
	(20, 301543, 6375, 'The risk or severity of adverse effects can be increased when Advair is combined with Levodopa'),
	(21, 301543, 1760, 'Bromocriptine may increase the hypertensive activities of Advair'),
	(22, 301543, 6448, 'The risk or severity of adverse effects can be increased when Lithium is combined with Advair'),
	(23, 301543, 11118, 'The risk or severity of adverse effects can be increased when Valproic Acid is combined with Advair'),
	(24, 301543, 11289, 'Advair may increase the anticoagulant activities of Warfarin'),
	(25, 301543, 4637, 'The risk or severity of adverse effects can be increased when Advair is combined with Galantamine'),
	(26, 301542, 6468, 'The serum concentration of Advair can be increased when it is combined with Loperamide'),
	(27, 25789, 5487, 'The therapeutic efficacy of Glimepiride can be decreased when used in combination with Hydrochlorothiazide'),
	(28, 25789, 72625, 'Duloxetine may increase the hypoglycemic activities of Glimepiride'),
	(29, 25789, 8787, 'Propranolol may increase the hypoglycemic activities of Glimepiride'),
	(30, 25789, 703, 'The metabolism of Glimepiride can be decreased when combined with Amiodarone'),
	(31, 25789, 83367, 'Atorvastatin may increase the hypoglycemic activities of Glimepiride'),
	(32, 25789, 11118, 'The metabolism of Glimepiride can be decreased when combined with Valproic Acid'),
	(33, 25789, 11289, 'Glimepiride may increase the anticoagulant activities of Warfarin'),
	(34, 6809, 5487, 'The therapeutic efficacy of Metformin can be decreased when used in combination with Hydrochlorothiazide'),
	(35, 6809, 72625, 'Duloxetine may increase the hypoglycemic activities of Metformin'),
	(36, 6809, 11170, 'The therapeutic efficacy of Metformin can be decreased when used in combination with Verapamil'),
	(37, 29046, 5487, 'The risk or severity of adverse effects can be increased when Lisinopril is combined with Hydrochlorothiazide'),
	(38, 29046, 596, 'The serum concentration of Alprazolam can be increased when it is combined with Lisinopril'),
	(39, 29046, 161, 'The serum concentration of Acetaminophen can be increased when it is combined with Lisinopril'),
	(40, 29046, 72625, 'Lisinopril may increase the orthostatic hypotensive activities of Duloxetine'),
	(41, 29046, 11170, 'The metabolism of Verapamil can be decreased when combined with Lisinopril'),
	(42, 29046, 8787, 'The risk or severity of adverse effects can be increased when Propranolol is combined with Lisinopril'),
	(43, 29046, 703, 'The risk or severity of adverse effects can be increased when Lisinopril is combined with Amiodarone'),
	(44, 29046, 83367, 'The serum concentration of Atorvastatin can be increased when it is combined with Lisinopril'),
	(45, 29046, 6375, 'Lisinopril may increase the orthostatic hypotensive activities of Levodopa'),
	(46, 29046, 1760, 'The serum concentration of Bromocriptine can be increased when it is combined with Lisinopril'),
	(47, 29046, 6448, 'The serum concentration of Lithium can be increased when it is combined with Lisinopril'),
	(48, 29046, 11118, 'The serum concentration of Valproic Acid can be decreased when it is combined with Lisinopril'),
	(49, 29046, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Lisinopril'),
	(50, 29046, 6468, 'The serum concentration of Loperamide can be increased when it is combined with Lisinopril'),
	(51, 5487, 72625, 'Hydrochlorothiazide may increase the orthostatic hypotensive activities of Duloxetine'),
	(52, 5487, 11170, 'The risk or severity of adverse effects can be increased when Verapamil is combined with Hydrochlorothiazide'),
	(53, 5487, 8787, 'The risk or severity of adverse effects can be increased when Propranolol is combined with Hydrochlorothiazide'),
	(54, 5487, 703, 'The risk or severity of adverse effects can be increased when Hydrochlorothiazide is combined with Amiodarone'),
	(55, 5487, 10689, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Hydrochlorothiazide'),
	(56, 5487, 6375, 'Hydrochlorothiazide may increase the orthostatic hypotensive activities of Levodopa'),
	(57, 5487, 1760, 'The risk or severity of adverse effects can be increased when Hydrochlorothiazide is combined with Bromocriptine'),
	(58, 5487, 6448, 'Hydrochlorothiazide may decrease the excretion rate of Lithium which could result in a higher serum level'),
	(59, 42568, 18631, 'The metabolism of Bupropion can be decreased when combined with Azithromycin'),
	(60, 42568, 3640, 'The metabolism of Bupropion can be decreased when combined with Doxycycline'),
	(61, 42568, 161, 'The metabolism of Acetaminophen can be decreased when combined with Bupropion'),
	(62, 42568, 72625, 'The serum concentration of Duloxetine can be increased when it is combined with Bupropion'),
	(63, 42568, 11170, 'The metabolism of Bupropion can be decreased when combined with Verapamil'),
	(64, 42568, 8787, 'The metabolism of Propranolol can be decreased when combined with Bupropion'),
	(65, 42568, 703, 'The metabolism of Bupropion can be decreased when combined with Amiodarone'),
	(66, 42568, 10689, 'The therapeutic efficacy of Tramadol can be decreased when used in combination with Bupropion'),
	(67, 42568, 6375, 'The risk or severity of adverse effects can be increased when Levodopa is combined with Bupropion'),
	(68, 42568, 1760, 'The risk or severity of adverse effects can be increased when Bromocriptine is combined with Bupropion'),
	(69, 42568, 11118, 'The metabolism of Bupropion can be decreased when combined with Valproic Acid'),
	(70, 42568, 4637, 'The metabolism of Galantamine can be decreased when combined with Bupropion'),
	(71, 42568, 6468, 'The metabolism of Loperamide can be decreased when combined with Bupropion'),
	(72, 352741, 596, 'The risk or severity of adverse effects can be increased when Alprazolam is combined with Lexapro'),
	(73, 352741, 18631, 'Azithromycin may increase the QTc-prolonging activities of Lexapro'),
	(74, 352741, 10582, 'The therapeutic efficacy of Levothyroxine can be decreased when used in combination with Lexapro'),
	(75, 352741, 72625, 'The risk or severity of adverse effects can be increased when Duloxetine is combined with Lexapro'),
	(76, 352741, 11170, 'The metabolism of Lexapro can be decreased when combined with Verapami'),
	(77, 352741, 703, 'Amiodarone may increase the QTc-prolonging activities of Lexapro'),
	(78, 352741, 10689, 'Lexapro may increase the neuroexcitatory activities of Tramadol'),
	(79, 352741, 6375, 'The risk or severity of adverse effects can be increased when Levodopa is combined with Lexapro'),
	(80, 352741, 1760, 'The risk or severity of adverse effects can be increased when Lexapro is combined with Bromocriptine'),
	(81, 352741, 6448, 'Lithium may increase the serotonergic activities of Lexapro'),
	(82, 352741, 11118, 'The risk or severity of adverse effects can be increased when Valproic Acid is combined with Lexapro'),
	(83, 352741, 11289, 'Lexapro may increase the anticoagulant activities of Warfarin'),
	(84, 352741, 4637, 'The metabolism of Galantamine can be decreased when combined with Lexapro'),
	(85, 596, 3640, 'The metabolism of Alprazolam can be decreased when combined with Doxycycline'),
	(86, 596, 72625, 'The risk or severity of adverse effects can be increased when Alprazolam is combined with Duloxetine'),
	(87, 596, 11170, 'The metabolism of Alprazolam can be decreased when combined with Verapamil'),
	(88, 596, 703, 'The metabolism of Alprazolam can be decreased when combined with Amiodarone'),
	(89, 596, 10689, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Alprazolam'),
	(90, 596, 6375, 'The risk or severity of adverse effects can be increased when Alprazolam is combined with Levodopa'),
	(91, 596, 6448, 'The risk or severity of adverse effects can be increased when Alprazolam is combined with Lithium'),
	(92, 596, 11118, 'The risk or severity of adverse effects can be increased when Valproic Acid is combined with Alprazolam'),
	(93, 18631, 3640, 'The metabolism of Azithromycin can be decreased when combined with Doxycycline'),
	(94, 18631, 161, 'The serum concentration of Acetaminophen can be increased when it is combined with Azithromycin'),
	(95, 18631, 72625, 'The metabolism of Duloxetine can be decreased when combined with Azithromycin'),
	(96, 18631, 11170, 'The metabolism of Azithromycin can be decreased when combined with Verapamil'),
	(97, 18631, 8787, 'The serum concentration of Propranolol can be increased when it is combined with Azithromycin'),
	(98, 18631, 703, 'QT prolonging agents - QT prolonging agents'),
	(99, 18631, 83367, 'Azithromycin may increase the myopathic rhabdomyolysis activities of Atorvastatin'),
	(100, 18631, 1760, 'The serum concentration of Bromocriptine can be increased when it is combined with Azithromycin'),
	(101, 18631, 6448, 'Lithium may increase the QTc-prolonging activities of Azithromycin'),
	(102, 18631, 11289, 'The metabolism of Warfarin can be decreased when combined with Azithromycin'),
	(103, 18631, 4637, 'Galantamine may increase the QTc-prolonging activities of Azithromycin'),
	(104, 18631, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Azithromycin'),
	(105, 3640, 161, 'The metabolism of Acetaminophen can be decreased when combined with Doxycycline'),
	(106, 3640, 10582, 'The metabolism of Levothyroxine can be decreased when combined with Doxycycline'),
	(107, 3640, 11170, 'The metabolism of Verapamil can be decreased when combined with Doxycycline'),
	(108, 3640, 8787, 'The metabolism of Propranolol can be decreased when combined with Doxycycline'),
	(109, 3640, 703, 'The metabolism of Amiodarone can be decreased when combined with Doxycycline'),
	(110, 3640, 83367, 'The metabolism of Atorvastatin can be decreased when combined with Doxycycline'),
	(111, 3640, 10689, 'The metabolism of Tramadol can be decreased when combined with Doxycycline'),
	(112, 3640, 1760, 'The metabolism of Bromocriptine can be decreased when combined with Doxycycline'),
	(113, 3640, 11289, 'The metabolism of Warfarin can be decreased when combined with Doxycycline'),
	(114, 3640, 4637, 'The metabolism of Galantamine can be decreased when combined with Doxycycline'),
	(115, 3640, 6468, 'The metabolism of Loperamide can be decreased when combined with Doxycycline'),
	(116, 3640, 723, 'The therapeutic efficacy of Amoxicillin can be decreased when used in combination with Doxycycline'),
	(117, 153010, 161, 'The serum concentration of Ibuprofen can be increased when it is combined with Acetaminophen'),
	(118, 153010, 10582, 'The serum concentration of Ibuprofen can be decreased when it is combined with Levothyroxine'),
	(119, 153010, 11170, 'The serum concentration of Ibuprofen can be decreased when it is combined with Verapamil'),
	(120, 153010, 8787, 'The serum concentration of Ibuprofen can be increased when it is combined with Propranolol'),
	(121, 153010, 703, 'The metabolism of Ibuprofen can be decreased when combined with Amiodarone'),
	(122, 153010, 83367, 'The serum concentration of Ibuprofen can be increased when it is combined with Atorvastatin'),
	(123, 153010, 1760, 'The serum concentration of Ibuprofen can be increased when it is combined with Bromocriptine'),
	(124, 153010, 6448, 'The serum concentration of Lithium can be increased when it is combined with Ibuprofen'),
	(125, 153010, 11118, 'The metabolism of Ibuprofen can be decreased when combined with Valproic Acid'),
	(126, 153010, 11289, 'Ibuprofen may increase the anticoagulant activities of Warfarin'),
	(127, 153010, 77655, 'The risk or severity of adverse effects can be increased when Ibuprofen is combined with Zoledronic acid'),
	(128, 153010, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Ibuprofen'),
	(129, 153010, 6468, 'The serum concentration of Ibuprofen can be increased when it is combined with Loperamide'),
	(130, 161, 10582, 'The serum concentration of Acetaminophen can be decreased when it is combined with Levothyroxine'),
	(131, 161, 72625, 'The metabolism of Acetaminophen can be decreased when combined with Duloxetine'),
	(132, 161, 11170, 'The metabolism of Acetaminophen can be decreased when combined with Verapamil'),
	(133, 161, 8787, 'The serum concentration of Propranolol can be increased when it is combined with Acetaminophen'),
	(134, 161, 703, 'The metabolism of Acetaminophen can be decreased when combined with Amiodarone'),
	(135, 161, 83367, 'The serum concentration of Acetaminophen can be increased when it is combined with Atorvastatin'),
	(136, 161, 1760, 'The serum concentration of Bromocriptine can be increased when it is combined with Acetaminophen'),
	(137, 161, 11118, 'The metabolism of Acetaminophen can be decreased when combined with Valproic Acid'),
	(138, 161, 11289, 'Acetaminophen may increase the anticoagulant activities of Warfarin'),
	(139, 161, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Acetaminophen'),
	(140, 161, 6468, '"The serum concentration of Loperamide can be increased when it is combined with Acetaminophen'),
	(141, 10582, 72625, 'The therapeutic efficacy of Levothyroxine can be decreased when used in combination with Duloxetine'),
	(142, 10582, 11170, 'The metabolism of Levothyroxine can be decreased when combined with Verapamil'),
	(143, 10582, 8787, 'The serum concentration of Propranolol can be decreased when it is combined with Levothyroxine'),
	(144, 10582, 703, 'The metabolism of Levothyroxine can be decreased when combined with Amiodarone'),
	(145, 10582, 1760, 'The serum concentration of Bromocriptine can be decreased when it is combined with Levothyroxine'),
	(146, 10582, 11289, 'Levothyroxine may increase the anticoagulant activities of Warfarin'),
	(147, 10582, 6851, 'The serum concentration of Methotrexate can be decreased when it is combined with Levothyroxine'),
	(148, 84815, 72625, 'The metabolism of Dextroamphetamine can be decreased when combined with Duloxetine'),
	(149, 84815, 703, 'The metabolism of Dextroamphetamine can be decreased when combined with Amiodarone'),
	(150, 84815, 10689, 'Amphetamine may increase the analgesic activities of Tramadol'),
	(151, 84815, 6448, 'Lithium may decrease the stimulatory activities of Dextroamphetamine'),
	(152, 72625, 11170, 'Verapamil may increase the orthostatic hypotensive activities of Duloxetine'),
	(153, 72625, 8787, 'Propranolol may increase the orthostatic hypotensive activities of Duloxetine'),
	(154, 72625, 703, 'Amiodarone may increase the orthostatic hypotensive activities of Duloxetine'),
	(155, 72625, 10689, 'Duloxetine may increase the neuroexcitatory activities of Tramadol'),
	(156, 72625, 6375, 'Levodopa may increase the orthostatic hypotensive activities of Duloxetine'),
	(157, 72625, 1760, 'Bromocriptine may increase the orthostatic hypotensive activities of Duloxetine'),
	(158, 72625, 6448, 'Lithium may increase the serotonergic activities of Duloxetine'),
	(159, 72625, 11118, 'The risk or severity of adverse effects can be increased when Valproic Acid is combined with Duloxetine'),
	(160, 72625, 11289, 'Duloxetine may increase the anticoagulant activities of Warfarin'),
	(161, 72625, 4637, 'The metabolism of Galantamine can be decreased when combined with Duloxetine'),
	(162, 72625, 6468, 'The metabolism of Loperamide can be decreased when combined with Duloxetine'),
	(163, 11170, 8787, 'The risk or severity of adverse effects can be increased when Propranolol is combined with Verapamil'),
	(164, 11170, 703, 'Verapamil may increase the bradycardic activities of Amiodarone'),
	(165, 11170, 83367, 'The serum concentration of Verapamil can be increased when it is combined with Atorvastatin'),
	(166, 11170, 10689, 'The metabolism of Tramadol can be decreased when combined with Verapamil'),
	(167, 11170, 6375, 'Verapamil may increase the orthostatic hypotensive activities of Levodopa'),
	(168, 11170, 1760, 'The metabolism of Bromocriptine can be decreased when combined with Verapamil'),
	(169, 11170, 6448, 'Verapamil may increase the neurotoxic activities of Lithium'),
	(170, 11170, 11118, 'The metabolism of Verapamil can be decreased when combined with Valproic Acid'),
	(171, 11170, 11289, 'The metabolism of Warfarin can be decreased when combined with Verapamil'),
	(172, 11170, 4637, 'The metabolism of Galantamine can be decreased when combined with Verapamil'),
	(173, 11170, 6851, '"The serum concentration of Methotrexate can be decreased when it is combined with Verapamil'),
	(174, 11170, 6468, 'The metabolism of Loperamide can be decreased when combined with Verapamil'),
	(175, 8787, 703, 'Amiodarone may increase the bradycardic activities of Propranolol'),
	(176, 8787, 83367, 'The serum concentration of Propranolol can be increased when it is combined with Atorvastatin'),
	(177, 8787, 6375, 'Propranolol may increase the orthostatic hypotensive activities of Levodopa'),
	(178, 8787, 1760, 'Bromocriptine may increase the atrioventricular blocking (AV block) activities of Propranolol'),
	(179, 8787, 4637, 'Galantamine may increase the bradycardic activities of Propranolol'),
	(180, 8787, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Propranolol'),
	(181, 8787, 6468, 'The serum concentration of Propranolol can be increased when it is combined with Loperamide'),
	(182, 703, 10689, 'The therapeutic efficacy of Tramadol can be decreased when used in combination with Amiodarone'),
	(183, 703, 6375, 'Amiodarone may increase the orthostatic hypotensive activities of Levodopa'),
	(184, 703, 1760, 'The metabolism of Bromocriptine can be decreased when combined with Amiodarone'),
	(185, 703, 6448, 'Lithium may increase the QTc-prolonging activities of Amiodarone'),
	(186, 703, 11118, 'The metabolism of Valproic Acid can be decreased when combined with Amiodarone'),
	(187, 703, 11289, 'Amiodarone may increase the anticoagulant activities of Warfarin'),
	(188, 703, 4637, 'The metabolism of Galantamine can be decreased when combined with Amiodarone'),
	(189, 703, 6851, 'The serum concentration of Methotrexate can be decreased when it is combined with Amiodarone'),
	(190, 703, 6468, 'The metabolism of Loperamide can be decreased when combined with Amiodarone'),
	(191, 83367, 1760, 'The serum concentration of Bromocriptine can be increased when it is combined with Atorvastatin'),
	(192, 83367, 11289, 'Atorvastatin may increase the anticoagulant activities of Warfarin'),
	(193, 83367, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Atorvastatin'),
	(194, 83367, 6468, 'The serum concentration of Loperamide can be increased when it is combined with Atorvastatin'),
	(195, 217713, 10689, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Sumatriptan'),
	(196, 217713, 1760, 'Bromocriptine may increase the vasoconstricting activities of Sumatriptan'),
	(197, 217713, 6448, 'The risk or severity of adverse effects can be increased when Sumatriptan is combined with Lithium'),
	(198, 217713, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Sumatriptan'),
	(199, 217713, 6468, 'The serum concentration of Loperamide can be increased when it is combined with Sumatriptan'),
	(200, 10689, 6375, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Levodopa'),
	(201, 10689, 1760, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Bromocriptine'),
	(202, 10689, 6448, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Lithium'),
	(203, 10689, 11118, 'The risk or severity of adverse effects can be increased when Tramadol is combined with Valproic Acid'),
	(204, 10689, 11289, 'Tramadol may increase the anticoagulant activities of Warfarin'),
	(205, 6375, 1760, 'Bromocriptine may increase the orthostatic hypotensive activities of Levodopa'),
	(206, 6375, 6448, 'The risk or severity of adverse effects can be increased when Lithium is combined with Levodopa'),
	(207, 6375, 11118, 'The risk or severity of adverse effects can be increased when Valproic Acid is combined with Levodopa'),
	(208, 1760, 6448, 'The risk or severity of adverse effects can be increased when Bromocriptine is combined with Lithium'),
	(209, 1760, 6851, 'The serum concentration of Methotrexate can be increased when it is combined with Bromocriptine'),
	(210, 1760, 6468, 'The serum concentration of Loperamide can be increased when it is combined with Bromocriptine'),
	(211, 6448, 11118, 'The risk or severity of adverse effects can be increased when Valproic Acid is combined with Lithium'),
	(212, 11118, 11289, 'The metabolism of Warfarin can be decreased when combined with Valproic Acid'),
	(213, 11289, 327361, 'The serum concentration of Warfarin can be decreased when it is combined with Adalimumab'),
	(214, 191831, 327361, 'Adalimumab may increase the immunosuppressive activities of Infliximab'),
	(215, 6851, 6468, 'The serum concentration of Methotrexate can be increased when it is combined with Loperamide'),
	(216, 6851, 723, 'The serum concentration of Methotrexate can be increased when it is combined with Amoxicillin');
/*!40000 ALTER TABLE `drug_interaction` ENABLE KEYS */;

-- Dumping structure for table dac.frequency
CREATE TABLE IF NOT EXISTS `frequency` (
  `FREQUENCY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FREQUENCY` int(11) NOT NULL,
  PRIMARY KEY (`FREQUENCY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.frequency: ~2 rows (approximately)
/*!40000 ALTER TABLE `frequency` DISABLE KEYS */;
REPLACE INTO `frequency` (`FREQUENCY_ID`, `FREQUENCY`) VALUES
	(1, 60),
	(4, 5),
	(5, 1);
/*!40000 ALTER TABLE `frequency` ENABLE KEYS */;

-- Dumping structure for table dac.lab
CREATE TABLE IF NOT EXISTS `lab` (
  `LAB_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LAB_NAME` varchar(50) NOT NULL,
  `LAB_DESCRIPTION` varchar(50) NOT NULL,
  PRIMARY KEY (`LAB_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.lab: ~40 rows (approximately)
/*!40000 ALTER TABLE `lab` DISABLE KEYS */;
REPLACE INTO `lab` (`LAB_ID`, `LAB_NAME`, `LAB_DESCRIPTION`) VALUES
	(1, 'RBC', 'Red Blood Cell Count'),
	(2, 'Hemoglobin', 'Hemoglobin'),
	(3, 'Hematocrit', 'Hematocrit'),
	(4, 'WBC', 'White Blood Cell Count'),
	(5, 'Platelet Count', 'Platelet'),
	(6, 'MCV', 'Mean Corpuscular Volume'),
	(7, 'BUN', 'Blood Urea Nitrogen'),
	(8, 'Ca', 'Calcium'),
	(9, 'CO2', 'Bicarbonate'),
	(10, 'Cl', 'Chloride'),
	(11, 'Creatinine', 'Creatinine'),
	(12, 'Na', 'Sodium'),
	(13, 'K', 'Potassium '),
	(14, 'Glucose', 'Glucose'),
	(15, 'Insulin', 'Insulin '),
	(16, 'Hemoglobin A1c', 'Hemoglobin A1c'),
	(17, 'Total cholesterol', 'Total cholesterol'),
	(18, 'Triglyceride', 'Triglyceride'),
	(19, 'LDL', 'Low Density Lipoprotein'),
	(20, 'HDL', 'High Density Lipoprotein '),
	(21, 'ABG', 'Arterial Blood Gas'),
	(22, 'Mucus Gram Stain', 'Culter the Mucus'),
	(23, 'Blood Culture', 'Blood Culture'),
	(24, 'ESR', 'Erythrocyte Sedimentation Rate - RA '),
	(25, 'CRP', 'C-Reactive Protein - RA'),
	(26, 'RF', 'Rheumatoid factor '),
	(27, 'TSH', 'Thyroid Stimulating Hormone'),
	(28, 'T3', 'Thyroid hormone'),
	(29, 'T4', 'Thyroid hormone'),
	(30, 'ALT', 'Alanine transaminase'),
	(31, 'AST', 'Aspartate transaminase'),
	(32, 'ALP', 'Alkaline phosphatase'),
	(33, 'Albumin', 'Albumin'),
	(34, 'Bilirubin', 'Bilirubin'),
	(35, 'GGT', 'Gamma-glutamyltransferase'),
	(36, 'LD', 'L-lactate dehydrogenase'),
	(37, 'PT', 'Prothrombin time'),
	(38, 'PTT', 'Partial thromboplastin time'),
	(39, 'Uric acid', 'Uric acid- psoriasis'),
	(40, 'Rapid Strep Test', 'Rapid strep test');
/*!40000 ALTER TABLE `lab` ENABLE KEYS */;

-- Dumping structure for table dac.lab_pulled
CREATE TABLE IF NOT EXISTS `lab_pulled` (
  `LAB_PULLED_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_TAKEN` date NOT NULL,
  `PATIENT_ID` int(11) NOT NULL,
  `LAB_ID` int(11) NOT NULL,
  `DOCTOR_ID` int(11) NOT NULL,
  `VALUE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`LAB_PULLED_ID`),
  KEY `doctor_lab_pulled_fk` (`DOCTOR_ID`),
  KEY `patient_lab_pulled_fk` (`PATIENT_ID`),
  KEY `lab_id_fk` (`LAB_ID`),
  CONSTRAINT `doctor_lab_pulled_fk` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `lab_id_fk` FOREIGN KEY (`LAB_ID`) REFERENCES `lab` (`LAB_ID`),
  CONSTRAINT `patient_lab_pulled_fk` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.lab_pulled: ~19 rows (approximately)
/*!40000 ALTER TABLE `lab_pulled` DISABLE KEYS */;
REPLACE INTO `lab_pulled` (`LAB_PULLED_ID`, `DATE_TAKEN`, `PATIENT_ID`, `LAB_ID`, `DOCTOR_ID`, `VALUE`) VALUES
	(1, '2017-02-03', 11, 20, 6, '37'),
	(2, '2017-02-03', 11, 18, 6, '82'),
	(3, '2017-02-03', 11, 14, 6, '84'),
	(4, '2017-02-03', 11, 16, 6, '5.1'),
	(5, '2017-03-04', 11, 17, 6, '159'),
	(6, '2017-02-03', 11, 19, 6, '106'),
	(7, '2016-02-05', 11, 20, 6, '37'),
	(8, '2016-02-05', 11, 18, 6, '44'),
	(9, '2016-02-05', 11, 14, 5, '91'),
	(10, '2016-02-05', 11, 16, 6, '5.2'),
	(11, '2016-02-05', 11, 17, 6, '153'),
	(12, '2016-02-05', 11, 19, 6, '100'),
	(13, '2016-08-16', 11, 20, 6, '37'),
	(14, '2016-08-16', 11, 18, 6, '69'),
	(15, '2016-08-16', 11, 14, 6, '75'),
	(16, '2016-08-16', 11, 16, 6, '5.1'),
	(17, '2017-03-15', 11, 17, 6, '157'),
	(18, '2016-08-16', 11, 19, 6, '102'),
	(19, '2015-03-08', 11, 17, 6, '200');
/*!40000 ALTER TABLE `lab_pulled` ENABLE KEYS */;

-- Dumping structure for table dac.medical_condition
CREATE TABLE IF NOT EXISTS `medical_condition` (
  `MEDICAL_CONDITION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MC_NAME` varchar(50) NOT NULL,
  `MC_DESCRIPTION` longtext NOT NULL,
  `MC_URL` varchar(100) NOT NULL,
  PRIMARY KEY (`MEDICAL_CONDITION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.medical_condition: ~27 rows (approximately)
/*!40000 ALTER TABLE `medical_condition` DISABLE KEYS */;
REPLACE INTO `medical_condition` (`MEDICAL_CONDITION_ID`, `MC_NAME`, `MC_DESCRIPTION`, `MC_URL`) VALUES
	(1, 'Asthma', '&lt;p&gt;&lt;span class="qt0"&gt;Asthma&lt;/span&gt; is a chronic disease that affects your airways. Your airways are tubes that carry air in and out of your lungs. If you have &lt;span class="qt0"&gt;asthma&lt;/span&gt;, the inside walls of your airways become sore and swollen. That makes them very sensitive, and they may react strongly to things that you are allergic to or find irritating. When your airways react, they get narrower and your lungs get less air.&lt;/p&gt;&lt;p&gt;Symptoms of &lt;span class="qt0"&gt;asthma&lt;/span&gt; include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Wheezing&lt;/li&gt;&lt;li&gt;Coughing, especially early in the morning or at night&lt;/li&gt;&lt;li&gt;Chest tightness&lt;/li&gt;&lt;li&gt;Shortness of breath&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Not all people who have &lt;span class="qt0"&gt;asthma&lt;/span&gt; have these symptoms. Having these symptoms doesn\'t always mean that you have &lt;span class="qt0"&gt;asthma&lt;/span&gt;. Your doctor will diagnose &lt;span class="qt0"&gt;asthma&lt;/span&gt; based on lung function tests, your medical history, and a physical exam. You may also have allergy tests.&lt;/p&gt;&lt;p&gt;When your &lt;span class="qt0"&gt;asthma&lt;/span&gt; symptoms become worse than usual, it\'s called an &lt;span class="qt0"&gt;asthma&lt;/span&gt; attack. Severe &lt;span class="qt0"&gt;asthma&lt;/span&gt; attacks may require emergency care, and they can be fatal.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Asthma&lt;/span&gt; is treated with two kinds of medicines: quick-relief medicines to stop &lt;span class="qt0"&gt;asthma&lt;/span&gt; symptoms and long-term control medicines to prevent symptoms. &lt;/p&gt;&lt;p&gt;NIH: National Heart, Lung, and Blood Institute&lt;/p&gt;', 'https://medlineplus.gov/asthma.html'),
	(2, 'Diabetes', '&lt;p&gt;&lt;span class="qt0"&gt;Diabetes&lt;/span&gt; is a disease in which your blood glucose, or blood sugar, levels are too high.  Glucose comes from the foods you eat. Insulin is a hormone that helps the glucose get into your cells to give them energy.  With type 1 &lt;span class="qt0"&gt;diabetes&lt;/span&gt;, your body does not make insulin.  With type 2 &lt;span class="qt0"&gt;diabetes&lt;/span&gt;, the more common type, your body does not make or use insulin well. Without enough insulin, the glucose stays in your blood. You can also have prediabetes.  This means that your blood sugar is higher than normal but not high enough to be called &lt;span class="qt0"&gt;diabetes&lt;/span&gt;.  Having prediabetes puts you at a higher risk of getting type 2 &lt;span class="qt0"&gt;diabetes&lt;/span&gt;.&lt;/p&gt;&lt;p&gt;Over time, having too much glucose in your blood can cause serious problems.    It can damage your eyes, kidneys, and nerves. &lt;span class="qt0"&gt;Diabetes&lt;/span&gt; can also cause heart disease, stroke and even the need to remove a limb. Pregnant women can also get &lt;span class="qt0"&gt;diabetes&lt;/span&gt;, called gestational &lt;span class="qt0"&gt;diabetes&lt;/span&gt;.&lt;/p&gt;&lt;p&gt;Blood tests can show if you have &lt;span class="qt0"&gt;diabetes&lt;/span&gt;. One type of test, the A1C, can also check on how you are managing your &lt;span class="qt0"&gt;diabetes&lt;/span&gt;. Exercise, weight control and sticking to your meal plan can help control your &lt;span class="qt0"&gt;diabetes&lt;/span&gt;. You should also monitor your blood glucose level and take medicine if prescribed. \n&lt;/p&gt;&lt;p&gt;NIH: National Institute of &lt;span class="qt0"&gt;Diabetes&lt;/span&gt; and Digestive and Kidney Diseases&lt;/p&gt;', 'https://medlineplus.gov/diabetes.html'),
	(3, 'Hypertension', '&lt;p&gt;Blood pressure is the force of your blood pushing against the walls of your arteries. Each time your heart beats, it pumps blood into the arteries. Your &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;blood pressure is highest&lt;/span&gt;&lt;/span&gt; when your heart beats, pumping the blood. This is called systolic pressure. When your heart is at rest, between beats, your blood pressure falls. This is called diastolic pressure. &lt;/p&gt;&lt;p&gt;Your blood pressure reading uses these two numbers. Usually the systolic number comes before or above the diastolic number. A reading of&lt;/p&gt;&lt;ul&gt;&lt;li&gt;119/79 or lower is normal blood pressure&lt;/li&gt;&lt;li&gt;140/90 or higher is &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;high blood pressure&lt;/span&gt;&lt;/span&gt;&lt;/li&gt;&lt;li&gt;Between 120 and 139 for the top number, or between 80 and 89 for the bottom number is called prehypertension. Prehypertension means you may end up with &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;high blood pressure&lt;/span&gt;&lt;/span&gt;, unless you take steps to prevent it.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;High blood pressure&lt;/span&gt;&lt;/span&gt; usually has no symptoms, but it can cause serious problems such as stroke, heart failure, heart attack and kidney failure.&lt;/p&gt;&lt;p&gt;You can control &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;high blood pressure&lt;/span&gt;&lt;/span&gt; through healthy lifestyle habits such as exercise and the DASH diet and taking medicines, if needed. &lt;/p&gt;&lt;p&gt;NIH: National Heart, Lung, and Blood Institute&lt;/p&gt;', 'https://medlineplus.gov/highbloodpressure.html'),
	(4, 'Depression', '&lt;p&gt;&lt;span class="qt0"&gt;Depression&lt;/span&gt; is a serious medical illness. It\'s more than just a feeling of being sad or "blue" for a few days. If you are one of the more than 19 million teens and adults in the United States who have &lt;span class="qt0"&gt;depression&lt;/span&gt;, the feelings do not go away. They persist and interfere with your everyday life. Symptoms can include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Feeling sad or "empty"&lt;/li&gt;&lt;li&gt;Loss of interest in favorite activities&lt;/li&gt;&lt;li&gt;Overeating, or not wanting to eat at all&lt;/li&gt;&lt;li&gt;Not being able to sleep, or sleeping too much&lt;/li&gt;&lt;li&gt;Feeling very tired&lt;/li&gt;&lt;li&gt;Feeling hopeless, irritable, anxious, or guilty&lt;/li&gt;&lt;li&gt;Aches or pains, headaches, cramps, or digestive problems&lt;/li&gt;&lt;li&gt;Thoughts of death or suicide&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;span class="qt0"&gt;Depression&lt;/span&gt; is a disorder of the brain. There are a variety of causes, including genetic, biological, environmental, and psychological factors. &lt;span class="qt0"&gt;Depression&lt;/span&gt; can happen at any age, but it often begins in teens and young adults. It is much more common in women. Women can also get  postpartum &lt;span class="qt0"&gt;depression&lt;/span&gt; after the birth of a baby. Some people get seasonal affective disorder in the winter. &lt;span class="qt0"&gt;Depression&lt;/span&gt; is one part of bipolar disorder.&lt;/p&gt;&lt;p&gt;There are effective treatments for &lt;span class="qt0"&gt;depression&lt;/span&gt;, including antidepressants, talk therapy, or both.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Mental Health&lt;/p&gt;', 'https://medlineplus.gov/depression.html'),
	(5, 'Anxiety', '&lt;p&gt;Fear and &lt;span class="qt0"&gt;anxiety&lt;/span&gt; are part of life. You may feel &lt;span class="qt0"&gt;anxious&lt;/span&gt; before you take a test or walk down a dark street. This kind of &lt;span class="qt0"&gt;anxiety&lt;/span&gt; is useful - it can make you more alert or careful. It usually ends soon after you are out of the situation that caused it. But for millions of people in the United States, the &lt;span class="qt0"&gt;anxiety&lt;/span&gt; does not go away, and gets worse over time. They may have chest pains or nightmares. They may even be afraid to leave home.  These people have &lt;span class="qt0"&gt;anxiety&lt;/span&gt; disorders.  Types include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Panic disorder&lt;/li&gt;&lt;li&gt;Obsessive-compulsive disorder&lt;/li&gt;&lt;li&gt;Post-traumatic &lt;span class="qt0"&gt;stress&lt;/span&gt; disorder&lt;/li&gt;&lt;li&gt;Phobias&lt;/li&gt;&lt;li&gt;Generalized &lt;span class="qt0"&gt;anxiety&lt;/span&gt; disorder &lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Treatment can involve medicines, therapy or both.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Mental Health &lt;/p&gt;', 'https://medlineplus.gov/anxiety.html'),
	(6, 'Obesity ', '&lt;p&gt;&lt;span class="qt0"&gt;Obesity&lt;/span&gt; means having too much body &lt;span class="qt0"&gt;fat&lt;/span&gt;. It is different from being &lt;span class="qt0"&gt;overweight&lt;/span&gt;, which means weighing too much.  The weight may come from muscle, bone, &lt;span class="qt0"&gt;fat&lt;/span&gt;, and/or body water.  Both terms mean that a person\'s weight is greater than what\'s considered healthy for his or her height. &lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Obesity&lt;/span&gt; occurs over time when you eat more calories than you use. The balance between calories-in and calories-out differs for each person. Factors that might affect your weight include your genetic makeup, overeating, eating high-&lt;span class="qt0"&gt;fat&lt;/span&gt; foods, and not being physically active. &lt;/p&gt;&lt;p&gt;Being obese increases your risk of diabetes, heart disease, stroke, arthritis, and some cancers. If you are obese, losing even 5 to 10 percent of your weight can delay or prevent some of these diseases. For example, that means losing 10 to 20 pounds if you weigh 200 pounds.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Diabetes and Digestive and Kidney Diseases&lt;/p&gt;', 'https://medlineplus.gov/obesity.html'),
	(7, 'Pneumonia', '&lt;p&gt;&lt;span class="qt0"&gt;Pneumonia&lt;/span&gt; is an infection in one or both of the lungs. Many germs, such as bacteria, viruses, and fungi, can cause &lt;span class="qt0"&gt;pneumonia&lt;/span&gt;.  You can also get &lt;span class="qt0"&gt;pneumonia&lt;/span&gt; by inhaling a liquid or chemical. People most at risk are older than 65 or younger than 2 years of age, or already have health problems.&lt;/p&gt;&lt;p&gt;Symptoms of &lt;span class="qt0"&gt;pneumonia&lt;/span&gt; vary from mild to severe. See your doctor promptly if you&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Have a high fever&lt;/li&gt;&lt;li&gt;Have shaking chills&lt;/li&gt;&lt;li&gt;Have a cough with phlegm that doesn\'t improve or gets worse&lt;/li&gt;&lt;li&gt;Develop shortness of breath with normal daily activities&lt;/li&gt;&lt;li&gt;Have chest pain when you breathe or cough&lt;/li&gt;&lt;li&gt;Feel suddenly worse after a cold or the flu&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Your doctor will use your medical history, a physical exam, and lab tests to diagnose &lt;span class="qt0"&gt;pneumonia&lt;/span&gt;. Treatment depends on what kind you have. If bacteria are the cause, antibiotics should help.  If you have viral &lt;span class="qt0"&gt;pneumonia&lt;/span&gt;, your doctor may prescribe an antiviral medicine to treat it.&lt;/p&gt;&lt;p&gt;Preventing &lt;span class="qt0"&gt;pneumonia&lt;/span&gt; is always better than treating it. Vaccines are available to prevent pneumococcal &lt;span class="qt0"&gt;pneumonia&lt;/span&gt; and the flu. Other preventive measures include washing your hands frequently and not smoking.&lt;/p&gt;&lt;p&gt;NIH: National Heart, Lung, and Blood Institute&lt;/p&gt;', 'https://medlineplus.gov/pneumonia.html'),
	(8, 'Arthritis', '&lt;p&gt;If you feel pain and stiffness in your body or have trouble moving around, you might have &lt;span class="qt0"&gt;arthritis&lt;/span&gt;. Most kinds of &lt;span class="qt0"&gt;arthritis&lt;/span&gt; cause pain and swelling in your joints. Joints are places where two bones meet, such as your elbow or knee. Over time, a swollen joint can become severely damaged. Some kinds of &lt;span class="qt0"&gt;arthritis&lt;/span&gt; can also cause problems in your organs, such as your eyes or skin.&lt;/p&gt;&lt;p&gt;Types of &lt;span class="qt0"&gt;arthritis&lt;/span&gt; include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;span class="qt0"&gt;Osteoarthritis&lt;/span&gt; is the most common type of &lt;span class="qt0"&gt;arthritis&lt;/span&gt;. It\'s often related to aging or to an injury.&lt;/li&gt;&lt;li&gt;Autoimmune &lt;span class="qt0"&gt;arthritis&lt;/span&gt; happens when your body\'s immune system attacks healthy cells in your body by mistake. Rheumatoid &lt;span class="qt0"&gt;arthritis&lt;/span&gt; is the most common form of this kind of &lt;span class="qt0"&gt;arthritis&lt;/span&gt;.&lt;/li&gt;&lt;li&gt;Juvenile &lt;span class="qt0"&gt;arthritis&lt;/span&gt; is a type of &lt;span class="qt0"&gt;arthritis&lt;/span&gt; that happens in  children.&lt;/li&gt;&lt;li&gt;Infectious &lt;span class="qt0"&gt;arthritis&lt;/span&gt; is an infection that has spread from another part of the body to the joint.&lt;/li&gt;&lt;li&gt;Psoriatic &lt;span class="qt0"&gt;arthritis&lt;/span&gt; affects people with psoriasis.&lt;/li&gt;&lt;li&gt;Gout is a painful type of &lt;span class="qt0"&gt;arthritis&lt;/span&gt; that happens when too much uric acid builds up in the body. It often starts in the big toe.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;NIH: National Institute of &lt;span class="qt0"&gt;Arthritis&lt;/span&gt; and Musculoskeletal and Skin Diseases&lt;/p&gt;', 'https://medlineplus.gov/arthritis.html'),
	(9, 'Flu', '&lt;p&gt;&lt;span class="qt0"&gt;Flu&lt;/span&gt; is a respiratory infection caused by a number of viruses. The viruses pass through the air and enter your body through your nose or mouth. Between 5% and 20% of people in the U.S. get the &lt;span class="qt0"&gt;flu&lt;/span&gt; each year.   The &lt;span class="qt0"&gt;flu&lt;/span&gt; can be serious or even deadly for elderly people, newborn babies, and people with certain chronic illnesses.&lt;/p&gt;&lt;p&gt;Symptoms of the &lt;span class="qt0"&gt;flu&lt;/span&gt; come on suddenly and are worse than those of the common cold. They may include\n&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Body or muscle aches&lt;/li&gt;&lt;li&gt;Chills &lt;/li&gt;&lt;li&gt;Cough &lt;/li&gt;&lt;li&gt;Fever &lt;/li&gt;&lt;li&gt;Headache &lt;/li&gt;&lt;li&gt;Sore throat &lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Is it a cold or the &lt;span class="qt0"&gt;flu&lt;/span&gt;?  Colds rarely cause a fever or headaches.  &lt;span class="qt0"&gt;Flu&lt;/span&gt; almost never causes an upset stomach.  And &lt;span class="qt0"&gt;"stomach flu"&lt;/span&gt;  isn\'t really &lt;span class="qt0"&gt;flu&lt;/span&gt; at all, but gastroenteritis.&lt;/p&gt;&lt;p&gt;Most people with the &lt;span class="qt0"&gt;flu&lt;/span&gt; recover on their own without medical care. People with mild cases of the &lt;span class="qt0"&gt;flu&lt;/span&gt; should stay home and avoid contact with others, except to get medical care. If you get the &lt;span class="qt0"&gt;flu&lt;/span&gt;, your health care provider may prescribe medicine to help your body fight the infection and lessen symptoms. &lt;/p&gt;&lt;p&gt;The main way to keep from getting the &lt;span class="qt0"&gt;flu&lt;/span&gt; is to get a yearly &lt;span class="qt0"&gt;flu&lt;/span&gt; vaccine. Good hygiene, including hand washing, can also help.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Allergy and Infectious Diseases&lt;/p&gt;', 'https://medlineplus.gov/arthritis.html'),
	(10, 'Hypothyroidism', '&lt;p&gt;Your thyroid is a butterfly-shaped gland in your neck, just above your collarbone. It is one of your endocrine glands, which make hormones. Thyroid hormones control the rate of many activities in your body. These include how fast you burn calories and how fast your heart beats. All of these activities are your body\'s metabolism.  If your thyroid gland is not active enough, it does not make enough thyroid hormone to meet your body\'s needs. This condition is &lt;span class="qt0"&gt;hypothyroidism&lt;/span&gt;.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Hypothyroidism&lt;/span&gt; is more common in women, people with other thyroid problems, and those over 60 years old. Hashimoto\'s disease, an autoimmune disorder, is the most common cause.  Other causes include thyroid nodules, thyroiditis, congenital &lt;span class="qt0"&gt;hypothyroidism&lt;/span&gt;, surgical removal of part or all of the thyroid, radiation treatment of the thyroid, and some medicines.&lt;/p&gt;&lt;p&gt;The symptoms can vary from person to person.  They may include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Fatigue&lt;/li&gt;&lt;li&gt;Weight gain&lt;/li&gt;&lt;li&gt;A puffy face&lt;/li&gt;&lt;li&gt;Cold intolerance&lt;/li&gt;&lt;li&gt;Joint and muscle pain&lt;/li&gt;&lt;li&gt;Constipation&lt;/li&gt;&lt;li&gt;Dry skin&lt;/li&gt;&lt;li&gt;Dry, thinning hair&lt;/li&gt;&lt;li&gt;Decreased sweating&lt;/li&gt;&lt;li&gt;Heavy or irregular menstrual periods and fertility problems&lt;/li&gt;&lt;li&gt;Depression&lt;/li&gt;&lt;li&gt;Slowed heart rate&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;To diagnose &lt;span class="qt0"&gt;hypothyroidism&lt;/span&gt;, your doctor will do a physical exam, look at your symptoms, and do thyroid tests. Treatment is with synthetic thyroid hormone, taken every day.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Diabetes and Digestive and Kidney Diseases&lt;/p&gt;', 'https://medlineplus.gov/hypothyroidism.html'),
	(11, 'Attention Deficit Disorder', '&lt;p&gt;Is it hard for your child to sit still? Does your child act without thinking first? Does your child start but not finish things? If so, your child may have &lt;span class="qt0"&gt;attention&lt;/span&gt; &lt;span class="qt1"&gt;deficit&lt;/span&gt; hyperactivity &lt;span class="qt3"&gt;disorder (&lt;/span&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt3"&gt;ADHD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;). Nearly everyone shows some of these behaviors at times, but &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt3"&gt;ADHD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt; lasts more than 6 months and causes problems in school, at home and in social situations.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt3"&gt;ADHD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt; is more common in boys than girls. It affects 3-5 percent of all American children.&lt;/p&gt;&lt;p&gt;The main features of &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt3"&gt;ADHD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt; are&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Inattention&lt;/li&gt;&lt;li&gt;Hyperactivity&lt;/li&gt;&lt;li&gt;Impulsivity&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;No one knows exactly what causes &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt3"&gt;ADHD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;. It sometimes runs in families, so genetics may be a factor. There may also be environmental factors.&lt;/p&gt;&lt;p&gt;A complete evaluation by a trained professional is the only way to know for sure if your child has &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt3"&gt;ADHD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;.  Treatment may include medicine to control symptoms, therapy, or both. Structure at home and at school is important. Parent training may also help.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Mental Health &lt;/p&gt;', 'https://medlineplus.gov/attentiondeficithyperactivitydisorder.html'),
	(12, 'Fibromyalgia', '&lt;p&gt;&lt;span class="qt0"&gt;Fibromyalgia&lt;/span&gt; is a disorder that causes muscle pain and fatigue. People with &lt;span class="qt0"&gt;fibromyalgia&lt;/span&gt; have "tender points" on the body. Tender points are specific places on the neck, shoulders, back, hips, arms, and legs. These points hurt when pressure is put on them.&lt;/p&gt;&lt;p&gt;People with &lt;span class="qt0"&gt;fibromyalgia&lt;/span&gt; may also have other symptoms, such as&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Trouble sleeping&lt;/li&gt;&lt;li&gt;Morning stiffness&lt;/li&gt;&lt;li&gt;Headaches&lt;/li&gt;&lt;li&gt;Painful menstrual periods&lt;/li&gt;&lt;li&gt;Tingling or numbness in hands and feet&lt;/li&gt;&lt;li&gt;Problems with thinking and memory (sometimes called "fibro fog")&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;No one knows what causes &lt;span class="qt0"&gt;fibromyalgia&lt;/span&gt;. Anyone can get it, but it is most common in middle-aged women. People with rheumatoid arthritis and other autoimmune diseases are particularly likely to develop &lt;span class="qt0"&gt;fibromyalgia&lt;/span&gt;. There is no cure for &lt;span class="qt0"&gt;fibromyalgia&lt;/span&gt;, but medicine can help you manage your symptoms. Getting enough sleep, exercising, and eating well may also help.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Arthritis and Musculoskeletal and Skin Diseases&lt;/p&gt;', 'https://medlineplus.gov/fibromyalgia.html'),
	(13, 'Arrhythmia', '&lt;p&gt;An &lt;span class="qt0"&gt;arrhythmia&lt;/span&gt; is a problem with the rate or rhythm of your heartbeat. It means that your heart beats too quickly, too slowly, or with an irregular pattern. When the heart beats faster than normal, it is called tachycardia. When the heart beats too slowly, it is called bradycardia. The most common type of &lt;span class="qt0"&gt;arrhythmia&lt;/span&gt; is atrial fibrillation, which causes an irregular and fast heart beat.&lt;/p&gt;&lt;p&gt;Many factors can affect your heart\'s rhythm, such as having had a heart attack, smoking, congenital heart defects, and stress. Some substances or medicines may also cause &lt;span class="qt1"&gt;arrhythmias&lt;/span&gt;. &lt;/p&gt;&lt;p&gt;Symptoms of &lt;span class="qt1"&gt;arrhythmias&lt;/span&gt; include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Fast or slow heart beat&lt;/li&gt;&lt;li&gt;Skipping beats&lt;/li&gt;&lt;li&gt;Lightheadedness or dizziness&lt;/li&gt;&lt;li&gt;Chest pain&lt;/li&gt;&lt;li&gt;Shortness of breath &lt;/li&gt;&lt;li&gt;Sweating &lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Your doctor can run tests to find out if you have an &lt;span class="qt0"&gt;arrhythmia&lt;/span&gt;. Treatment to restore a normal heart rhythm may include medicines, an implantable cardioverter-defibrillator (ICD) or pacemaker, or sometimes surgery. &lt;/p&gt;&lt;p&gt;NIH: National Heart, Lung, and Blood Institute&lt;/p&gt;', 'https://medlineplus.gov/arrhythmia.html'),
	(14, 'Coronary Artery Disease', '&lt;p&gt;&lt;span class="qt0"&gt;Coronary&lt;/span&gt; &lt;span class="qt1"&gt;artery&lt;/span&gt; &lt;span class="qt2"&gt;disease&lt;/span&gt; (CAD) is the most common type of &lt;span class="qt0"&gt;&lt;span class="qt3"&gt;heart&lt;/span&gt;&lt;/span&gt;&lt;span class="qt3"&gt; &lt;/span&gt;&lt;span class="qt2"&gt;&lt;span class="qt3"&gt;disease&lt;/span&gt;&lt;/span&gt;. It is the leading cause of death in the United States in both men and women.&lt;/p&gt;&lt;p&gt;CAD happens when the &lt;span class="qt1"&gt;arteries&lt;/span&gt; that supply blood to &lt;span class="qt0"&gt;heart&lt;/span&gt; muscle become hardened and narrowed. This is due to the buildup of cholesterol and other material, called plaque, on their inner walls. This buildup is called atherosclerosis. As it grows, less blood can flow through the &lt;span class="qt1"&gt;arteries&lt;/span&gt;. As a result, the &lt;span class="qt0"&gt;heart&lt;/span&gt; muscle can\'t get the blood or oxygen it needs. This can lead to chest pain (angina) or a &lt;span class="qt0"&gt;heart&lt;/span&gt; attack.  Most &lt;span class="qt0"&gt;heart&lt;/span&gt; attacks happen when a blood clot suddenly cuts off the &lt;span class="qt0"&gt;hearts&lt;/span&gt;\' blood supply, causing permanent &lt;span class="qt0"&gt;heart&lt;/span&gt; damage.  &lt;/p&gt;&lt;p&gt;Over time, CAD can also weaken the &lt;span class="qt0"&gt;heart&lt;/span&gt; muscle and contribute to &lt;span class="qt0"&gt;heart&lt;/span&gt; failure and arrhythmias. &lt;span class="qt0"&gt;Heart&lt;/span&gt; failure means the &lt;span class="qt0"&gt;heart&lt;/span&gt; can\'t pump blood well to the rest of the body. Arrhythmias are changes in the normal beating rhythm of the &lt;span class="qt0"&gt;heart&lt;/span&gt;.  &lt;/p&gt;&lt;p&gt;NIH: National &lt;span class="qt0"&gt;Heart&lt;/span&gt;, Lung, and Blood Institute&lt;/p&gt;', 'https://medlineplus.gov/coronaryarterydisease.html'),
	(15, 'Emphysema', '&lt;p&gt;&lt;span class="qt0"&gt;Emphysema&lt;/span&gt; is a type of COPD involving damage to the air sacs (alveoli) in the lungs. As a result, your body does not get the oxygen it needs. &lt;span class="qt0"&gt;Emphysema&lt;/span&gt; makes it hard to catch your breath. You may also have a chronic cough and have trouble breathing during exercise.&lt;/p&gt;&lt;p&gt;The most common cause is cigarette smoking. If you smoke, quitting can help prevent you from getting the disease.  If you already have &lt;span class="qt0"&gt;emphysema&lt;/span&gt;, not smoking might keep it from getting worse. Treatment is based on whether your symptoms are mild, moderate or severe. \nTreatments include inhalers, oxygen, medications and sometimes surgery to relieve symptoms and prevent complications.&lt;/p&gt;', 'https://medlineplus.gov/emphysema.html'),
	(16, 'Migraine', '&lt;p&gt;If you suffer from &lt;span class="qt0"&gt;migraine&lt;/span&gt; headaches, you\'re not alone. About 12 percent of the U.S. population gets them.  &lt;span class="qt0"&gt;Migraines&lt;/span&gt; are recurring attacks of moderate to severe pain.  The pain is throbbing or pulsing, and is often on one side of the head. During &lt;span class="qt0"&gt;migraines&lt;/span&gt;, people are very sensitive to light and sound. They may also become nauseated and vomit. &lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Migraine&lt;/span&gt; is three times more common in women than in men. Some people can tell when they are about to have a &lt;span class="qt0"&gt;migraine&lt;/span&gt; because they see flashing lights or zigzag lines or they temporarily lose their vision. &lt;/p&gt;&lt;p&gt;Many things can trigger a &lt;span class="qt0"&gt;migraine&lt;/span&gt;. These include &lt;/p&gt;&lt;ul&gt;&lt;li&gt; Anxiety&lt;/li&gt;&lt;li&gt; Stress&lt;/li&gt;&lt;li&gt; Lack of food or sleep &lt;/li&gt;&lt;li&gt; Exposure to light&lt;/li&gt;&lt;li&gt; Hormonal changes (in women)&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Doctors used to believe &lt;span class="qt0"&gt;migraines&lt;/span&gt; were linked to the opening and narrowing of blood vessels in the head. Now they believe the cause is related to genes that control the activity of some brain cells.  Medicines can help prevent &lt;span class="qt0"&gt;migraine&lt;/span&gt; attacks or help relieve symptoms of attacks when they happen. For many people, treatments to relieve stress can also help.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Neurological Disorders and Stroke&lt;/p&gt;', 'https://medlineplus.gov/migraine.html'),
	(17, 'Parkinsons', '&lt;p&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Parkinson&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt;\'s disease&lt;/span&gt; (PD) is a type of movement disorder. It happens when nerve cells in the brain don\'t produce enough of a brain chemical called dopamine. Sometimes it is genetic, but most cases do not seem to run in families. Exposure to chemicals in the environment might play a role.&lt;/p&gt;&lt;p&gt;Symptoms begin gradually, often on one side of the body.  Later they affect both sides. They  include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Trembling of hands, arms, legs, jaw and face &lt;/li&gt;&lt;li&gt;Stiffness of the arms, legs and trunk &lt;/li&gt;&lt;li&gt;Slowness of movement &lt;/li&gt;&lt;li&gt;Poor balance and coordination &lt;/li&gt;&lt;/ul&gt;&lt;p&gt;As symptoms get worse, people with the disease may have trouble walking, talking, or doing simple tasks. They may also have problems such as depression, sleep problems, or trouble chewing, swallowing, or speaking.&lt;/p&gt;&lt;p&gt;There is no lab test for PD, so it can be difficult to diagnose.  Doctors use a medical history and a neurological examination to diagnose it.&lt;/p&gt;&lt;p&gt;PD usually begins around age 60, but it can start earlier. It is more common in men than in women. There is no cure for PD. A variety of medicines sometimes help symptoms dramatically. Surgery and deep brain stimulation (DBS) can help severe cases. With DBS, electrodes are surgically implanted in the brain. They send electrical pulses to stimulate the parts of the brain that control movement.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Neurological Disorders and Stroke&lt;/p&gt;', 'https://medlineplus.gov/parkinsonsdisease.html'),
	(18, 'Bipolar Disorder', '&lt;p&gt;&lt;span class="qt0"&gt;Bipolar&lt;/span&gt; &lt;span class="qt1"&gt;disorder&lt;/span&gt; is a serious &lt;span class="qt2"&gt;mental illness&lt;/span&gt;. People who have it go through unusual mood changes. They go from very happy, "up," and active to very sad and hopeless, "down," and inactive, and then back again. They often have normal moods in between.  The up feeling is called mania. The down feeling is depression.&lt;/p&gt;&lt;p&gt;The causes of &lt;span class="qt0"&gt;bipolar&lt;/span&gt; &lt;span class="qt1"&gt;disorder&lt;/span&gt; aren\'t always clear. It runs in families. Abnormal brain structure and function may also play a role.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Bipolar&lt;/span&gt; &lt;span class="qt1"&gt;disorder&lt;/span&gt; often starts in a person\'s late teen or early adult years. But children and adults can have &lt;span class="qt0"&gt;bipolar&lt;/span&gt; &lt;span class="qt1"&gt;disorder&lt;/span&gt; too. The &lt;span class="qt2"&gt;illness&lt;/span&gt; usually lasts a lifetime.&lt;/p&gt;&lt;p&gt;If you think you may have it, tell your health care provider. A medical checkup can rule out other illnesses that might cause your mood changes.&lt;/p&gt;&lt;p&gt;If not treated, &lt;span class="qt0"&gt;bipolar&lt;/span&gt; &lt;span class="qt1"&gt;disorder&lt;/span&gt; can lead to damaged relationships, poor job or school performance, and even suicide.  However, there are effective treatments to control symptoms: medicine and talk therapy. A combination usually works best.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Mental Health&lt;/p&gt;', 'https://medlineplus.gov/bipolardisorder.html'),
	(19, 'Tension Headaches', '&lt;p&gt;Almost everyone has had a headache. Headache is the most common form of pain. It\'s a major reason people miss days at work or school or visit the doctor.&lt;/p&gt;&lt;p&gt;The most common &lt;span class="qt2"&gt;type of headache is a &lt;/span&gt;&lt;span class="qt0"&gt;&lt;span class="qt2"&gt;tension&lt;/span&gt;&lt;/span&gt; headache. &lt;span class="qt0"&gt;Tension&lt;/span&gt; &lt;span class="qt1"&gt;headaches&lt;/span&gt; are due to tight muscles in your shoulders, neck, scalp and jaw. They are often related to &lt;span class="qt0"&gt;stress&lt;/span&gt;, depression or &lt;span class="qt0"&gt;anxiety&lt;/span&gt;. You are more likely to get &lt;span class="qt0"&gt;tension&lt;/span&gt; &lt;span class="qt1"&gt;headaches&lt;/span&gt; if you work too much, don\'t get enough sleep, miss meals, or use alcohol.&lt;/p&gt;&lt;p&gt;Other common types of &lt;span class="qt1"&gt;headaches&lt;/span&gt; include migraines, cluster &lt;span class="qt1"&gt;headaches&lt;/span&gt;, and sinus &lt;span class="qt1"&gt;headaches&lt;/span&gt;. Most people can feel much better by making lifestyle changes, learning ways to relax and taking pain relievers.&lt;/p&gt;&lt;p&gt;Not all &lt;span class="qt1"&gt;headaches&lt;/span&gt; require a doctor\'s attention. But sometimes &lt;span class="qt1"&gt;headaches&lt;/span&gt; warn of a more serious disorder. Let your health care provider know if you have sudden, severe &lt;span class="qt1"&gt;headaches&lt;/span&gt;. Get medical help right away if you have a headache after a blow to your head, or if you have a headache along with a stiff neck, fever, confusion, loss of consciousness, or pain in the eye or ear.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Neurological Disorders and Stroke&lt;/p&gt;', 'https://medlineplus.gov/headache.html'),
	(20, 'Ischemic Stroke', '&lt;p&gt;A &lt;span class="qt2"&gt;stroke&lt;/span&gt; is a medical emergency. There are two types - &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;ischemic&lt;/span&gt;&lt;/span&gt; and hemorrhagic. &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Ischemic&lt;/span&gt;&lt;/span&gt; &lt;span class="qt2"&gt;stroke&lt;/span&gt; is the most common type. It is usually caused by a blood clot that blocks or plugs a blood vessel in the brain. This keeps blood from flowing to the brain. Within minutes, brain cells begin to die.  Another cause is stenosis, or narrowing of the artery. This can happen because of atherosclerosis, a disease in which plaque builds up inside your arteries. Transient &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;ischemic&lt;/span&gt;&lt;/span&gt; attacks (TIAs) occur when the blood supply to the brain is interrupted briefly. Having a TIA can mean you are at risk for having a more serious &lt;span class="qt2"&gt;stroke&lt;/span&gt;.&lt;/p&gt;&lt;p&gt;Symptoms of &lt;span class="qt2"&gt;stroke&lt;/span&gt; are&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Sudden numbness or weakness of the face, arm or leg (especially on one side of the body)&lt;/li&gt;&lt;li&gt;Sudden confusion, trouble speaking or understanding speech&lt;/li&gt;&lt;li&gt;Sudden trouble seeing in one or both eyes&lt;/li&gt;&lt;li&gt;Sudden trouble walking, dizziness, loss of balance or coordination&lt;/li&gt;&lt;li&gt;Sudden severe headache with no known cause&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;It is important to treat &lt;span class="qt2"&gt;strokes&lt;/span&gt; as quickly as possible. Blood thinners may be used to stop a &lt;span class="qt2"&gt;stroke&lt;/span&gt; while it is happening by quickly dissolving the blood clot. Post-&lt;span class="qt2"&gt;stroke&lt;/span&gt; rehabilitation can help people overcome disabilities caused by &lt;span class="qt2"&gt;stroke&lt;/span&gt; damage.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Neurological Disorders and &lt;span class="qt2"&gt;Stroke&lt;/span&gt;&lt;/p&gt;</content>\n            <content name="mesh">&lt;span class="qt2"&gt;Stroke&lt;/span&gt;', 'https://medlineplus.gov/ischemicstroke.html'),
	(21, 'Alzheimer\'s', '&lt;p&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Alzheimer&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt;\'s disease&lt;/span&gt; (AD) is the most common form of dementia among older people. Dementia is a brain disorder that seriously affects a person\'s ability to carry out daily activities. &lt;/p&gt;&lt;p&gt;AD begins slowly. It first involves the parts of the brain that control thought, memory and language. People with AD may have trouble remembering things that happened recently or names of people they know. A related problem, mild cognitive impairment (MCI), causes more memory problems than normal for people of the same age.  Many, but not all, people with MCI will develop AD.&lt;/p&gt;&lt;p&gt;In AD, over time, symptoms get worse. People may not recognize family members. They may have trouble speaking, reading or writing. They may forget how to brush their teeth or comb their hair. Later on, they may become anxious or aggressive, or wander away from home. Eventually, they need total care. This can cause great stress for family members who must care for them.&lt;/p&gt;&lt;p&gt;AD usually begins after age 60.  The risk goes up as you get older. Your risk is also higher if a family member has had the disease.&lt;/p&gt;&lt;p&gt; No treatment can stop the disease. However, some drugs may help keep symptoms from getting worse for a limited time.&lt;/p&gt;&lt;p&gt;NIH: National Institute on Aging&lt;/p&gt;</content>\n            <content name="mesh">&lt;span class="qt0"&gt;Alzheimer&lt;/span&gt; Vaccines', 'https://medlineplus.gov/alzheimersdisease.html'),
	(22, 'Chronic Obstructive Pulmonary Disease', '&lt;p&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt2"&gt;&lt;span class="qt3"&gt;&lt;span class="qt4"&gt;COPD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;span class="qt4"&gt; (chronic&lt;/span&gt;&lt;/span&gt;&lt;span class="qt4"&gt; &lt;/span&gt;&lt;span class="qt1"&gt;&lt;span class="qt4"&gt;obstructive&lt;/span&gt;&lt;/span&gt;&lt;span class="qt4"&gt; &lt;/span&gt;&lt;span class="qt2"&gt;&lt;span class="qt4"&gt;pulmonary&lt;/span&gt;&lt;/span&gt;&lt;span class="qt4"&gt; &lt;/span&gt;&lt;span class="qt3"&gt;&lt;span class="qt4"&gt;disease&lt;/span&gt;&lt;/span&gt;) makes it hard for you to breathe. The two main types are &lt;span class="qt0"&gt;chronic&lt;/span&gt; bronchitis and emphysema. The main cause of &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt2"&gt;&lt;span class="qt3"&gt;&lt;span class="qt4"&gt;COPD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt; is long-term exposure to substances that irritate and damage the &lt;span class="qt2"&gt;lungs&lt;/span&gt;. This is usually cigarette smoke. Air pollution, chemical fumes, or dust can also cause it.&lt;/p&gt;&lt;p&gt;At first, &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt2"&gt;&lt;span class="qt3"&gt;&lt;span class="qt4"&gt;COPD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt; may cause no symptoms or only mild symptoms. As the &lt;span class="qt3"&gt;disease&lt;/span&gt; gets worse, symptoms usually become more severe. They include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;A cough that produces a lot of mucus&lt;/li&gt;&lt;li&gt;Shortness of breath, especially with physical activity&lt;/li&gt;&lt;li&gt;Wheezing&lt;/li&gt;&lt;li&gt;Chest tightness&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Doctors use &lt;span class="qt2"&gt;lung&lt;/span&gt; function tests, imaging tests, and blood tests to diagnose &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt2"&gt;&lt;span class="qt3"&gt;&lt;span class="qt4"&gt;COPD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;. There is no cure. Treatments may relieve symptoms. They include medicines, oxygen therapy, surgery, or a &lt;span class="qt2"&gt;lung&lt;/span&gt; transplant. Quitting smoking is the most important step you can take to treat &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;&lt;span class="qt2"&gt;&lt;span class="qt3"&gt;&lt;span class="qt4"&gt;COPD&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;. &lt;/p&gt;&lt;p&gt;NIH: National Heart, &lt;span class="qt2"&gt;Lung&lt;/span&gt;, and Blood Institute&lt;/p&gt;', 'https://medlineplus.gov/copd.html'),
	(23, 'Osteoporosis', '&lt;p&gt;&lt;span class="qt0"&gt;Osteoporosis&lt;/span&gt; is a disease that thins and weakens the bones. Your bones become fragile and break easily, especially the bones in the hip, spine, and wrist. In the United States, millions of people either already have &lt;span class="qt0"&gt;osteoporosis&lt;/span&gt; or are at high risk due to low bone mass.&lt;/p&gt;&lt;p&gt;Anyone can develop &lt;span class="qt0"&gt;osteoporosis&lt;/span&gt;, but it is more common in older women. Risk factors include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Getting older &lt;/li&gt;&lt;li&gt;Being small and thin &lt;/li&gt;&lt;li&gt;Having a family history of &lt;span class="qt0"&gt;osteoporosis&lt;/span&gt;&lt;/li&gt;&lt;li&gt;Taking certain medicines&lt;/li&gt;&lt;li&gt;Being a white or Asian woman&lt;/li&gt;&lt;li&gt;Having low bone density&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;span class="qt0"&gt;Osteoporosis&lt;/span&gt; is a silent disease. You might not know you have it until you break a bone. A bone mineral density test is the best way to check your bone health.&lt;/p&gt;&lt;p&gt;To keep bones strong, eat a diet rich in calcium and vitamin D, exercise, and do not smoke. If needed, medicines can also help. It is also important to try to avoid falling down. Falls are the number one cause of fractures in older adults.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Arthritis and Musculoskeletal and Skin \nDiseases&lt;/p&gt;', 'https://medlineplus.gov/osteoporosis.html'),
	(24, 'Shingles', '>&lt;p&gt;&lt;span class="qt0"&gt;Shingles&lt;/span&gt; is a disease caused by the varicella-zoster virus - the same virus that causes chickenpox. After you have chickenpox, the virus stays in your body. It may not cause problems for many years.  As you get older, the virus may reappear as &lt;span class="qt0"&gt;shingles&lt;/span&gt;. Although it is most common in people over age 50, anyone who has had chickenpox is at risk.&lt;/p&gt;&lt;p&gt;You can\'t catch &lt;span class="qt0"&gt;shingles&lt;/span&gt; from someone who has it.  However, if you have a &lt;span class="qt0"&gt;shingles&lt;/span&gt; rash, you can pass the virus to someone who has never had chickenpox.  This would usually be a child, who could get chickenpox instead of &lt;span class="qt0"&gt;shingles&lt;/span&gt;.  The virus spreads through direct contact with the rash, and cannot spread through the air.&lt;/p&gt;&lt;p&gt;Early signs of &lt;span class="qt0"&gt;shingles&lt;/span&gt; include burning or shooting pain and tingling or itching, usually on one side of the body or face. The pain can be mild to severe. Rashes or blisters appear anywhere from one to 14 days later. If &lt;span class="qt0"&gt;shingles&lt;/span&gt; appears on your face, it may affect your vision or hearing. The pain of &lt;span class="qt0"&gt;shingles&lt;/span&gt; may last for weeks, months, or even years after the blisters have healed. &lt;/p&gt;&lt;p&gt;There is no cure for &lt;span class="qt0"&gt;shingles&lt;/span&gt;. Early treatment with medicines that fight the virus may help. These medicines may also help prevent lingering pain.&lt;/p&gt;&lt;p&gt;A vaccine may prevent &lt;span class="qt0"&gt;shingles&lt;/span&gt; or lessen its effects.  The vaccine is recommended for people 60 or over.  In some cases doctors may give it to people ages 50 to 59.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Allergy and Infectious Diseases&lt;/p&gt;', 'https://medlineplus.gov/shingles.html'),
	(25, 'Crohn\'s', '&lt;p&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Crohn&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt;\'s disease&lt;/span&gt; causes inflammation of the digestive system.  It is one of a group of diseases called inflammatory bowel &lt;span class="qt1"&gt;disease. &lt;/span&gt;&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Crohn&lt;/span&gt;&lt;/span&gt;\'s can affect any area from the mouth to the anus. It often affects the lower part of the small intestine called the ileum.&lt;/p&gt;&lt;p&gt;The cause of &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Crohn&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt;\'s disease&lt;/span&gt; is unknown. It may be due to an abnormal reaction by the body\'s immune system.  It also seems to run in some families. It most commonly starts between the ages of 13 and 30.&lt;/p&gt;&lt;p&gt;The most common symptoms are pain in the abdomen and diarrhea. Other symptoms include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Bleeding from the rectum&lt;/li&gt;&lt;li&gt;Weight loss&lt;/li&gt;&lt;li&gt;Fever&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Your doctor will diagnose &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Crohn&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt;\'s disease&lt;/span&gt; with a physical exam, lab tests, imaging tests, and a colonoscopy.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Crohn&lt;/span&gt;\'s can cause complications, such as intestinal blockages, ulcers in the intestine, and problems getting enough nutrients. People with &lt;span class="qt0"&gt;Crohn&lt;/span&gt;\'s can also have joint pain and skin problems. Children with the disease may have growth problems.&lt;/p&gt;&lt;p&gt;There is no cure for &lt;span class="qt0"&gt;Crohn&lt;/span&gt;\'s. Treatment can help control symptoms, and may include medicines, nutrition supplements, and/or surgery. Some people have long periods of remission, when they are free of symptoms.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Diabetes and Digestive and Kidney Diseases&lt;/p&gt;', 'https://medlineplus.gov/crohnsdisease.html'),
	(26, 'Celiac Disease', '&lt;p&gt;&lt;span class="qt0"&gt;Celiac&lt;/span&gt; &lt;span class="qt1"&gt;disease&lt;/span&gt; is an immune &lt;span class="qt1"&gt;disease&lt;/span&gt; in which people can\'t eat gluten because it will damage their small intestine. If you have &lt;span class="qt0"&gt;celiac&lt;/span&gt; &lt;span class="qt1"&gt;disease&lt;/span&gt; and eat foods with gluten, your immune system responds by damaging the small intestine.  Gluten is a protein found in wheat, rye, and barley. It is found mainly in foods but may also be in other products like medicines, vitamins and supplements, lip balm, and even the glue on stamps and envelopes.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Celiac&lt;/span&gt; &lt;span class="qt1"&gt;disease&lt;/span&gt; affects each person differently. Symptoms may occur in the digestive system, or in other parts of the body. One person might have diarrhea and abdominal pain, while another person may be irritable or depressed. Irritability is one of the most common symptoms in children. Some people have no symptoms.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Celiac&lt;/span&gt; &lt;span class="qt1"&gt;disease&lt;/span&gt; is genetic. Blood tests can help your doctor diagnose the &lt;span class="qt1"&gt;disease&lt;/span&gt;. Your doctor may also need to examine a small piece of tissue from your small intestine. Treatment is a diet free of gluten. &lt;/p&gt;&lt;p&gt;NIH: National Institute of Diabetes and Digestive and Kidney &lt;span class="qt1"&gt;Diseases&lt;/span&gt;&lt;/p&gt;</content>\n            <content name="mesh">&lt;span class="qt0"&gt;Celiac&lt;/span&gt; &lt;span class="qt1"&gt;Disease&lt;/span&gt;', 'https://medlineplus.gov/celiacdisease.html'),
	(27, 'IBS', '&lt;p&gt;&lt;span class="qt1"&gt;Irritable bowel syndrome&lt;/span&gt; (&lt;span class="qt0"&gt;IBS&lt;/span&gt;) is a problem that affects the large intestine. It can cause abdominal cramping, bloating, and a change in bowel habits. Some people with the disorder have constipation. Some have diarrhea. Others go back and forth between the two. Although &lt;span class="qt0"&gt;IBS&lt;/span&gt; can cause a great deal of discomfort, it does not harm the intestines.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;IBS&lt;/span&gt; is  common. It affects about twice as many women as men and is most often found in people younger than 45 years.  No one knows the exact cause of &lt;span class="qt0"&gt;IBS&lt;/span&gt;.  There is no specific test for it. Your doctor may run tests to be sure you don\'t have other diseases. These tests may include stool sampling tests, blood tests, and x-rays. Your doctor may also do a test called a sigmoidoscopy or colonoscopy.  Most people diagnosed with &lt;span class="qt0"&gt;IBS&lt;/span&gt; can control their symptoms with diet, stress management, probiotics, and medicine.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Diabetes and Digestive and Kidney Diseases&lt;/p&gt;', 'https://medlineplus.gov/irritablebowelsyndrome.html'),
	(28, 'Rheumatoid Arthritis', '&lt;p&gt;&lt;span class="qt0"&gt;Rheumatoid&lt;/span&gt; &lt;span class="qt1"&gt;arthritis&lt;/span&gt; (RA) is a form of &lt;span class="qt1"&gt;arthritis&lt;/span&gt; that causes pain, swelling, stiffness and loss of function in your joints. It can affect any joint but is common in the wrist and fingers.&lt;/p&gt;&lt;p&gt;More women than men get &lt;span class="qt0"&gt;rheumatoid&lt;/span&gt; &lt;span class="qt1"&gt;arthritis&lt;/span&gt;. It often starts in middle age and is most common in older people. You might have the disease for only a short time, or symptoms might come and go. The severe form can last a lifetime.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Rheumatoid&lt;/span&gt; &lt;span class="qt1"&gt;arthritis&lt;/span&gt; is different from &lt;span class="qt1"&gt;osteoarthritis&lt;/span&gt;, the common &lt;span class="qt1"&gt;arthritis&lt;/span&gt; that often comes with older age. RA can affect body parts besides joints, such as your eyes, mouth and lungs. RA is an autoimmune disease, which means the &lt;span class="qt1"&gt;arthritis&lt;/span&gt; results from your immune system attacking your body\'s own tissues.&lt;/p&gt;&lt;p&gt;No one knows what causes &lt;span class="qt0"&gt;rheumatoid&lt;/span&gt; &lt;span class="qt1"&gt;arthritis&lt;/span&gt;. Genes, environment, and hormones might contribute. Treatments include medicine, lifestyle changes, and surgery. These can slow or stop joint damage and reduce pain and swelling.&lt;/p&gt;&lt;p&gt;NIH: National Institute of &lt;span class="qt1"&gt;Arthritis&lt;/span&gt; and Musculoskeletal and Skin Diseases&lt;/p&gt;', 'https://medlineplus.gov/rheumatoidarthritis.html'),
	(29, 'Psoriasis', '&lt;p&gt;&lt;span class="qt0"&gt;Psoriasis&lt;/span&gt; is a skin disease that causes itchy or sore patches of thick, red skin with silvery scales. You usually get the patches on your elbows, knees, scalp, back, face, palms and feet, but they can show up on other parts of your body.  Some people who have &lt;span class="qt0"&gt;psoriasis&lt;/span&gt; also get a form of arthritis called &lt;span class="qt0"&gt;psoriatic&lt;/span&gt; arthritis.&lt;/p&gt;&lt;p&gt;A problem with your immune system causes &lt;span class="qt0"&gt;psoriasis&lt;/span&gt;. In a process called cell turnover, skin cells that grow deep in your skin rise to the surface. Normally, this takes a month. In &lt;span class="qt0"&gt;psoriasis&lt;/span&gt;, it happens in just days because your cells rise too fast. &lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Psoriasis&lt;/span&gt; can be hard to diagnose because it can look like other skin diseases. Your doctor might need to look at a small skin sample under a microscope.&lt;/p&gt;&lt;p&gt;&lt;span class="qt0"&gt;Psoriasis&lt;/span&gt; can last a long time, even a lifetime. Symptoms come and go. Things that make them worse include&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Infections&lt;/li&gt;&lt;li&gt;Stress&lt;/li&gt;&lt;li&gt;Dry skin&lt;/li&gt;&lt;li&gt;Certain medicines&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;span class="qt0"&gt;Psoriasis&lt;/span&gt; usually occurs in adults. It sometimes runs in families. Treatments include creams, medicines, and light therapy.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Arthritis and Musculoskeletal and Skin Diseases &lt;/p&gt;', 'https://medlineplus.gov/psoriasis.html'),
	(30, 'Strep', '&lt;p&gt;&lt;span class="qt0"&gt;Strep&lt;/span&gt; is short for &lt;span class="qt0"&gt;Streptococcus&lt;/span&gt;, a type of bacteria.   There are two types: group A and group B.&lt;/p&gt;&lt;p&gt;Group A &lt;span class="qt0"&gt;strep&lt;/span&gt; causes&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;span class="qt0"&gt;Strep&lt;/span&gt; throat - a sore, red throat. Your tonsils may be swollen and have white spots on them.&lt;/li&gt;&lt;li&gt;Scarlet fever - an illness that follows &lt;span class="qt0"&gt;strep&lt;/span&gt; throat. It causes a red rash on the body.&lt;/li&gt;&lt;li&gt;Impetigo - a skin infection&lt;/li&gt;&lt;li&gt;Toxic shock syndrome&lt;/li&gt;&lt;li&gt;Cellulitis and necrotizing fasciitis (flesh-eating disease)&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Group B &lt;span class="qt0"&gt;strep&lt;/span&gt; can cause blood infections, pneumonia and meningitis in newborns. A screening test during pregnancy can tell if you have it. If you do, I.V. antibiotics during labor can save your baby\'s life.  Adults can also get group B &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;strep&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt; infections&lt;/span&gt;, especially if they are elderly or already have health problems. &lt;span class="qt0"&gt;Strep&lt;/span&gt; B can cause urinary tract infections, blood infections, skin infections and pneumonia in adults.&lt;/p&gt;&lt;p&gt;Antibiotics are used to treat &lt;span class="qt0"&gt;&lt;span class="qt1"&gt;strep&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt; infections&lt;/span&gt;.&lt;/p&gt;&lt;p&gt;NIH: National Institute of Allergy and Infectious Diseases &lt;/p&gt;</content>\n            <content name="mesh">&lt;span class="qt0"&gt;&lt;span class="qt1"&gt;Streptococcal&lt;/span&gt;&lt;/span&gt;&lt;span class="qt1"&gt; Infections&lt;/span&gt;', 'https://medlineplus.gov/streptococcalinfections.html');
/*!40000 ALTER TABLE `medical_condition` ENABLE KEYS */;

-- Dumping structure for table dac.medical_history
CREATE TABLE IF NOT EXISTS `medical_history` (
  `MEDICAL_HISTORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_DIAGNOSED` date NOT NULL,
  `PATIENT_ID` int(11) NOT NULL,
  `DATE_RESOLVED` date DEFAULT NULL,
  `MEDICAL_CONDITION_ID` int(11) NOT NULL,
  PRIMARY KEY (`MEDICAL_HISTORY_ID`),
  KEY `medical_condition_current_medical_condition_fk` (`MEDICAL_CONDITION_ID`),
  KEY `patient_current_medical_condition_fk` (`PATIENT_ID`),
  CONSTRAINT `medical_condition_current_medical_condition_fk` FOREIGN KEY (`MEDICAL_CONDITION_ID`) REFERENCES `medical_condition` (`MEDICAL_CONDITION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_current_medical_condition_fk` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.medical_history: ~8 rows (approximately)
/*!40000 ALTER TABLE `medical_history` DISABLE KEYS */;
REPLACE INTO `medical_history` (`MEDICAL_HISTORY_ID`, `DATE_DIAGNOSED`, `PATIENT_ID`, `DATE_RESOLVED`, `MEDICAL_CONDITION_ID`) VALUES
	(1, '2014-07-12', 11, NULL, 11),
	(2, '2016-09-16', 11, '2017-03-21', 16),
	(3, '2009-02-03', 11, '2009-02-20', 7),
	(4, '2001-10-03', 11, '2001-10-13', 30),
	(11, '2017-03-15', 11, NULL, 8),
	(18, '2017-03-14', 11, NULL, 1),
	(20, '2017-03-08', 11, NULL, 10),
	(21, '2017-01-05', 11, NULL, 21);
/*!40000 ALTER TABLE `medical_history` ENABLE KEYS */;

-- Dumping structure for table dac.medication
CREATE TABLE IF NOT EXISTS `medication` (
  `MEDICATION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MEDICATION_NAME` varchar(50) NOT NULL,
  `RXCUI` float DEFAULT NULL,
  PRIMARY KEY (`MEDICATION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.medication: ~38 rows (approximately)
/*!40000 ALTER TABLE `medication` DISABLE KEYS */;
REPLACE INTO `medication` (`MEDICATION_ID`, `MEDICATION_NAME`, `RXCUI`) VALUES
	(1, 'Albuterol', 435),
	(2, 'Advair', 301543),
	(3, 'glimepiride', 25789),
	(4, 'Metformin', 6809),
	(5, 'Lisinopril', 29046),
	(6, 'Hydrochlorothiazide', 5487),
	(7, 'Wellbutrin', 42568),
	(8, 'Lexapro', 352741),
	(9, 'Alprazolam', 596),
	(10, 'Azithromycin', 18631),
	(11, 'Doxycycline', 3640),
	(12, 'Advil', 153010),
	(13, 'Oseltamivir phosphate', 259275),
	(14, 'Acetaminophen', 161),
	(15, 'Levothyroxine', 10582),
	(16, 'Adderall', 84815),
	(17, 'Duloxetine ', 72625),
	(18, 'Verapamil', 11170),
	(19, 'Propranolol', 8787),
	(20, 'Amiodarone', 703),
	(21, 'Atorvastatin', 83367),
	(22, 'Fluticasone', 41126),
	(23, 'Imitrex', 217713),
	(24, 'Tramadol', 10689),
	(25, 'Levodopa', 6375),
	(26, 'Bromocriptine', 1760),
	(27, 'Lithium', 6448),
	(28, 'Valproic Acid', 11118),
	(29, 'Warfarin', 11289),
	(30, 'Galantamine', 4637),
	(31, 'Fosamax', 114265),
	(32, 'Zoledronic Acid', 77655),
	(33, 'Acyclovir', 281),
	(34, 'Infliximab', 191831),
	(35, 'Methotrexate', 6851),
	(36, 'Loperamide', 6468),
	(37, 'Adalimumab', 327361),
	(38, 'Amoxicillin', 723);
/*!40000 ALTER TABLE `medication` ENABLE KEYS */;

-- Dumping structure for table dac.patient
CREATE TABLE IF NOT EXISTS `patient` (
  `PATIENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FIRST_NAME` varchar(50) NOT NULL,
  `LAST_NAME` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `GENDER` varchar(50) NOT NULL,
  `ADDRESS` varchar(100) NOT NULL,
  `CITY` varchar(50) NOT NULL,
  `STATE` varchar(2) NOT NULL,
  `CELL_PHONE` varchar(13) NOT NULL,
  `ZIP` varchar(5) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  PRIMARY KEY (`PATIENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.patient: ~11 rows (approximately)
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
REPLACE INTO `patient` (`PATIENT_ID`, `FIRST_NAME`, `LAST_NAME`, `DOB`, `GENDER`, `ADDRESS`, `CITY`, `STATE`, `CELL_PHONE`, `ZIP`, `EMAIL`) VALUES
	(1, 'Jeanne', 'Gagnon', '1979-12-05', 'F', '8605 charles st', 'Conway', 'AR', '5019762427', '72032', 'jeanne.gagnon@example.com'),
	(2, 'Hailey', 'Iam', '1987-01-30', 'F', '8954 Disputed Rd', 'Conway', 'AR', '5017196534', '72034', 'hailey.lam@example.com'),
	(3, 'Phil', 'Harrison', '1984-06-17', 'M', '6256 Alexander Road', 'Conway', 'AR', '5015394546', '72034', 'phil.harrison@example.com'),
	(4, 'Rosie', 'Davies', '1964-08-29', 'F', '9745 Grafton Street', 'Conway', 'AR', '5019811225', '72032', 'rosie.davies@example.com'),
	(5, 'Arnold', 'Jacobs', '1984-12-13', 'M', '9166 New Road', 'Conway', 'AR', '5012958387', '72034', 'arnold.jacobs@example.com'),
	(6, 'Ellen', 'Hicks', '1987-08-30', 'F', '6389 Lone Wolf Trail', 'Conway', 'AR', '5014676727', '72032', 'ellen.hicks@example.com'),
	(7, 'Wesley', 'Williamson', '1982-08-17', 'M', '1004 Manor Road', 'Conway', 'AR', '5012363951', '72032', 'wesley.williamson@example.com'),
	(8, 'Cody', 'Styers', '1990-10-28', 'M', '1672 st. Lawrence Ave', 'Conway', 'AR', '5015157225', '72034', 'cstye417@gmail.com'),
	(9, 'Ashley', 'Jumper', '1989-02-26', 'F', '6320 Groveland Terrace', 'Conway', 'AR', '5013439513', '72034', 'ajumper1999@gmail.com'),
	(10, 'David', 'Mack', '1988-02-28', 'M', '2323 Lovers Ln', 'Conway', 'AR', '5014281288', '72034', 'vaselinegroove@gmail.com'),
	(11, 'Mike', 'Jones', '1987-05-24', 'M', '52 Caney Creek Rd', 'Conway', 'AR', '5014281287', '72032', 'mikejones@example.com');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;

-- Dumping structure for table dac.patient_allergy
CREATE TABLE IF NOT EXISTS `patient_allergy` (
  `PATIENT_ALLERGY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PATIENT_ID` int(11) NOT NULL,
  `ALLERGY_ID` int(11) NOT NULL,
  PRIMARY KEY (`PATIENT_ALLERGY_ID`),
  KEY `allergies_patient_allergy_fk` (`ALLERGY_ID`),
  KEY `patient_patient_allergy_fk` (`PATIENT_ID`),
  CONSTRAINT `allergies_patient_allergy_fk` FOREIGN KEY (`ALLERGY_ID`) REFERENCES `allergies` (`ALLERGY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_patient_allergy_fk` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.patient_allergy: ~2 rows (approximately)
/*!40000 ALTER TABLE `patient_allergy` DISABLE KEYS */;
REPLACE INTO `patient_allergy` (`PATIENT_ALLERGY_ID`, `PATIENT_ID`, `ALLERGY_ID`) VALUES
	(1, 11, 8),
	(2, 11, 1);
/*!40000 ALTER TABLE `patient_allergy` ENABLE KEYS */;

-- Dumping structure for table dac.patient_vital
CREATE TABLE IF NOT EXISTS `patient_vital` (
  `PATIENT_VITAL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PATIENT_ID` int(11) NOT NULL DEFAULT '0',
  `VITAL_ID` int(11) NOT NULL DEFAULT '0',
  `VALUE` varchar(50) NOT NULL DEFAULT '0',
  `DATE_TAKEN` date DEFAULT NULL,
  PRIMARY KEY (`PATIENT_VITAL_ID`),
  KEY `PATIENT_ID` (`PATIENT_ID`),
  KEY `VITAL_ID` (`VITAL_ID`),
  CONSTRAINT `PATIENT_ID` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`),
  CONSTRAINT `VITAL_ID` FOREIGN KEY (`VITAL_ID`) REFERENCES `vitals` (`VITAL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.patient_vital: ~16 rows (approximately)
/*!40000 ALTER TABLE `patient_vital` DISABLE KEYS */;
REPLACE INTO `patient_vital` (`PATIENT_VITAL_ID`, `PATIENT_ID`, `VITAL_ID`, `VALUE`, `DATE_TAKEN`) VALUES
	(6, 11, 1, '98.5', '2016-02-05'),
	(7, 11, 2, '98', '2016-02-05'),
	(8, 11, 3, '135/87', '2016-02-05'),
	(9, 11, 4, '21', '2016-02-05'),
	(10, 11, 5, '173', '2016-02-05'),
	(17, 11, 5, '230', '2015-03-08'),
	(18, 11, 1, '98.5', '2017-03-04'),
	(19, 11, 2, '111', '2017-03-04'),
	(20, 11, 3, '149/99', '2017-03-04'),
	(21, 11, 4, '17', '2017-03-04'),
	(22, 11, 5, '201', '2017-03-04'),
	(23, 11, 1, '99.0', '2017-03-15'),
	(24, 11, 2, '115', '2017-03-15'),
	(25, 11, 3, '152/101', '2017-03-15'),
	(26, 11, 4, '16', '2017-03-15'),
	(27, 11, 5, '210', '2017-03-15');
/*!40000 ALTER TABLE `patient_vital` ENABLE KEYS */;

-- Dumping structure for table dac.pharmacy
CREATE TABLE IF NOT EXISTS `pharmacy` (
  `PHARMACY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PHARM_NAME` varchar(50) NOT NULL,
  `PHARM_ADDRESS` varchar(50) NOT NULL,
  `PHARM_STATE` varchar(50) NOT NULL,
  `PHARM_CITY` varchar(50) NOT NULL,
  `PHARM_ZIP` varchar(50) NOT NULL,
  PRIMARY KEY (`PHARMACY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.pharmacy: ~10 rows (approximately)
/*!40000 ALTER TABLE `pharmacy` DISABLE KEYS */;
REPLACE INTO `pharmacy` (`PHARMACY_ID`, `PHARM_NAME`, `PHARM_ADDRESS`, `PHARM_STATE`, `PHARM_CITY`, `PHARM_ZIP`) VALUES
	(1, 'Conway Medcare Pharmacy', ' 2521 College Ave ', 'AR', 'Conway', '72034'),
	(2, 'Cornerstone Pharmacy Conway', ' 815 Hogan Ln #10 ', 'AR', 'ConWay', '72034'),
	(3, 'Walgreens', '850 W Oak Street', 'AR', 'Conway', '72032'),
	(4, 'Sav-On Drugs', '1014 Harkrider Street', 'AR', 'Conway', '72032'),
	(5, 'Medicine Shoppe', '2424 Dave Ward Drive #602 ', 'AR', 'Conway', '72034'),
	(6, 'Smith Family Pharmacy', '2235 Dave Ward Drive', 'AR', 'Conway', '72034'),
	(7, ' CVS', '501 Elsinger Blvd', 'AR', 'Conway', '72032'),
	(8, ' Walmart Pharmacy', '2550 Prince Street', 'AR', 'Conway', '72034'),
	(9, ' Baker Drug ', '924 Front Street ', 'AR', 'Conway', '72032'),
	(10, 'Kroger Pharmacy', '101 W Oak Street', 'AR', 'Conway', '72034');
/*!40000 ALTER TABLE `pharmacy` ENABLE KEYS */;

-- Dumping structure for table dac.prescription
CREATE TABLE IF NOT EXISTS `prescription` (
  `PRESCRIPTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date NOT NULL,
  `DOSAGE` varchar(50) NOT NULL,
  `FREQUENCY_ID` int(11) NOT NULL,
  `MEDICATION_ID` int(11) NOT NULL,
  `PATIENT_ID` int(11) NOT NULL,
  `PHARMACY_ID` int(11) NOT NULL,
  `DOCTOR_ID` int(11) NOT NULL,
  PRIMARY KEY (`PRESCRIPTION_ID`),
  KEY `doctor_perscription_fk` (`DOCTOR_ID`),
  KEY `patient_perscription_fk` (`PATIENT_ID`),
  KEY `medication_id_fk` (`MEDICATION_ID`),
  KEY `pharmacy_id_fk` (`PHARMACY_ID`),
  KEY `FREQUENCY_ID` (`FREQUENCY_ID`),
  CONSTRAINT `doctor_perscription_fk` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `frequency_id_fk` FOREIGN KEY (`FREQUENCY_ID`) REFERENCES `frequency` (`FREQUENCY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `medication_id_fk` FOREIGN KEY (`MEDICATION_ID`) REFERENCES `medication` (`MEDICATION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_perscription_fk` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pharmacy_id_fk` FOREIGN KEY (`PHARMACY_ID`) REFERENCES `pharmacy` (`PHARMACY_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.prescription: ~12 rows (approximately)
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
REPLACE INTO `prescription` (`PRESCRIPTION_ID`, `DATE`, `DOSAGE`, `FREQUENCY_ID`, `MEDICATION_ID`, `PATIENT_ID`, `PHARMACY_ID`, `DOCTOR_ID`) VALUES
	(1, '2017-01-15', '20mg', 1, 16, 11, 3, 6),
	(2, '2016-12-09', '325mg', 4, 14, 11, 3, 7),
	(3, '2017-04-03', '50mg', 4, 35, 11, 7, 6),
	(4, '2016-05-07', '25mg', 5, 23, 11, 3, 6),
	(5, '2017-03-15', '800mg', 1, 12, 11, 7, 11),
	(6, '2017-03-15', '16mg', 4, 6, 11, 7, 4),
	(7, '2017-03-15', '20 mg', 4, 20, 11, 4, 1),
	(8, '2017-03-15', '300mg', 1, 15, 11, 7, 6),
	(9, '2017-03-15', '10mg', 1, 24, 11, 7, 1),
	(10, '2017-03-15', '20mg', 1, 27, 11, 7, 14),
	(11, '2017-03-21', '500mg', 1, 4, 11, 4, 7),
	(13, '2016-11-15', '40 mg', 1, 29, 11, 8, 4);
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;

-- Dumping structure for table dac.prescription_reminder
CREATE TABLE IF NOT EXISTS `prescription_reminder` (
  `REMINDER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PATIENT_ID` int(11) NOT NULL,
  `PRESCRIPTION_ID` int(11) NOT NULL,
  `NEXT_REMINDER` time DEFAULT NULL,
  PRIMARY KEY (`REMINDER_ID`),
  KEY `patient_id_fk` (`PATIENT_ID`),
  KEY `prescription_id_fk` (`PRESCRIPTION_ID`),
  CONSTRAINT `patient_id_fk` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prescription_id_fk` FOREIGN KEY (`PRESCRIPTION_ID`) REFERENCES `prescription` (`PRESCRIPTION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.prescription_reminder: ~2 rows (approximately)
/*!40000 ALTER TABLE `prescription_reminder` DISABLE KEYS */;
REPLACE INTO `prescription_reminder` (`REMINDER_ID`, `PATIENT_ID`, `PRESCRIPTION_ID`, `NEXT_REMINDER`) VALUES
	(2, 11, 1, '16:56:25'),
	(11, 11, 9, '09:12:18');
/*!40000 ALTER TABLE `prescription_reminder` ENABLE KEYS */;

-- Dumping structure for table dac.user
CREATE TABLE IF NOT EXISTS `user` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PATIENT_ID` int(11) NOT NULL DEFAULT '0',
  `PASSWORD` varbinary(50) NOT NULL DEFAULT '0',
  `PASSWORD_SALT` varbinary(50) NOT NULL DEFAULT '0',
  `USER_EMAIL` varchar(50) NOT NULL DEFAULT '0',
  `USER_CELL_PHONE` varchar(13) NOT NULL DEFAULT '0',
  PRIMARY KEY (`USER_ID`),
  KEY `PATIENT_ID` (`PATIENT_ID`),
  CONSTRAINT `FK_user_patient` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.user: ~11 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
REPLACE INTO `user` (`USER_ID`, `PATIENT_ID`, `PASSWORD`, `PASSWORD_SALT`, `USER_EMAIL`, `USER_CELL_PHONE`) VALUES
	(1, 1, '�Q$<E$��R�j 3\0%ی�me6�\rN����r', 'R��=q<�F��I�Ϸ�', 'jeanne.gagnon@example.com', '115019762427'),
	(2, 2, '�#�B}�W�C5]��\\c(�-��>����2��', '�Ǔ㣝���U�TV+', 'hailey.lam@example.com', '15017196534'),
	(3, 3, 'X�(���q���g�+E$d���G-&�ݖ`LJ���', 'P%��I9o�0�4�K', 'phil.harrison@example.com', '15015394546'),
	(4, 4, '���\n\ny�$~����h%Hߡ޳\0��_n\n\\��', 'Y���v�!����d�', 'rosie.davies@example.com', '15019811225'),
	(5, 5, '��j=�TbWI9:�-#/�:�\\�[�K,\'��`', '|��jo�w�Sk��', 'arnold.jacobs@example.com', '15012958387'),
	(6, 6, 'W����v�{��CY$�}\')�w��$,-�.\r�', 'r��>֡��i���v�', 'ellen.hicks@example.com', '15014676727'),
	(7, 7, ',�p�S8]��@��Z�r��ԨԎ�"����\n', 'ƨ~D\'\0i	��d�C��', 'wesley.williamson@example.com', '15012363951'),
	(8, 8, 'H��w�YWI��Z��\'u��N����p�*���!@�', '�mMM�����ra��y', 'cstye417@gmail.com', '15012363951'),
	(9, 9, '�$���­�����������:�B�f!�', 'J�܎%5ϻE`Ӏ�\n�', 'ajumper12@gmail.com', '15013439513'),
	(10, 10, '�W��4����`A-)�:]�]�i�6�\'��', 'eV��7�$dmV����', 'vaselinegroove@gmail.com', '15014281288'),
	(11, 11, '���{��]�\0�O̟�i�\nǘ���p��e}�`', '숇$�J���=`�', 'mikejones@example.com', '15014281287');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table dac.vaccination
CREATE TABLE IF NOT EXISTS `vaccination` (
  `VACCINE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `VACCINE_NAME` varchar(50) NOT NULL,
  `BOOSTER_REQUIRED` varchar(50) NOT NULL,
  `VACCINE_DESCRIPTION` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`VACCINE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.vaccination: ~11 rows (approximately)
/*!40000 ALTER TABLE `vaccination` DISABLE KEYS */;
REPLACE INTO `vaccination` (`VACCINE_ID`, `VACCINE_NAME`, `BOOSTER_REQUIRED`, `VACCINE_DESCRIPTION`) VALUES
	(1, 'Hepatitis B Shot 1', 'YES', 'hepatitis B'),
	(2, 'Hepatitis B Shot 2', 'YES', 'hempititis B'),
	(3, 'Hepatitis B Shot 3', 'NO', 'hempititis B'),
	(4, 'DTaP', 'YES', 'Tetinus, diptheria'),
	(5, 'IPV Shot 1', 'YES', 'Polio Vaccine'),
	(6, 'IPV Shot 2', 'YES', 'Polio'),
	(7, 'IPV Shot 3', 'NO', 'Polio'),
	(8, 'MMR Shot 1', 'YES', 'Measals Mumps Rubella'),
	(9, 'MMR Shot 2', 'NO', 'Measals Mumps Rubella'),
	(10, 'Varicella Shot 1', 'YES', 'Chicken Pox'),
	(11, 'Varicella Shot 2', 'NO', 'Chicken Pox');
/*!40000 ALTER TABLE `vaccination` ENABLE KEYS */;

-- Dumping structure for table dac.vaccination_given
CREATE TABLE IF NOT EXISTS `vaccination_given` (
  `VACCINATION_GIVEN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date NOT NULL,
  `DOCUMENTATION` longblob,
  `PATIENT_ID` int(11) NOT NULL,
  `VACCINE_ID` int(11) NOT NULL,
  `DOCTOR_ID` int(11) NOT NULL,
  PRIMARY KEY (`VACCINATION_GIVEN_ID`),
  KEY `doctor_vaccination_given_fk` (`DOCTOR_ID`),
  KEY `vaccinations_vaccination_given_fk` (`VACCINE_ID`),
  KEY `patient_vaccination_given_fk` (`PATIENT_ID`),
  CONSTRAINT `doctor_vaccination_given_fk` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_vaccination_given_fk` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `vaccinations_vaccination_given_fk` FOREIGN KEY (`VACCINE_ID`) REFERENCES `vaccination` (`VACCINE_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.vaccination_given: ~5 rows (approximately)
/*!40000 ALTER TABLE `vaccination_given` DISABLE KEYS */;
REPLACE INTO `vaccination_given` (`VACCINATION_GIVEN_ID`, `DATE`, `DOCUMENTATION`, `PATIENT_ID`, `VACCINE_ID`, `DOCTOR_ID`) VALUES
	(1, '2010-06-16', NULL, 11, 4, 6),
	(4, '2017-03-14', NULL, 11, 1, 7),
	(5, '2017-03-14', NULL, 11, 2, 2),
	(6, '2017-03-14', NULL, 11, 3, 7),
	(7, '2017-03-12', NULL, 11, 11, 7);
/*!40000 ALTER TABLE `vaccination_given` ENABLE KEYS */;

-- Dumping structure for table dac.vitals
CREATE TABLE IF NOT EXISTS `vitals` (
  `VITAL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `VITAL_NAME` varchar(50) NOT NULL,
  `VITAL_DESCRIPTION` varchar(50) NOT NULL,
  PRIMARY KEY (`VITAL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ascii;

-- Dumping data for table dac.vitals: ~6 rows (approximately)
/*!40000 ALTER TABLE `vitals` DISABLE KEYS */;
REPLACE INTO `vitals` (`VITAL_ID`, `VITAL_NAME`, `VITAL_DESCRIPTION`) VALUES
	(1, 'Temp in Degrees', 'Body Temp'),
	(2, 'Pulse in bpm', 'Heart Rate'),
	(3, 'Blood Pressure', 'Systolic/Diastolic'),
	(4, 'Resp Rate', 'Respiration Rate'),
	(5, 'Weight in lbs', 'lbs'),
	(6, 'BMI', 'Body Mass Index');
/*!40000 ALTER TABLE `vitals` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
