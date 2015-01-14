CREATE TABLE `customers` (
  `CustID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Email` varchar(30) NOT NULL,
  `Gender` char(1) NOT NULL DEFAULT 'M',
  `password_digest` varchar(60) NOT NULL,
  `ShoeSize` float unsigned DEFAULT NULL COMMENT 'System-calculated shoe size from shoes with corresponding user ID.',
  `ShoeSizeError` float unsigned DEFAULT NULL,
  `preferredSizeType` varchar(20) NOT NULL,
  PRIMARY KEY (`CustID`,`Email`),
  UNIQUE KEY `CustID_UNIQUE` (`CustID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `fk_CustomerInfo_Genders1_idx` (`Gender`),
  KEY `preferredSizeType_Customers_idx` (`preferredSizeType`),
  CONSTRAINT `preferredSizeType_Customers` FOREIGN KEY (`preferredSizeType`) REFERENCES `sizetypes` (`SizeType`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Gender_Customers` FOREIGN KEY (`Gender`) REFERENCES `genders` (`Gender`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `genders` (
  `Gender` char(1) NOT NULL DEFAULT 'M',
  PRIMARY KEY (`Gender`),
  UNIQUE KEY `Gender_UNIQUE` (`Gender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lengthfits` (
  `LengthFit` varchar(20) NOT NULL,
  PRIMARY KEY (`LengthFit`),
  UNIQUE KEY `LengthFit_UNIQUE` (`LengthFit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `shoebrands` (
  `Brand` varchar(30) NOT NULL,
  PRIMARY KEY (`Brand`),
  UNIQUE KEY `Brand_UNIQUE` (`Brand`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `shoematerials` (
  `Material` varchar(20) NOT NULL,
  PRIMARY KEY (`Material`),
  UNIQUE KEY `Material_UNIQUE` (`Material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `shoes` (
  `ShoeID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'This is a list of ALL the shoes in the database, so using a BIGINT for ID is justified.',
  `OwnerID` bigint(20) NOT NULL COMMENT 'We also expect alot of customers, so we use a BIGINT here too.',
  `T2RS_ID` bigint(20) NOT NULL DEFAULT '0',
  `Brand` varchar(30) NOT NULL,
  `Style` varchar(30) NOT NULL,
  `Material` varchar(30) NOT NULL,
  `SizeType` varchar(20) NOT NULL,
  `Size` float unsigned NOT NULL,
  `LengthFit` varchar(20) NOT NULL DEFAULT 'Perfect',
  `PreRealSize` float unsigned DEFAULT NULL COMMENT 'Given size combined with given fit, converted to Mondopoint.',
  `RealSize` float unsigned DEFAULT NULL COMMENT 'Prediction of real size as given by the TypeToRealSize table.',
  PRIMARY KEY (`ShoeID`),
  UNIQUE KEY `idShoes_UNIQUE` (`ShoeID`),
  KEY `fk_Shoes_ShoeStyles1_idx` (`Style`),
  KEY `fk_Shoes_ShoeMaterials1_idx` (`Material`),
  KEY `fk_Shoes_ShoeBrands1_idx` (`Brand`),
  KEY `fk_Shoes_CustomerInfo1_idx` (`OwnerID`),
  KEY `SizeType_idx` (`SizeType`),
  KEY `fk_Shoes_LengthFits1_idx` (`LengthFit`),
  KEY `fk_Shoes_TypeToRealSize1_idx` (`T2RS_ID`),
  CONSTRAINT `Brand_Shoes` FOREIGN KEY (`Brand`) REFERENCES `shoebrands` (`Brand`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `LengthFit_Shoes` FOREIGN KEY (`LengthFit`) REFERENCES `lengthfits` (`LengthFit`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Material_Shoes` FOREIGN KEY (`Material`) REFERENCES `shoematerials` (`Material`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `OwnerID_Shoes` FOREIGN KEY (`OwnerID`) REFERENCES `customers` (`CustID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `SizeType_Shoes` FOREIGN KEY (`SizeType`) REFERENCES `sizetypes` (`SizeType`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Style_Shoes` FOREIGN KEY (`Style`) REFERENCES `shoestyles` (`Style`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `T2RS_Shoes` FOREIGN KEY (`T2RS_ID`) REFERENCES `typetorealsize` (`T2RS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

CREATE TABLE `shoestyles` (
  `Style` varchar(20) NOT NULL,
  PRIMARY KEY (`Style`),
  UNIQUE KEY `Type_UNIQUE` (`Style`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sizetypes` (
  `SizeType` varchar(20) NOT NULL,
  `ToMondo1` float DEFAULT NULL,
  `ToMondo0` float DEFAULT NULL,
  `SizeTypeInterval` float DEFAULT NULL,
  `MinSize` float DEFAULT NULL,
  `MaxSize` float DEFAULT NULL,
  PRIMARY KEY (`SizeType`),
  UNIQUE KEY `SizeType_UNIQUE` (`SizeType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t2rs_entryinfo` (
  `OwnerID` bigint(20) NOT NULL,
  `PreSize` double NOT NULL,
  `RealSize` double NOT NULL,
  `ShoeSize` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `typetorealsize` (
  `T2RS_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'For each Brand+Style+Material+SizeType combination, we store here the four coefficients to the polynomial approximation to the given size -> real size function, obtained from best-fitting the data available on the aforementioned combination.',
  `BrandStyleMaterial` varchar(70) NOT NULL COMMENT 'Concatenation of Brand, Style and Material with delimiter ",".',
  `ToMondo1` double NOT NULL DEFAULT '1' COMMENT 'Coefficient of linear term in approximation to real size.',
  `ToMondo0` double NOT NULL DEFAULT '0' COMMENT 'Coefficient of constant term in approximation to real size.',
  `modified` tinyint(1) NOT NULL DEFAULT '0',
  `Uncertainty` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`T2RS_ID`,`BrandStyleMaterial`),
  UNIQUE KEY `TypeToRealSizeID_UNIQUE` (`T2RS_ID`),
  UNIQUE KEY `BrandStyleMaterial_UNIQUE` (`BrandStyleMaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=140072 DEFAULT CHARSET=utf8;

