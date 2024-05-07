-- For ESX
ALTER TABLE `owned_vehicles` ADD `vehicle` varchar(50) DEFAULT NULL,
ALTER TABLE `owned_vehicles` ADD `logs` LONGTEXT DEFAULT '[]';
ALTER TABLE `owned_vehicles` ADD `garage` VARCHAR(60) NULL;
ALTER TABLE `owned_vehicles` ADD `mods` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL;
ALTER TABLE `owned_vehicles` ADD `fuel` int(11) DEFAULT 100;
ALTER TABLE `owned_vehicles` ADD `engine` float DEFAULT 1000;
ALTER TABLE `owned_vehicles` ADD `body` float DEFAULT 1000;


-- For QB
ALTER TABLE `player_vehicles` ADD `logs` LONGTEXT DEFAULT '[]';