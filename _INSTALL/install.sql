CREATE TABLE IF NOT EXISTS `player_xp` (
  `identifier` varchar(46) NOT NULL,
  `xp` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;