-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: coffee_shop
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `drink_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_user_id_idx` (`user_id`),
  CONSTRAINT `cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `password` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_email` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  CONSTRAINT `clients_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Михайлю Сергій Анатолійович','mykhailiuk@gmail.com','+380973456789','mikhaylyuksergiy','2024-04-29 14:34:10','56e8d316a5d48a9ebea8fcf34e2a937e1760f90c75f51a68d972c6d3a95f7914'),(2,'Кравченко Марія Олександрівна','kravchenko.maria@gmail.com','+380983456789','kravchenkomariya','2024-04-29 14:34:10','56e8d316a5d48a9ebea8fcf34e2a937e1760f90c75f51a68d972c6d3a95f7914\r'),(3,'Шевченко Віктор Ігорович','shevchenko.viktor@gmail.com','+380933456789','shevchenkoviktor','2024-04-29 14:34:10','44f674c99f3cc0f81e0bf7fbf509dca0136c0a2b04237d13e083e89ff384c792\r'),(4,'Гончар Ольга Леонідівна','honchar.olg@gmail.com','+380993456789','honcharolgaleonidivna','2024-04-29 14:34:10','35668a7e0e34b7506c3f63a4778dc7450401c282c7f54e5762956868b99dd03b\r'),(5,'Литвиненко Юрій Станіславович','lytvynenko.yuriy@gmail.com','+380923456789','lytvynenkoyuriystanislavovych','2024-04-29 14:34:10','b58d105d8d19f8d5daae4b97d8aa8530449a2995d9f1d7786a63da6ac4508d3c\r'),(6,'Мельник Анна Михайлівна','melnik.anna@gmail.com','+380963456789','melnikannamikhaylivna','2024-04-29 14:34:10','712b6dd6cf1e03e88c3ba2c947dd6010d8822e02832d6b8e6292b9e8b111c882\r'),(7,'Козак Віталій Олегович','kozak.vitaliy@gmail.com','+380913456789','kozakvitaliyolegovych','2024-04-29 14:34:10','13df86749866d747fae70c5c03389e69b5c91cc90e28817a8c7dc71b9cf08d63\r'),(8,'Петренко Маргарита Ігорівна','petrenko.margarita@gmail.com','+380953456789','petrenkomargaritaigorivna','2024-04-29 14:34:10','6b2e2ac81e34df0a80c2ba665b3912312a5b5eb7c6d0c22ab2edf65651bb88a1\r'),(9,'Демченко Олександр Іванович','demchenko.oleksandr@gmail.com','+380943456789','demchenkooleksandrivanovich','2024-04-29 14:34:10','d17c2b4745ec4562fa1d98ac0cf3004dcbfb0a4cf346edec0457417f7e5a51bb\r'),(10,'Бондар Антоніна Олександрівна','bondar.antonia@gmail.com','+380903456789','bondarantoniaoleksandrivna','2024-04-29 14:34:10','4883f094f7f3fcbe27ecf95c2532f7464db0e59056d4a6d54631ee1077d3d940\r'),(11,'Лисенко Анатолій Юрійович','lisenko.anatoliy@gmail.com','+380925456789','lisenkoanatoliyyuriyovych','2024-04-29 14:34:10','5683c4a9b93d1813fd145d4db94584e45c21a4e3e0a9a67b8e876b3b9d4d13a5\r'),(12,'Павленко Юлія Вікторівна','pavlenko.yulia@gmail.com','+380963456789','pavlenkoyuliaviktorivna','2024-04-29 14:34:10','17b4f4dd32c2022ac5d4d2149a7bdcdb6d884dd9855f94a002b70d6d3e7480f8\r'),(13,'Коваленко Артем Валентинович','kovalenko.artem@gmail.com','+380993456789','kovalenkoartemvalentinovych','2024-04-29 14:34:10','a2f4cd89b17280aef4ed68a6d1ba47c7e1018a3b1f077b05f69e3e16e4393c1d\r'),(14,'Тимошенко Оксана Ігорівна','timoshenko.oksana@gmail.com','+380913456789','timoshenkooksanaigorivna','2024-04-29 14:34:10','90eaa55f4f33a6ed6293a1395cb84f7df19fb1538a582d57e540df02d5b55852\r'),(15,'Мироненко Андрій Олександрович','myronenko.andriy@gmail.com','+380953456789','myronenkoandriyoleksandrovych','2024-04-29 14:34:10','11a84d263bb1725f0f0f4b53f394c4f4f6ecdd6cc3b2cc4b28c1f8a37911abed\r'),(16,'Сидоренко Тетяна Леонідівна','sidorenko.tetiana@gmail.com','+380943456789','sidorenkotetianaleonidivna','2024-04-29 14:34:10','2c6e0bcf351b0d32df147c03150990e8edf624d7f74ad1f91c43987e7d5e97f7\r'),(17,'Гриценко Станіслав Іванович','hr ytsenko.stanislav@gmail.com','+380903456789','hrytsenkostanislavivanovych','2024-04-29 14:34:10','9df6de8eb5a4a573c879db0620dcf4f8b485e5165d7a362612a61d5e7c0b5291\r'),(18,'Коваленко Вікторія Анатоліївна','kovalenko.victoria@gmail.com','+380933456789','kovalenkoviktoriyanatoliyivna','2024-04-29 14:34:10','63b49145df94db90d501777a6de21c7027aa9ee64a0e0d747445eb3d0b2f3059\r'),(19,'Григоренко Володимир Ігорович','hryhorenko.vladimir@gmail.com','+380963456789','hryhorenkovladimirigorovych','2024-04-29 14:34:10','6bb956d414b94d4de0a6d8e2df22d04f23b0f2f30ecde127db09f53a44c0cda7\r'),(20,'Іванов Віталій Олегович','ivanov.vitaliy@gmail.com','+380993456789','ivanovvitaliyolegovych','2024-04-29 14:34:10','d6095cfc96e6775c3312d769b672f76237e7327f9df6c52e4c7f38e037cebf4e\r'),(21,'Литвин Владислав Сергійович','lytvyn.vladyslav@gmail.com','+380913456789','lytvynvladyslavsergiyovych','2024-04-29 14:34:10','4b93da9c1b79f8820b30b0f5246d760e688b9020f26e612438bc5ac70c454ccd\r'),(22,'Максименко Ірина Юріївна','maksymenko.iryna@gmail.com','+380953456789','maksymenkoirinayuriyivna','2024-04-29 14:34:10','2df5eaac4cf8a08d58db3f515fc4c8be254f9bbcd31cc273cd8c435b288d2cb1\r'),(23,'Мельник Інна Віталіївна','melnik.inna@gmail.com','+380943456789','melnikinnavitaliivna','2024-04-29 14:34:10','69c59dd8a363e647740b7ba16065f8e7d94b95b0175f859f17ac632b80bbd1da\r'),(24,'Даниленко Валентин Анатолійович','danilenko.valentin@gmail.com','+380903456789','danilenkovalentinanatoliyovych','2024-04-29 14:34:10','ab3ee9be2725d8f43c812647686d96a15ebf3692dab84e05667282d7a8b6309d\r'),(25,'Гончарук Ірина Миколаївна','honcharuk.iryna@gmail.com','+380923457789','honcharukirinamikolayivna','2024-04-29 14:34:10','9e8671fc4c23f32f3c89b6d5d8332a9c5b6db7f1a7596e4e8c658b97fd2c7b59\r'),(26,'Бондарчук Олександр Ігорович','bondarchuk.oleksandr@gmail.com','+380963456789','bondarchukoleksandrigorovich','2024-04-29 14:34:10','8d891d2160c0fd74d18731fcfd1e437a5810b4768bb3c92c85ab4f2c67a7ec17\r'),(27,'Кравченко Віктор Васильович','kravchenko.viktor@gmail.com','+380993456789','kravchenkoviktorvasilyovich','2024-04-29 14:34:10','ec8e7a90f9a94ec0f0c3ff13611a4e8ae10234e6b6e27ec9e14d4487c5834f71\r'),(28,'Тимошенко Марина Олексіївна','timoshenko.marina@gmail.com','+380913456789','timoshenkoomarinaoleksiivna','2024-04-29 14:34:10','8b169256e94717c3706e9c9cb07085e2bcf2c62f3f01c006e3a477c36c4c19d6\r'),(29,'Мироненко Олександр Ігорович','myronenko.alex@gmail.com','+380953456789','myronenkooleksandrivanovich','2024-04-29 14:34:10','00c073f39c8a8d382c34e6e5acdd5e64bb0183d1786bc97e1aafeb916a5e72c9\r'),(30,'Сидоренко Антоніна Станіславівна','sidorenko.antonia@gmail.com','+380943456789','sidorenkoantoninastanislavivna','2024-04-29 14:34:10','9ea23ebf3cf5b95a2875687f7a4b2e855bbaf42f9a32b25e5278fbdf7b8396cc\r'),(31,'Коваленко Віктор Миколайович','kovalenko.victor@gmail.com','+380903456789','kovalenkoviktormikolayovych','2024-04-29 14:34:10','d7b3d44c0fc5a60586fe07c8ff1993a732585f25f0c08f787439cc3cb76879d0\r'),(32,'Ковальчук Юлія Олегівна','kovalchuk.yulia@gmail.com','+380623456789','kovalchukyuliaolegivna','2024-04-29 14:34:10','fa7d53d9c8f879f3e37a7f47726a1f863282d4c303f8fb9c7f1b2026f8ba71f7\r'),(33,'Гриценко Павло Сергійович','hr ytsenko.pavlo@gmail.com','+380963456789','hrytsenkopalvoserhiyovych','2024-04-29 14:34:10','ed079e101c17f9cb2fcce56b042c9461db9b5b160af6e2d7c173ecfca0d1f67e\r'),(34,'Козлова Оксана Олексіївна','kozlova.oksana@gmail.com','+380913456789','kozlovaoksanaoleksiyivna','2024-04-29 14:34:10','81349d07376c9e4d2cc4ac45a7c5aa4ba510cf4572a93e295202a9c4c8c90f21\r'),(35,'Петренко Степан Віталійович','petrenko.stepan@gmail.com','+380953456789','petrenkostepanvitaliyovich','2024-04-29 14:34:10','fc79d195a1baea8bc1016dfb899f89a95bea42b78db4a53a37c265d6b6ceef7d\r'),(36,'Демченко Ольга Петрівна','demchenko.oleg@gmail.com','+380943456789','demchenkoolgapetrivna','2024-04-29 14:34:10','b82f2ac019d0a7ea5e6c07824841e23a442b5cf2a6f80bea76c7f63d2ce82b69\r'),(37,'Сергієнко Ірина Андріївна','serhienko.iryna@gmail.com','+380903456789','serhienkoirinaandriyivna','2024-04-29 14:34:10','5f92662071e12e3d3cf06d123c5e90d239b1aa4e222beedfd993d0b3f2fb17d2\r'),(38,'Кузнєцов Володимир Миколайович','kuznetsov.vladimir@gmail.com','+380623656789','kuznetsovvladimirmikolayovych','2024-04-29 14:34:10','6bbefdf405c868e9c10079f1a10cebb25fcd9c6905d08d8b4b74931b059086e0\r'),(39,'Мартиненко Наталія Ігорівна','martynenko.natalia@gmail.com','+380963456789','martynenk onatali iig orivna','2024-04-29 14:34:10',' 2cb13c3b6843228c8bb67bc8b3331c771ed7d4bc33bb7c25e92dcba88ed07ee8\r'),(40,'Ткаченко Віталій Олегович','tkachenko.vitaliy@gmail.com','+380913456789','tkachenkovitaliyolegovych','2024-04-29 14:34:10','dc84a3b9e253d2e846b1ab1397d0b25ad7ff49e7553b5eaf374f9d164d82a271\r'),(41,'Бондаренко Людмила Сергіївна','bondarenko.liudmyla@gmail.com','+380953456789','bondarenkoliudmilasergh iivna','2024-04-29 14:34:10',' 16f6b92377e21b545da91c9d0c8b8cdacac29f28670f21ea99259fc79fd24f82\r'),(42,'Коваленко Ігор Володимирович','kovalenko.ihor@gmail.com','+380943456789','kovalenkoihorvolodimirovych','2024-04-29 14:34:10',' 4c2a4988835c70f507b61569248a91ec41bf8a32c1f4e3d573ed9b085f24d680\r'),(43,'Марченко Марія Олександрівна','marchenko.maria@gmail.com','+380903456789','marchenkoma riyaoleksandrivna','2024-04-29 14:34:10',' 29c2d978c8d78d7f28ee11e0431b58ae472d5c2790a4fd9fcb5cf00e6f303ca5\r'),(44,'Даниленко Артем Вікторович','danilenko.artem@gmail.com','+380923456799','danilenkoartemvictorovych','2024-04-29 14:34:10',' b7c68227a63c3f28f05a2eeb3e6f14d070ef21f1e70bb1321d872d905251a5ee\r'),(45,'Савченко Тетяна Миколаївна','savchenko.tetiana@gmail.com','+380963456789','savchenkotetianamikolayivna','2024-04-29 14:34:10',' 849982e0213e10a71a4ce28c828774f084ee57ff0d1c9c0871809610321fc36b\r'),(46,'Лисенко Сергій Валентинович','lisenko.sergii@gmail.com','+380913456789','lisenkosergiyvalentinovych','2024-04-29 14:34:10',' 9c5fcb6b1096b913da6db5f75104b249e82b84852bb446ab2021685d28e2158c\r'),(47,'Павленко Лариса Ігорівна','pavlenko.larysa@gmail.com','+380953456789','pavlenkolarisaigorivna','2024-04-29 14:34:10',' f88619d8bf01230fb2ec99e181fdab52a0f0dc146c835d6e2a4f3ba442214f7f\r'),(48,'Ковальчук Артур Олександрович','kovalchuk.artur@gmail.com','+380943456789','kovalchukarturoleksandrovich','2024-04-29 14:34:10',' 742d320dbedc378ee9ce36d93382e6d48ec916d85f68bc31b09b2671f4e08b2b\r'),(49,'Гриценко Галина Олегівна','hr ytsenko.halyna@gmail.com','+380903456789','hrytsenkogalinaolegivna','2024-04-29 14:34:10',' 73f77dcf63c30b6f2c01ef5d06d1e1b2d3f1db67b40d87d367c8288a45450886\r'),(50,'Коваленко Вадим Андрійович','kovalenko.vadym4@gmail.com','+380923444789','kovalenkovadimandriyovych','2024-04-29 14:34:10','  705b9e3c124a40022b595ba2b3815f89cfb2c226ab1127da5068db6674c8f0b5'),(53,'Tetiana Sendetska','tetiana.sendetska.pz.2021@lpnu.ua','+38 (068) 829 67 95','tetiana','2024-04-18 21:23:01','1411242b2139f9fa57a802e1dc172e3e1ca7655ac2d06d83b22958951072261b'),(54,'Taras Mukha','taras@gmail.com','380666666666','mukhataras','2024-04-22 21:35:55','1df1854015e31ca286d015345eaff29a6c6073f70984a3a746823d4cac16b075'),(57,'Harry Poteer','fddf@gmail.com','380673541297','harrypotter','2024-04-23 20:10:52','f61a20da9eaa68a9f06dbc1710b10ef0a67208b2059b1f576af6deac23c215f5'),(337,'Ткаченко Марія Ігорівна',' tkachenko.maria@gmail.com',' +380981234567','tkachenko.maria','2024-05-01 12:00:00',' $2b$10$pt4C1Y6rC..dDWl0rVvK3us2LlcA0Pb3avv.QIO\r'),(338,'Бондаренко Іван Олександрович',' bondarenko.ivan@gmail.com',' +380931234567','bondarenko.ivan','2024-05-01 12:00:00',' $2b$10$v6D4jYzB3qX0NUOfp5hCReN9T2mfFd1WHe1FTbfx7.kz3GA3sY0Zm\r'),(339,'Коваленко Лариса Вікторівна',' kovalenko.larysa@gmail.com',' +380971234567','kovalenko.larysa','2024-05-01 12:00:00',' $2b$10$rAB5J.kWVzGuKkNywMxiTe.svVYg00x7Z0/1i0Eos9a2D9.3lhffG\r'),(340,'Мельник Степан Олегович',' melnik.stepan@gmail.com',' +380961234567','melnik.stepan','2024-05-01 12:00:00',' $2b$10$hs.WoAGJgXV7cA8aerqTF.kNBGoeewgkSyTC7hVz5WVYtUKDGqj0G\r'),(341,'Петренко Євгенія Ігорівна',' petrenko.yevheniya@gmail.com',' +380941234567','petrenko.yevheniya','2024-05-01 12:00:00',' $2b$10$Z5pYun5nSPy3VlNsBC48X.v/qW8U.1enJtOOgFQjZzvLdz8NBvL5O\r'),(342,'Литвин Олександр Валентинович',' lytvyn.oleksandr@gmail.com',' +380921234567','lytvyn.oleksandr','2024-05-01 12:00:00',' $2b$10$e7UgD10aAtCBteGpLHwjheFnQ/LK87H0hqgEX5xVcX3gt.YrG5MGy\r'),(343,'Сидоренко Людмила Олександрівна',' sydorenko.liudmyla@gmail.com',' +380901234567','sydorenko.liudmyla','2024-05-01 12:00:00',' $2b$10$1/ufZqG4D5CfHph9Iq7pu.rqP4fD4UnK2cLXH2ReAbU01e8FlVRje\r'),(344,'Мартиненко Анна Ігорівна',' martynenko.anna@gmail.com',' +380981234567','martynenko.anna','2024-05-01 12:00:00',' $2b$10$XVxgDEOwE2NUmh4QcI2cM.z5yLJ0bMfQHqbKgR6F8z8/TXjV/qVo2\r'),(345,'Гончар Олексій Володимирович',' honchar.oleksiy@gmail.com',' +380931234567','honchar.oleksiy','2024-05-01 12:00:00',' $2b$10$zIqMAqNsAehHUBeX7a1qae1nCYKXsQYUvlcf6eJfZyQHsUwv90Sg2\r'),(346,'Шевченко Оксана Юріївна',' shevchenko.oksana@gmail.com',' +380971234567','shevchenko.oksana','2024-05-01 12:00:00',' $2b$10$me0H1kYV6nHb3V7YL9n.4OIBplvPbFNNbCslFyZd0W3EwJltlZC4K\r'),(347,'Ковальчук Ірина Олександрівна',' kovalchuk.irina@gmail.com',' +380961234567','kovalchuk.irina','2024-05-01 12:00:00',' $2b$10$0U0fYzo8geKsUov/7oYrZO5sm8JNNOaIvl4tkb3F83lm/UqkEPrBy\r'),(348,'Мироненко Дмитро Вікторович',' myronenko.dmytro@gmail.com',' +380941234567','myronenko.dmytro','2024-05-01 12:00:00',' $2b$10$3cBw67IQb1pqrI3.B8Kvhe2tMgYw1RQbQBMIE.eeyjWl9o0V0zNXG\r'),(349,'Кравченко Людмила Іванівна',' kravchenko.liudmyla@gmail.com',' +380921234567','kravchenko.liudmyla','2024-05-01 12:00:00',' $2b$10$5VsZDE.rF1iFVf8mnPNrqe3WKE5s3zrKf2Zx.YQOH9qGnPtDXFkgW\r'),(350,'Петренко Олександр Олегович',' petrenko.oleksandr@gmail.com',' +380901234567','petrenko.oleksandr','2024-05-01 12:00:00',' $2b$10$ofb6gQ3oJZLc5N/ELZu6uexziyFQjC5TThW3/IRU8Cj5NlwRhQ0CK\r'),(351,'Бондаренко Оксана Миколаївна',' bondarenko.oksana@gmail.com',' +380981234567','bondarenko.oksana','2024-05-01 12:00:00',' $2b$10$mt7e1WtRU1VM5IUjHAWKQeswyk6L33QGd67b/m2GqWDqGEuVq21z6\r'),(352,'Коваленко Євген Олександрович',' kovalenko.yevgen@gmail.com',' +380931234567','kovalenko.yevgen','2024-05-01 12:00:00',' $2b$10$1hJkCj2ptbVT3vYkUprqIeJno5r8bNqpxEnyTbtTXxS2W.qaYFRPW\r'),(353,'Мельник Олена Сергіївна',' melnik.olena@gmail.com',' +380971234567','melnik.olena','2024-05-01 12:00:00',' $2b$10$zgKnh4FT9I0KcyHHoHKMK.1uCEb4C3h8ohEr2CRDFhE0UbNJN7T.q\r'),(354,'Гончарук Максим Віталійович',' honcharuk.max@gmail.com',' +380961234567','honcharuk.max','2024-05-01 12:00:00',' $2b$10$0f1Mq2CHkctMW9FX6mpLu.b8sB9s6dFrOUnuxs9sQyF53z/FiA4eq\r'),(355,'Тимошенко Анна Олегівна',' timoshenko.anna@gmail.com',' +380941234567','timoshenko.anna','2024-05-01 12:00:00',' $2b$10$2gVM./UOYKb3o7LlpdvcS.JVADs3VVj5BzO9U.L6hJ9tIYtER5lPe\r'),(356,'Лисенко Віктор Степанович',' lisenko.viktor@gmail.com',' +380921234567','lisenko.viktor','2024-05-01 12:00:00',' $2b$10$cmI63vWvMYvQXktRHxVRNObY0/g9LW2rC/8ye9M39fbVTkFYbZGMe\r'),(357,'Сидоренко Олена Ігорівна',' sydorenko.olena@gmail.com',' +380901234567','sydorenko.olena','2024-05-01 12:00:00',' $2b$10$JLP1UY2E2p7y9RDx2SSSD.6UPs6K0SHrG2V2T8ZSWArYut7s3Qcim\r'),(358,'Мартиненко Ірина Андріївна',' martynenko.iryna@gmail.com',' +380981234567','martynenko.iryna','2024-05-01 12:00:00',' $2b$10$D3sGwd1g4ve7hrU8t6JGHupmGWXC.TS.1Q9FcyaYwv2B1nRr.8ctW\r'),(359,'Григорович Володимир Олегович',' hryhorovych.volodymyr@gmail.com',' +380931234567','hryhorovych.volodymyr','2024-05-01 12:00:00',' $2b$10$htzVjPYz3Ld92ZdCv4Q.CuELr3CEQZ0VO3j8q7EkCgNp4emgHXaFq\r'),(360,'Коваленко Юлія Валеріївна',' kovalenko.yulia@gmail.com',' +380971234567','kovalenko.yulia','2024-05-01 12:00:00',' $2b$10$0bZkEDC.jQyrF9SbbCFv5uFvFFpuxYZWmW7aJKCf1l.9BMP/3qXmO\r'),(361,'Петренко Олексій Іванович',' petrenko.oleksiy@gmail.com',' +380961234567','petrenko.oleksiy','2024-05-01 12:00:00',' $2b$10$8zpmNqSdtz0vZv3K.UeTr.2/8Rm5nRkwW4bMxqk1OQjJlQJk4.cDm\r'),(362,'Бондаренко Тетяна Олександрівна',' bondarenko.tetiana@gmail.com',' +380941234567','bondarenko.tetiana','2024-05-01 12:00:00',' $2b$10$PtbH3XoJvvPOFw0.Mhjdb.hQfoXZv1k9Al.1dxfkx26xlbPQfIvHy\r'),(363,'Коваленко Дмитро Васильович',' kovalenko.dmytro@gmail.com',' +380921234567','kovalenko.dmytro','2024-05-01 12:00:00',' $2b$10$8z49fOJ9YfsR9TLoq5yG9.Dv3C0S9YOav6DgOQR4wnzPPdQ2Bc.Dy\r'),(364,'Мельник Марія Євгенівна',' melnik.maria@gmail.com',' +380901234567','melnik.maria','2024-05-01 12:00:00',' $2b$10$JAKbcqJStcgxSh6NdWpZdO0WTIuYHDz7qwsfTm87w2df4OnMDcV.e\r'),(365,'Гончарук Сергій Ігорович',' honcharuk.sergiy@gmail.com',' +380981234567','honcharuk.sergiy','2024-05-01 12:00:00',' $2b$10$UqSavQzzyahcO9E8JKYpVehRfU.9efGiFtjxRgh4N1moQs.BIgq/e\r'),(366,'Тимошенко Іванна Олександрівна',' timoshenko.ivanna@gmail.com',' +380931234567','timoshenko.ivanna','2024-05-01 12:00:00',' $2b$10$EDNQjVkYMQIzFfHTXkqzbuXp9Z.wXSS82EQ4vE7AeBIB.AjhaZZ0K\r'),(367,'Лисенко Анна Володимирівна',' lisenko.anna@gmail.com',' +380971234567','lisenko.anna','2024-05-01 12:00:00',' $2b$10$S2P94W5pV4yUbT0ycX/5UOvB8blsYJxJ.JBYeGkzJ9lS.CmfGfnXa\r'),(368,'Сидоренко Василь Ігорович',' sydorenko.vasyl@gmail.com',' +380961234567','sydorenko.vasyl','2024-05-01 12:00:00',' $2b$10$uJgQ7X70UV8M5APMxZYEnuYQW6j3TXvALp3UOlkABp4NL/2xYUbqy\r'),(369,'Мартиненко Денис Ігорович',' martynenko.denis@gmail.com',' +380941234567','martynenko.denis','2024-05-01 12:00:00',' $2b$10$kDrY2hDqQZmYpBRMdk1dR.B0kYs7.FJUQltVSlJxxv3P/1E2lRqTS\r'),(370,'Григорович Ірина Анатоліївна',' hryhorovych.iryna@gmail.com',' +380921234567','hryhorovych.iryna','2024-05-01 12:00:00',' $2b$10$SMNujpNR0htP.g1VkgVoF.bxJJZceVCMljOeGxclLdwURyzqCDd2.\r'),(371,'Коваленко Леся Вікторівна',' kovalenko.lesia@gmail.com',' +380901234567','kovalenko.lesia','2024-05-01 12:00:00',' $2b$10$7bhPTL80VZ83ZrsZtoYmHuT6c..Oww5QX8oW7LlmAeQ3UmQf26CLq\r'),(372,'Петренко Олег Олексійович',' petrenko.oleg@gmail.com',' +380981234567','petrenko.oleg','2024-05-01 12:00:00',' $2b$10$KubcY2gGpx59NkF6tKgxWeG9DgjB6D0IY3fR3hHD7.7gWl6Y5eT9i\r'),(373,'Бондаренко Ігор Станіславович',' bondarenko.igor@gmail.com',' +380931234567','bondarenko.igor','2024-05-01 12:00:00',' $2b$10$IdQSTsP/IYwRJr3F1tpICOTUkEIM/LLiE7hXc0FwOjptwR/Ox6BWq\r'),(374,'Коваленко Сергій Вікторович',' kovalenko.sergiy@gmail.com',' +380971234567','kovalenko.sergiy','2024-05-01 12:00:00',' $2b$10$RIzX2KvxL9qU/NWz.ZQ59.CJ/7CT0GrtZQQOWQlE.cOOA54I4Kw.K\r'),(375,'Мельник Вікторія Ігорівна',' melnik.viktoria@gmail.com',' +380961234567','melnik.viktoria','2024-05-01 12:00:00',' $2b$10$OS7GbjgavJqLwvyRHGf3Ye1kZbzHHQVjfo8TtnvNlsMB6KHNll0ZK\r'),(376,'Гончарук Юлія Олексіївна',' honcharuk.yulia@gmail.com',' +380941234567','honcharuk.yulia','2024-05-01 12:00:00',' $2b$10$f2JoQjXQI7kexVexW6iy3.BXaFVyW9O7dciE7Wec2vJq6kUoxg3je\r'),(377,'Тимошенко Артем Васильович',' timoshenko.artem@gmail.com',' +380921234567','timoshenko.artem','2024-05-01 12:00:00',' $2b$10$VQICr0fjPN/y8bP6Q7lFOeCXrjKlf1gq6gI//5xg1H4AjLgk9Nx2O\r'),(378,'Лисенко Валентина Володимирівна',' lisenko.valentyna@gmail.com',' +380901234567','lisenko.valentyna','2024-05-01 12:00:00',' $2b$10$9Pp..6ktSfDcmVRXHEO6ieyhlINzBQXHABUc8/Qg75MQ/tAdQLs8O\r'),(379,'Сидоренко Ігор Олегович',' sydorenko.igor@gmail.com',' +380981234567','sydorenko.igor','2024-05-01 12:00:00',' $2b$10$Y1JS/B77MV3Fms59.a89MOOgyZEHoTQOTaXuq6WE9N6VZkN8Lzavu'),(399,'Тетяна','tetianasendetska@gmail.com','0688296795','tetiana_','2025-07-12 15:13:12','ae74e53a6f447e10150dd2e83ad3f0289606aec5354ae31fe87f3500b802dfd2');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adress` varchar(45) DEFAULT NULL,
  `acceptance_time` datetime DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `sending_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_order_id_idx` (`order_id`),
  KEY `delivery_client_id_idx` (`client_id`),
  KEY `IX_Delivery_OrderId` (`order_id`),
  CONSTRAINT `delivery_client_id_idx` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `delivery_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,'вул. Левандівська, 1, м. Львів','2023-09-20 08:30:00',1,1,'2023-12-05 15:45:00'),(2,'вул. Городоцька, 15, м. Львів','2023-09-20 08:36:00',3,2,'2023-12-05 15:45:00'),(3,'вул. Франка, 50, м. Львів','2023-09-20 08:42:00',5,3,'2023-12-05 15:45:00'),(4,'просп. Свободи, 14, м. Львів','2023-09-20 08:48:00',7,4,'2023-12-05 15:45:00'),(5,'вул. Шевченка, 10, м. Львів','2023-09-20 08:54:00',9,5,'2023-12-05 15:45:00'),(6,'вул. Коперника, 22, м. Львів','2023-09-20 09:00:00',11,6,'2023-12-05 15:45:00'),(7,'вул. Винниченка, 5, м. Львів','2023-09-20 09:06:00',13,7,'2023-12-05 15:45:00'),(8,'вул. Личаківська, 30, м. Львів','2023-09-20 09:12:00',15,8,'2023-12-05 15:45:00'),(9,'вул. Мазепи, 7, м. Львів','2023-09-20 09:18:00',17,9,'2023-12-05 15:45:00'),(10,'вул. Зелена, 3, м. Львів','2023-09-20 09:24:00',19,10,'2023-12-05 15:45:00'),(11,'вул. Вітовського, 12, м. Львів','2023-09-20 09:30:00',21,11,'2023-12-05 15:45:00'),(12,'вул. Під Дубом, 8, м. Львів','2023-09-20 09:36:00',23,12,'2023-12-05 15:45:00'),(13,'вул. Личаківська, 45, м. Львів','2023-09-20 09:42:00',25,13,'2023-12-05 15:45:00'),(14,'вул. Мельника, 17, м. Львів','2023-09-20 09:48:00',27,14,'2023-12-05 15:45:00'),(15,'вул. Заводська, 9, м. Львів','2023-09-20 09:54:00',29,15,'2023-12-05 15:45:00'),(16,'вул. Галицька, 2, м. Львів','2023-09-20 10:00:00',31,16,'2023-12-05 15:45:00'),(17,'площа Ринок, 1, м. Львів','2023-09-20 10:06:00',33,17,'2023-12-05 15:45:00'),(18,'вул. Шашкевича, 19, м. Львів','2023-09-20 10:12:00',35,18,'2023-12-05 15:45:00'),(19,'вул. Пасічна, 8, м. Львів','2023-09-20 10:18:00',37,19,'2023-12-05 15:45:00'),(20,'вул. Івана Франка, 10, м. Львів','2023-09-20 10:24:00',39,20,'2023-12-05 15:45:00'),(21,'вул. В. Великого, 22, м. Львів','2023-09-20 10:30:00',41,21,'2023-12-05 15:45:00'),(22,'вул. Володимира, 14, м. Львів','2023-09-20 10:36:00',43,22,'2023-12-05 15:45:00'),(23,'вул. Шептицького, 9, м. Львів','2023-09-20 10:42:00',45,23,'2023-12-05 15:45:00'),(24,'вул. Сахарова, 3, м. Львів','2023-09-20 10:48:00',47,24,'2023-12-05 15:45:00'),(25,'вул. Високий Замок, 5, м. Львів','2023-09-20 10:54:00',49,25,'2023-12-05 15:45:00'),(26,'вул. Федьковича, 11, м. Львів','2023-09-20 11:00:00',51,26,'2023-12-05 15:45:00'),(27,'вул. Міцкевича, 7, м. Львів','2023-09-20 11:06:00',53,27,'2023-12-05 15:45:00'),(28,'вул. Чорновола, 20, м. Львів','2023-09-20 11:12:00',55,28,'2023-12-05 15:45:00'),(29,'вул. Мельнича, 2, м. Львів','2023-09-20 11:18:00',57,29,'2023-12-05 15:45:00'),(30,'вул. Перемоги, 18, м. Львів','2023-09-20 11:24:00',59,30,'2023-12-05 15:45:00'),(31,'вул. Жовківська, 24, м. Львів','2023-09-20 11:30:00',61,31,'2023-12-05 15:45:00'),(32,'вул. Котлярська, 5, м. Львів','2023-09-20 11:36:00',63,32,'2023-12-05 15:45:00'),(33,'вул. Шашкевича, 10, м. Львів','2023-09-20 11:42:00',65,33,'2023-12-05 15:45:00'),(34,'вул. Героїв Майдану, 7, м. Львів','2023-09-20 11:48:00',67,34,'2023-12-05 15:45:00'),(35,'вул. Мазепи, 14, м. Львів','2023-09-20 11:54:00',69,35,'2023-12-05 15:45:00'),(36,'вул. Пасічна, 5, м. Львів','2023-09-20 12:00:00',71,36,'2023-12-05 15:45:00'),(37,'вул. Глибока, 18, м. Львів','2023-09-20 12:06:00',73,37,'2023-12-05 15:45:00'),(38,'вул. Личаківська, 62, м. Львів','2023-09-20 12:12:00',75,38,'2023-12-05 15:45:00'),(39,'вул. Шептицького, 2, м. Львів','2023-09-20 12:18:00',77,39,'2023-12-05 15:45:00'),(40,'вул. Сахарова, 9, м. Львів','2023-09-20 12:24:00',79,40,'2023-12-05 15:45:00'),(41,'вул. Високий Замок, 1, м. Львів','2023-09-20 12:30:00',81,41,'2023-12-05 15:45:00'),(42,'вул. Федьковича, 18, м. Львів','2023-09-20 12:36:00',83,42,'2023-12-05 15:45:00'),(43,'вул. Міцкевича, 11, м. Львів','2023-09-20 12:42:00',85,43,'2023-12-05 15:45:00'),(44,'вул. Чорновола, 5, м. Львів','2023-09-20 12:48:00',87,44,'2023-12-05 15:45:00'),(45,'вул. Мельнича, 7, м. Львів','2023-09-20 12:54:00',89,45,'2023-12-05 15:45:00'),(46,'вул. Перемоги, 24, м. Львів','2023-09-20 13:00:00',91,46,'2023-12-05 15:45:00'),(47,'вул. Жовківська, 10, м. Львів','2023-09-20 13:06:00',93,47,'2023-12-05 15:45:00'),(48,'вул. Котлярська, 3, м. Львів','2023-09-20 13:12:00',95,48,'2023-12-05 15:45:00'),(49,'вул. Шашкевича, 7, м. Львів','2023-09-20 13:18:00',97,49,'2023-12-05 15:45:00'),(50,'вул. Героїв Майдану, 12, м. Львів','2023-09-20 13:24:00',99,50,'2023-12-05 15:45:00'),(53,'fgh','2024-04-12 23:06:31',100,1,NULL),(54,'ПРацюєє!!!','2024-04-13 18:29:59',100,1,NULL),(55,'ще раз','2024-04-13 18:31:14',150,1,NULL),(56,'Київ','2024-04-15 19:29:46',151,1,NULL),(57,'Львів','2024-04-22 21:10:56',154,1,NULL),(58,'Львів','2024-04-22 21:13:29',155,NULL,NULL),(59,'Бережани','2024-04-22 21:20:32',156,53,NULL),(60,'5 корпус Політехніки','2024-04-28 00:58:00',158,57,NULL),(61,'4 корпус Політехніки','2024-04-28 00:59:10',159,57,NULL),(62,'29 коло пекла','2024-04-28 01:00:23',160,57,NULL),(63,'пекло','2024-04-28 01:02:44',161,57,NULL),(64,'Львів','2024-04-28 21:39:52',165,53,NULL),(65,'вул Хмельницького 5','2025-07-12 15:14:16',170,399,NULL);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drink_menu`
--

DROP TABLE IF EXISTS `drink_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drink_menu` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `ml` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_DrinkMenu_Type` (`type`),
  KEY `IX_DrinkMenu_Price` (`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drink_menu`
--

LOCK TABLES `drink_menu` WRITE;
/*!40000 ALTER TABLE `drink_menu` DISABLE KEYS */;
INSERT INTO `drink_menu` VALUES (101,'Еспресо',30.00,'в наявності','Кава',250),(102,'Допіо',44.00,'в наявності','Кава',250),(103,'Капучино',50.00,'в наявності','Кава',250),(104,'Лате',50.00,'не в наявності','Кава',250),(105,'Американо',35.00,'в наявності','Кава',250),(106,'Американо з молоком',40.00,'в наявності','Кава',250),(107,'Раф кава',60.00,'в наявності','Кава',250),(108,'Мокачино',74.00,'в наявності','Кава',400),(109,'Турецька кава',61.00,'не в наявності','Кава',230),(110,'Горіхове мокачино',83.00,'в наявності','Кава',500),(111,'Айріш кава',80.00,'в наявності','Кава',400),(112,'Медове капучино',65.00,'в наявності','Кава',400),(113,'Романо',63.00,'в наявності','Кава',400),(114,'Раф полуничний',77.00,'в наявності','Кава',400),(115,'Солона карамель',63.00,'в наявності','Кава',400),(116,'П\'яна вишня',70.00,'в наявності','Кава',250),(201,'Зелений чай',49.00,'в наявності','Чай',300),(202,'Чорний чай',49.00,'в наявності','Чай',300),(203,'Трав\'яний чай',49.00,'в наявності','Чай',300),(204,'Чай з імбирем',62.00,'в наявності','Чай',300),(205,'Чай з обліпихи',62.00,'в наявності','Чай',300),(206,'Чай з журавлини',62.00,'в наявності','Чай',300),(207,'Чай з калини',62.00,'в наявності','Чай',300),(208,'Чай з смородини',62.00,'не в наявності','Чай',300),(209,'Турецький чай',34.55,'не в наявності','Чай',300),(210,'Імператорський чай',85.00,'не в наявності','Чай',300),(301,'Гіркий гарячий шоколад',59.00,'в наявності','Гарячий шоколад',230),(302,'Молочний гарячий шоколад',59.00,'в наявності','Гарячий шоколад',230),(303,'Шоколад з корицею',64.00,'в наявності','Гарячий шоколад',230),(304,'Білий гарячий шоколад',59.00,'в наявності','Гарячий шоколад',230),(401,'Айс лате',70.00,'в наявності','Холодні напої',400),(402,'Айс лате cream',80.00,'в наявності','Холодні напої',400),(403,'Фраппе',43.00,'в наявності','Холодні напої',300),(404,'Матча оранж',75.00,'в наявності','Холодні напої',400),(405,'Блакитна матча айс',75.00,'в наявності','Холодні напої',400),(406,'Оранж еспресо',70.00,'в наявності','Холодні напої',400),(407,'Еспресо тонік',70.00,'в наявності','Холодні напої',400),(408,'Мохіто лимон',60.00,'в наявності','Холодні напої',400),(409,'Мохіто лайм',66.00,'в наявності','Холодні напої',400),(501,'Класичний лимонад',60.00,'в наявності','Лимонади',400),(502,'Вишневий лимонад',70.00,'в наявності','Лимонади',400),(503,'Огірковий лимонад',75.00,'в наявності','Лимонади',400),(504,'Лавандовий лимонад',80.00,'не в наявності','Лимонади',400),(601,'Апельсиновий сік',30.00,'в наявності','Соки',300),(602,'Томатний сік',30.00,'не в наявності','Соки',300),(603,'Мультифруктовий сік',30.00,'в наявності','Соки',300),(604,'Виноградний сік',30.00,'не в наявності','Соки',300),(605,'Яблучний сік',30.00,'в наявності','Соки',300),(606,'Ананасовий сік',30.00,'в наявності','Соки',300),(607,'Персиковий сік',30.00,'в наявності','Соки',300);
/*!40000 ALTER TABLE `drink_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `position` varchar(45) DEFAULT NULL,
  `salary` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1001,'Лисенко Ірина Олексіївна','1989-07-15','Офіціант',12601.00),(1002,'Петренко Марія Петрівна','1988-07-20','Офіціант',12505.00),(1003,'Лисенко Наталія Ігорівна','1991-04-30','Офіціант',12600.00),(1004,'Денисенко Оксана Миколаївна','1992-06-28','Офіціант',12500.00),(1005,'Павлюк Вікторія Петрівна','1989-07-12','Офіціант',12600.00),(1006,'Міщенко Олена Василівна','1988-12-15','Офіціант',12500.00),(1008,'Остапенко Ірина Володимирівна','1988-10-05','Офіціант',12500.00),(1009,'Попова Ольга Вікторівна','1989-07-16','Офіціант',12600.00),(1010,'Кузьменко Ірина Миколаївна','1988-11-19','Офіціант',12500.00),(1011,'Кузнецова Аліна Олександрівна','1989-09-23','Офіціант',12600.00),(1012,'Олійник Валентина Вікторівна','1988-10-04','Офіціант',12500.00),(1013,'Денисова Олена Олександрівна','1988-11-18','Офіціант',12500.00),(1014,'Іваненко Іван Іванович','1990-05-15','Офіціант',13000.00),(1015,'Коваленко Олександр Петрович','1995-03-10','Офіціант',13500.00),(1016,'Мельник Олексій Сергійович','1985-08-12','Офіціант',13600.00),(1017,'Ляшенко Ігор Володимирович','1987-04-02','Офіціант',13600.00),(1018,'Шевченко Андрій Олександрович','1993-02-28','Офіціант',13500.00),(1019,'Жукова Наталія Михайлівна','1987-11-14','Офіціант',13600.00),(1020,'Кравчук Олег Андрійович','1993-04-18','Офіціант',13500.00),(2001,'Кравченко Володимир Олександрович','1986-04-28','Кухар',13600.00),(2002,'Сергієнко Олег Анатолійович','1993-03-24','Кухар',13500.00),(2003,'Іванов Віталій Петрович','1987-11-15','Кухар',13600.00),(2004,'Сідоров Олександр Олександрович','1993-04-17','Кухар',13500.00),(2005,'Коваль Андрій Миколайович','1986-04-29','Кухар',13600.00),(2006,'Ковальчук Андрій Володимирович','1991-07-11','Кухар',13100.00),(2007,'Кравченко Андрій Олегович','1990-06-21','Кухар',13000.00),(2008,'Петренко Ігор Андрійович','1991-12-02','Кухар',13100.00),(2009,'Коваленко Владислав Юрійович','1990-06-07','Кухар',13000.00),(3001,'Григоренко Віктор Михайлович','1987-12-08','Бариста',13100.00),(3002,'Павленко Ігор Павлович','1994-10-05','Бариста',13000.00),(3003,'Бондаренко Максим Михайлович','1990-09-08','Бариста',13100.00),(3004,'Даниленко Сергій Павлович','1991-08-10','Бариста',13000.00),(3005,'Костенко Віталій Миколайович','1992-07-03','Бариста',13100.00),(3006,'Герасименко Денис Вікторович','1990-06-20','Бариста',13000.00),(3007,'Литвиненко Ігор Іванович','1991-12-03','Бариста',13100.00),(3008,'Жданов Максим Андрійович','1990-06-08','Бариста',13000.00),(4001,'Сидоренко Ольга Анатоліївна','1993-09-25','Менеджер',12800.00),(4002,'Тимченко Марина Володимирівна','1989-02-18','Менеджер',12900.00),(4003,'Максименко Ірина Ігорівна','1986-11-20','Менеджер',12800.00),(4004,'Гончаренко Маргарита Олександрівна','1994-01-25','Менеджер',12900.00),(4005,'Іванова Лариса Вікторівна','1986-05-18','Менеджер',12800.00),(4006,'Мироненко Анна Олександрівна','1994-03-08','Менеджер',12900.00),(4007,'Данилова Тетяна Сергіївна','1987-08-22','Менеджер',12800.00),(4008,'Макаренко Світлана Валентинівна','1994-02-10','Менеджер',12900.00),(4009,'Мельник Інна Сергіївна','1987-05-07','Менеджер',12800.00),(4010,'Марченко Ірина Андріївна','1994-03-09','Менеджер',12900.00),(4011,'Im tired','2004-01-09','Прибиральник',20000.00);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_menu`
--

DROP TABLE IF EXISTS `food_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_menu` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status_food` (`status`),
  KEY `IX_FoodMenu_Price` (`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_menu`
--

LOCK TABLES `food_menu` WRITE;
/*!40000 ALTER TABLE `food_menu` DISABLE KEYS */;
INSERT INTO `food_menu` VALUES (101,'Сіміт',17.00,'в наявності'),(102,'Флорентина з мигдалем',23.00,'не в наявності'),(103,'Флорентина з кунжутом',21.00,'в наявності'),(104,'Печиво корзинка з горіхами',21.00,'в наявності'),(105,'Турецьке шекерпаре',15.00,'в наявності'),(106,'Печиво шоколадне',23.00,'в наявності'),(107,'Капкейк',25.00,'в наявності'),(108,'Еклер з заварним кремом',25.00,'в наявності'),(109,'Горіхи в шоколаді',25.00,'в наявності'),(110,'Вівсяне печиво',17.00,'не в наявності'),(111,'Печиво шоколадно-горіхове',23.00,'в наявності'),(112,'Еклер з карамелю',24.00,'в наявності'),(113,'Печиво з мигдалем',21.00,'в наявності'),(114,'Карамельне суфле',39.00,'в наявності'),(115,'Горіхове праліне',21.00,'в наявності'),(116,'Шоколодний кексік',28.00,'в наявності'),(117,'Карамельне тістечко',35.00,'в наявності'),(118,'Профітроли',43.00,'в наявності'),(119,'Фиринда сютлач',39.00,'в наявності'),(120,'Тірамісу',53.00,'в наявності'),(121,'Тістечко ягідне',38.00,'в наявності'),(122,'Корзинка з фруктами',43.00,'в наявності'),(123,'Мигдальне тістечко',45.00,'в наявності'),(124,'Пудинг банановий',39.00,'в наявності'),(125,'Пудинг полуничник',39.00,'в наявності'),(126,'Пудинг шоколадний',39.00,'в наявності'),(127,'Панна котта',47.00,'не в наявності'),(128,'Круасан',32.00,'в наявності'),(129,'Торт карамельно-горіховий',33.00,'в наявності'),(130,'Сирник з маком',33.00,'в наявності'),(131,'Торт наполеон',29.00,'в наявності'),(132,'Медівник з чорносливом',31.50,'в наявності'),(133,'Торт шоколадний',35.00,'в наявності'),(134,'Торт спартак',31.00,'в наявності'),(135,'Торт суббота',31.00,'в наявності'),(136,'Штрудель з вишнею',31.50,'в наявності'),(137,'Штрудель з яблуком',30.00,'в наявності'),(138,'Ягідний пиріг',35.00,'не в наявності'),(139,'Персиковий торт',30.00,'в наявності'),(140,'Сирник з персиком',33.00,'в наявності'),(141,'Чіз-кейк з смородиною',33.00,'не в наявності'),(142,'Банановий торт',31.00,'в наявності'),(143,'Яблучний пиріг',30.00,'не в наявності'),(144,'Локум',45.00,'не в наявності'),(145,'Вишневий пиріг',35.00,'в наявності'),(146,'Шоколадний клафуті',30.00,'в наявності'),(147,'Морозиво в асортименті',39.00,'в наявності'),(148,'Морозиво з фруктами',45.00,'в наявності'),(149,'Сендвіч з шинкою',86.00,'в наявності'),(150,'Сендвіч з лососем',85.00,'в наявності'),(151,'Сендвіч з індичкою та сиром',65.00,'в наявності');
/*!40000 ALTER TABLE `food_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acceptance_time` datetime DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `takeout` tinyint DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_table_id_idx` (`table_id`),
  KEY `IX_Order_AcceptanceTime` (`acceptance_time`),
  KEY `IX_Order_Status` (`status`),
  KEY `order_client_id_idx` (`user_id`),
  CONSTRAINT `order_client_id` FOREIGN KEY (`user_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `order_table_id` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2023-09-20 08:00:00',0,1,'149',NULL),(2,'2023-09-20 08:03:00',1,0,'Скасовано',2),(3,'2023-09-20 08:06:00',0,1,'Завершено',4),(4,'2023-09-20 08:09:00',2,0,NULL,NULL),(5,'2023-09-20 08:12:00',0,1,NULL,NULL),(6,'2023-09-20 08:15:00',3,0,'В процесі',5),(7,'2023-09-20 08:18:00',0,1,'Завершено',7),(8,'2023-09-20 08:21:00',4,0,NULL,NULL),(9,'2023-09-20 08:24:00',0,1,NULL,NULL),(10,'2023-09-20 08:27:00',5,0,NULL,NULL),(11,'2023-09-20 08:30:00',0,1,NULL,NULL),(12,'2023-09-20 08:33:00',6,0,NULL,NULL),(13,'2023-09-20 08:36:00',0,1,NULL,NULL),(14,'2023-09-20 08:39:00',7,0,NULL,NULL),(15,'2023-09-20 08:42:00',0,1,NULL,NULL),(16,'2023-09-20 08:45:00',8,0,NULL,NULL),(17,'2023-09-20 08:48:00',0,1,NULL,NULL),(18,'2023-09-20 08:51:00',9,0,NULL,NULL),(19,'2023-09-20 08:54:00',0,1,NULL,NULL),(20,'2023-09-20 08:57:00',10,0,NULL,NULL),(21,'2023-09-20 09:00:00',0,1,NULL,NULL),(22,'2023-09-20 09:03:00',11,0,NULL,NULL),(23,'2023-09-20 09:06:00',0,1,NULL,NULL),(24,'2023-09-20 09:09:00',12,0,NULL,NULL),(25,'2023-09-20 09:12:00',0,1,NULL,NULL),(26,'2023-09-20 09:15:00',13,0,NULL,NULL),(27,'2023-09-20 09:18:00',0,1,NULL,NULL),(28,'2023-09-20 09:21:00',14,0,NULL,NULL),(29,'2023-09-20 09:24:00',0,1,NULL,NULL),(30,'2023-09-20 09:27:00',15,0,NULL,NULL),(31,'2023-09-20 09:30:00',0,1,NULL,NULL),(32,'2023-09-20 09:33:00',16,0,NULL,NULL),(33,'2023-09-20 09:36:00',0,1,NULL,NULL),(34,'2023-09-20 09:39:00',17,0,NULL,NULL),(35,'2023-09-20 09:42:00',0,1,NULL,NULL),(36,'2023-09-20 09:45:00',18,0,NULL,NULL),(37,'2023-09-20 09:48:00',0,1,NULL,NULL),(38,'2023-09-20 09:51:00',19,0,NULL,NULL),(39,'2023-09-20 09:54:00',0,1,NULL,NULL),(40,'2023-09-20 09:57:00',20,0,NULL,NULL),(41,'2023-09-20 10:00:00',0,1,NULL,NULL),(42,'2023-09-20 10:03:00',21,0,NULL,NULL),(43,'2023-09-20 10:06:00',0,1,NULL,NULL),(44,'2023-09-20 10:09:00',22,0,NULL,NULL),(45,'2023-09-20 10:12:00',0,1,NULL,NULL),(46,'2023-09-20 10:15:00',23,0,NULL,NULL),(47,'2023-09-20 10:18:00',0,1,NULL,NULL),(48,'2023-09-20 10:21:00',24,0,NULL,NULL),(49,'2023-09-20 10:24:00',0,1,NULL,NULL),(50,'2023-09-20 10:27:00',25,0,NULL,NULL),(51,'2023-09-20 10:30:00',0,1,NULL,NULL),(52,'2023-09-20 10:33:00',26,0,NULL,NULL),(53,'2023-09-20 10:36:00',0,1,NULL,NULL),(54,'2023-09-20 10:39:00',27,0,NULL,NULL),(55,'2023-09-20 10:42:00',0,1,NULL,NULL),(56,'2023-09-20 10:45:00',28,0,NULL,NULL),(57,'2023-09-20 10:48:00',0,1,NULL,NULL),(58,'2023-09-20 10:51:00',29,0,NULL,NULL),(59,'2023-09-20 10:54:00',0,1,NULL,NULL),(60,'2023-09-20 10:57:00',30,0,NULL,NULL),(61,'2023-09-20 11:00:00',0,1,NULL,NULL),(62,'2023-09-20 11:03:00',31,0,NULL,NULL),(63,'2023-09-20 11:06:00',0,1,NULL,NULL),(64,'2023-09-20 11:09:00',32,0,NULL,NULL),(65,'2023-09-20 11:12:00',0,1,NULL,NULL),(66,'2023-09-20 11:15:00',33,0,NULL,NULL),(67,'2023-09-20 11:18:00',0,1,NULL,NULL),(68,'2023-09-20 11:21:00',34,0,NULL,NULL),(69,'2023-09-20 11:24:00',0,1,NULL,NULL),(70,'2023-09-20 11:27:00',35,0,NULL,NULL),(71,'2023-09-20 11:30:00',0,1,NULL,NULL),(72,'2023-09-20 11:33:00',36,0,NULL,NULL),(73,'2023-09-20 11:36:00',0,1,NULL,NULL),(74,'2023-09-20 11:39:00',37,0,NULL,NULL),(75,'2023-09-20 11:42:00',0,1,NULL,NULL),(76,'2023-09-20 11:45:00',38,0,NULL,NULL),(77,'2023-09-20 11:48:00',0,1,NULL,NULL),(78,'2023-09-20 11:51:00',39,0,NULL,NULL),(79,'2023-09-20 11:54:00',0,1,NULL,NULL),(80,'2023-09-20 11:57:00',40,0,NULL,NULL),(81,'2023-09-20 12:00:00',0,1,NULL,NULL),(82,'2023-09-20 12:03:00',41,0,NULL,NULL),(83,'2023-09-20 12:06:00',0,1,NULL,NULL),(84,'2023-09-20 12:09:00',42,0,NULL,NULL),(85,'2023-09-20 12:12:00',0,1,NULL,NULL),(86,'2023-09-20 12:15:00',43,0,NULL,NULL),(87,'2023-09-20 12:18:00',0,1,NULL,NULL),(88,'2023-09-20 12:21:00',44,0,NULL,NULL),(89,'2023-09-20 12:24:00',0,1,NULL,NULL),(90,'2023-09-20 12:27:00',45,0,NULL,NULL),(91,'2023-09-20 12:30:00',0,1,NULL,NULL),(92,'2023-09-20 12:33:00',46,0,NULL,NULL),(93,'2023-09-20 12:36:00',0,1,NULL,NULL),(94,'2023-09-20 12:39:00',47,0,NULL,NULL),(95,'2023-09-20 12:42:00',0,1,NULL,NULL),(96,'2023-09-20 12:45:00',48,0,NULL,NULL),(97,'2023-09-20 12:48:00',0,1,NULL,NULL),(98,'2023-09-20 12:51:00',49,0,NULL,NULL),(99,'2023-09-20 12:54:00',0,1,NULL,NULL),(100,'2023-09-20 12:57:00',50,0,NULL,NULL),(149,'2024-04-13 18:29:59',0,1,'Завершено',1),(150,'2024-04-13 18:31:13',0,1,'В процесі',1),(151,'2024-04-15 19:29:45',0,1,'В процесі',1),(152,'2024-04-15 21:25:21',0,0,'Завершено',1),(153,'2024-04-15 21:26:47',0,0,'undefined',1),(154,'2024-04-22 21:10:55',0,1,'Прийнято',53),(155,'2024-04-22 21:13:29',0,1,'Завершено',53),(156,'2024-04-22 21:20:31',0,1,'Завершено',53),(157,'2024-04-22 21:36:49',0,0,'undefined',54),(158,'2024-04-28 00:58:00',0,1,'Прийнято',57),(159,'2024-04-28 00:59:09',0,1,'Прийнято',57),(160,'2024-04-28 01:00:22',0,1,'Прийнято',57),(161,'2024-04-28 01:02:44',0,1,'Завершено',57),(162,'2024-04-28 21:03:42',0,0,'Прийнято',57),(163,'2024-04-28 21:04:28',0,0,'Прийнято',57),(164,'2024-04-28 21:05:45',0,0,'Прийнято',57),(165,'2024-04-28 21:39:52',0,1,'Завершено',53),(166,'2024-04-29 18:34:00',0,0,'Прийнято',57),(167,'2024-04-29 20:25:30',0,0,'Прийнято',54),(168,'2024-04-30 17:20:18',0,0,'Прийнято',53),(169,'2024-04-30 17:30:52',0,0,'Прийнято',53),(170,'2025-07-12 15:14:15',0,1,'Завершено',399);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_drinks`
--

DROP TABLE IF EXISTS `ordered_drinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_drinks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `drink_id` int DEFAULT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ordered_drinks_order_id_idx` (`order_id`),
  KEY `ordered_drinks_drink_id_idx` (`drink_id`),
  KEY `IX_OrderedDrink_OrderId` (`order_id`),
  CONSTRAINT `ordered_drinks_drink_id` FOREIGN KEY (`drink_id`) REFERENCES `drink_menu` (`id`),
  CONSTRAINT `ordered_drinks_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_drinks`
--

LOCK TABLES `ordered_drinks` WRITE;
/*!40000 ALTER TABLE `ordered_drinks` DISABLE KEYS */;
INSERT INTO `ordered_drinks` VALUES (2,149,107,1),(3,150,107,0),(4,151,209,3),(5,152,603,2),(6,153,605,1),(7,154,103,1),(8,155,104,1),(9,156,202,1),(10,157,604,3),(11,158,205,1),(12,158,502,1),(13,158,605,1),(14,159,405,1),(15,160,304,1),(16,162,601,3),(17,163,502,1),(18,165,102,2),(19,167,113,1),(20,169,111,1),(21,169,202,2),(22,170,103,3);
/*!40000 ALTER TABLE `ordered_drinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_food`
--

DROP TABLE IF EXISTS `ordered_food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ordered_food_order_id_idx` (`order_id`),
  KEY `ordered_food_food_id_idx` (`food_id`),
  KEY `IX_OrderedFood_OrderId` (`order_id`),
  CONSTRAINT `ordered_food_food_id` FOREIGN KEY (`food_id`) REFERENCES `food_menu` (`id`),
  CONSTRAINT `ordered_food_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_food`
--

LOCK TABLES `ordered_food` WRITE;
/*!40000 ALTER TABLE `ordered_food` DISABLE KEYS */;
INSERT INTO `ordered_food` VALUES (15,149,106,0),(16,149,104,0),(17,150,106,0),(18,150,104,0),(19,151,107,1),(20,152,108,1),(21,152,117,1),(22,152,148,1),(23,154,101,1),(24,155,102,1),(25,158,103,1),(26,159,103,1),(27,160,118,1),(28,161,124,1),(29,161,126,1),(30,162,103,1),(31,164,101,1),(32,165,147,3),(33,166,146,2),(34,167,135,1),(35,168,120,1),(36,170,109,1),(37,170,107,1);
/*!40000 ALTER TABLE `ordered_food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_id` int DEFAULT NULL,
  `reservation_time` datetime DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_client_id_idx` (`client_id`),
  KEY `reservation_table_id_idx` (`table_id`),
  CONSTRAINT `reservation_client_id_idx` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `reservation_table_id` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,1,'2023-09-20 14:00:00',1),(2,2,'2023-09-21 15:30:00',2),(3,3,'2023-09-22 16:15:00',3),(4,4,'2023-09-23 17:45:00',4),(5,5,'2023-09-24 18:30:00',5),(6,6,'2023-09-25 19:20:00',6),(7,7,'2023-09-26 20:10:00',7),(8,8,'2023-09-27 21:00:00',8),(9,9,'2023-09-28 14:30:00',9),(10,10,'2023-09-29 15:45:00',10),(11,11,'2023-09-30 16:20:00',11),(12,12,'2023-10-01 17:00:00',12),(13,13,'2023-10-02 18:30:00',13),(14,14,'2023-10-03 19:45:00',14),(15,15,'2023-10-04 20:15:00',15),(16,16,'2023-10-05 21:00:00',16),(17,17,'2023-10-06 14:15:00',17),(18,18,'2023-10-07 15:30:00',18),(19,19,'2023-10-08 16:45:00',19),(20,20,'2023-10-09 17:30:00',20),(21,21,'2023-10-10 14:00:00',21),(22,22,'2023-10-11 15:30:00',22),(23,23,'2023-10-12 16:15:00',23),(24,22,'2023-10-13 17:45:00',24),(25,25,'2023-10-14 18:30:00',25),(26,26,'2023-10-15 19:20:00',26),(27,27,'2023-10-16 20:10:00',27),(28,28,'2023-10-17 21:00:00',28),(29,29,'2023-10-18 14:30:00',29),(30,30,'2023-10-19 15:45:00',30),(34,24,'2024-04-12 22:29:37',1),(35,31,'2024-04-12 22:39:01',1);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(2,'user');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_report`
--

DROP TABLE IF EXISTS `sales_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `datetime` datetime DEFAULT NULL,
  `amount_of_sales` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_SalesReport_Datetime` (`datetime`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_report`
--

LOCK TABLES `sales_report` WRITE;
/*!40000 ALTER TABLE `sales_report` DISABLE KEYS */;
INSERT INTO `sales_report` VALUES (1,'2023-09-01 00:00:00',30000.00),(2,'2023-09-02 00:00:00',31000.00),(3,'2023-09-03 00:00:00',32000.00),(4,'2023-09-04 00:00:00',33000.00),(5,'2023-09-05 00:00:00',34000.00),(6,'2023-09-06 00:00:00',35000.00),(7,'2023-09-07 00:00:00',36000.00),(8,'2023-09-08 00:00:00',37000.00),(9,'2023-09-09 00:00:00',38000.00),(10,'2023-09-10 00:00:00',39000.00),(11,'2023-09-11 00:00:00',40000.00),(12,'2023-09-12 00:00:00',41000.00),(13,'2023-09-13 00:00:00',42000.00),(14,'2023-09-14 00:00:00',43000.00),(15,'2023-09-15 00:00:00',44000.00),(16,'2023-09-16 00:00:00',45000.00),(17,'2023-09-17 00:00:00',46000.00),(18,'2023-09-18 00:00:00',47000.00),(19,'2023-09-19 00:00:00',48000.00),(20,'2023-09-20 00:00:00',0.00),(21,'2023-09-21 00:00:00',49000.00),(22,'2023-09-22 00:00:00',48000.00),(23,'2023-09-23 00:00:00',47000.00),(24,'2023-09-24 00:00:00',46000.00),(25,'2023-09-25 00:00:00',45000.00),(26,'2023-09-26 00:00:00',44000.00),(27,'2023-09-27 00:00:00',43000.00),(28,'2023-09-28 00:00:00',42000.00),(29,'2023-09-29 00:00:00',41000.00),(30,'2023-09-30 00:00:00',40000.00),(31,'2023-10-01 00:00:00',39000.00),(32,'2023-10-02 00:00:00',38000.00),(33,'2023-10-03 00:00:00',37000.00),(34,'2023-10-04 00:00:00',36000.00),(35,'2023-10-05 00:00:00',35000.00),(36,'2023-10-06 00:00:00',34000.00),(37,'2023-10-07 00:00:00',33000.00),(38,'2023-10-08 00:00:00',32000.00),(39,'2023-10-09 00:00:00',31000.00),(40,'2023-10-10 00:00:00',30000.00),(41,'2023-10-11 00:00:00',49000.00),(42,'2023-10-12 00:00:00',48000.00),(43,'2023-10-13 00:00:00',47000.00),(44,'2023-10-14 00:00:00',46000.00),(45,'2023-10-15 00:00:00',45000.00),(46,'2023-10-16 00:00:00',44000.00),(47,'2023-10-17 00:00:00',43000.00),(48,'2023-10-18 00:00:00',42000.00),(49,'2023-10-19 00:00:00',41000.00),(50,'2023-10-20 00:00:00',40000.00),(51,'2024-04-22 00:00:00',73.00),(52,'2024-04-15 00:00:00',165.00),(53,'2024-04-13 00:00:00',60.00),(54,'2024-04-28 00:00:00',283.00),(55,'2025-07-12 00:00:00',200.00);
/*!40000 ALTER TABLE `sales_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `id` int NOT NULL,
  `number_of_seats` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (0,0),(1,2),(2,4),(3,2),(4,4),(5,2),(6,4),(7,2),(8,4),(9,2),(10,4),(11,2),(12,4),(13,2),(14,4),(15,2),(16,4),(17,2),(18,4),(19,2),(20,4),(21,2),(22,4),(23,2),(24,4),(25,2),(26,4),(27,2),(28,4),(29,2),(30,4),(31,2),(32,4),(33,2),(34,4),(35,2),(36,4),(37,2),(38,4),(39,2),(40,4),(41,2),(42,4),(43,2),(44,4),(45,2),(46,4),(47,2),(48,4),(49,2),(50,4);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(70) DEFAULT NULL,
  `role` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `users_role_id_idx` (`role`),
  KEY `IX_User_Username` (`username`),
  CONSTRAINT `users_role_id` FOREIGN KEY (`role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','1411242b2139f9fa57a802e1dc172e3e1ca7655ac2d06d83b22958951072261b',1),(2,'tetiana','1411242b2139f9fa57a802e1dc172e3e1ca7655ac2d06d83b22958951072261b',2),(3,'mukhataras','1df1854015e31ca286d015345eaff29a6c6073f70984a3a746823d4cac16b075',2),(5,'harrypotter','f61a20da9eaa68a9f06dbc1710b10ef0a67208b2059b1f576af6deac23c215f5',2),(7,'tkachenko.maria','$2b$10$pt4C1Y6rC..dDWl0rVvK3us2LlcA0Pb3avv.QIO',2),(8,'bondarenko.ivan','$2b$10$v6D4jYzB3qX0NUOfp5hCReN9T2mfFd1WHe1FTbfx7.kz3GA3sY0Zm',2),(9,'kovalenko.larysa','$2b$10$rAB5J.kWVzGuKkNywMxiTe.svVYg00x7Z0/1i0Eos9a2D9.3lhffG',2),(10,'melnik.stepan','$2b$10$hs.WoAGJgXV7cA8aerqTF.kNBGoeewgkSyTC7hVz5WVYtUKDGqj0G',2),(11,'petrenko.yevheniya','$2b$10$Z5pYun5nSPy3VlNsBC48X.v/qW8U.1enJtOOgFQjZzvLdz8NBvL5O',2),(12,'lytvyn.oleksandr',' $2b$10$e7UgD10aAtCBteGpLHwjheFnQ/LK87H0hqgEX5xVcX3gt.YrG5MGy',2),(13,'sydorenko.liudmyla',' $2b$10$1/ufZqG4D5CfHph9Iq7pu.rqP4fD4UnK2cLXH2ReAbU01e8FlVRje',2),(14,'martynenko.anna',' $2b$10$XVxgDEOwE2NUmh4QcI2cM.z5yLJ0bMfQHqbKgR6F8z8/TXjV/qVo2',2),(15,'honchar.oleksiy',' $2b$10$zIqMAqNsAehHUBeX7a1qae1nCYKXsQYUvlcf6eJfZyQHsUwv90Sg2',2),(16,'shevchenko.oksana',' $2b$10$me0H1kYV6nHb3V7YL9n.4OIBplvPbFNNbCslFyZd0W3EwJltlZC4K',2),(17,'kovalchuk.irina',' $2b$10$0U0fYzo8geKsUov/7oYrZO5sm8JNNOaIvl4tkb3F83lm/UqkEPrBy',2),(18,'myronenko.dmytro',' $2b$10$3cBw67IQb1pqrI3.B8Kvhe2tMgYw1RQbQBMIE.eeyjWl9o0V0zNXG',2),(19,'kravchenko.liudmyla',' $2b$10$5VsZDE.rF1iFVf8mnPNrqe3WKE5s3zrKf2Zx.YQOH9qGnPtDXFkgW',2),(20,'petrenko.oleksandr',' $2b$10$ofb6gQ3oJZLc5N/ELZu6uexziyFQjC5TThW3/IRU8Cj5NlwRhQ0CK',2),(21,'bondarenko.oksana',' $2b$10$mt7e1WtRU1VM5IUjHAWKQeswyk6L33QGd67b/m2GqWDqGEuVq21z6',2),(22,'kovalenko.yevgen',' $2b$10$1hJkCj2ptbVT3vYkUprqIeJno5r8bNqpxEnyTbtTXxS2W.qaYFRPW',2),(23,'melnik.olena',' $2b$10$zgKnh4FT9I0KcyHHoHKMK.1uCEb4C3h8ohEr2CRDFhE0UbNJN7T.q',2),(24,'honcharuk.max',' $2b$10$0f1Mq2CHkctMW9FX6mpLu.b8sB9s6dFrOUnuxs9sQyF53z/FiA4eq',2),(25,'timoshenko.anna',' $2b$10$2gVM./UOYKb3o7LlpdvcS.JVADs3VVj5BzO9U.L6hJ9tIYtER5lPe',2),(26,'lisenko.viktor',' $2b$10$cmI63vWvMYvQXktRHxVRNObY0/g9LW2rC/8ye9M39fbVTkFYbZGMe',2),(27,'sydorenko.olena',' $2b$10$JLP1UY2E2p7y9RDx2SSSD.6UPs6K0SHrG2V2T8ZSWArYut7s3Qcim',2),(28,'martynenko.iryna',' $2b$10$D3sGwd1g4ve7hrU8t6JGHupmGWXC.TS.1Q9FcyaYwv2B1nRr.8ctW',2),(29,'hryhorovych.volodymyr',' $2b$10$htzVjPYz3Ld92ZdCv4Q.CuELr3CEQZ0VO3j8q7EkCgNp4emgHXaFq',2),(30,'kovalenko.yulia',' $2b$10$0bZkEDC.jQyrF9SbbCFv5uFvFFpuxYZWmW7aJKCf1l.9BMP/3qXmO',2),(31,'petrenko.oleksiy',' $2b$10$8zpmNqSdtz0vZv3K.UeTr.2/8Rm5nRkwW4bMxqk1OQjJlQJk4.cDm',2),(32,'bondarenko.tetiana',' $2b$10$PtbH3XoJvvPOFw0.Mhjdb.hQfoXZv1k9Al.1dxfkx26xlbPQfIvHy',2),(33,'kovalenko.dmytro',' $2b$10$8z49fOJ9YfsR9TLoq5yG9.Dv3C0S9YOav6DgOQR4wnzPPdQ2Bc.Dy',2),(34,'melnik.maria',' $2b$10$JAKbcqJStcgxSh6NdWpZdO0WTIuYHDz7qwsfTm87w2df4OnMDcV.e',2),(35,'honcharuk.sergiy',' $2b$10$UqSavQzzyahcO9E8JKYpVehRfU.9efGiFtjxRgh4N1moQs.BIgq/e',2),(36,'timoshenko.ivanna',' $2b$10$EDNQjVkYMQIzFfHTXkqzbuXp9Z.wXSS82EQ4vE7AeBIB.AjhaZZ0K',2),(37,'lisenko.anna',' $2b$10$S2P94W5pV4yUbT0ycX/5UOvB8blsYJxJ.JBYeGkzJ9lS.CmfGfnXa',2),(38,'sydorenko.vasyl',' $2b$10$uJgQ7X70UV8M5APMxZYEnuYQW6j3TXvALp3UOlkABp4NL/2xYUbqy',2),(39,'martynenko.denis',' $2b$10$kDrY2hDqQZmYpBRMdk1dR.B0kYs7.FJUQltVSlJxxv3P/1E2lRqTS',2),(40,'hryhorovych.iryna',' $2b$10$SMNujpNR0htP.g1VkgVoF.bxJJZceVCMljOeGxclLdwURyzqCDd2.',2),(41,'kovalenko.lesia',' $2b$10$7bhPTL80VZ83ZrsZtoYmHuT6c..Oww5QX8oW7LlmAeQ3UmQf26CLq',2),(42,'petrenko.oleg',' $2b$10$KubcY2gGpx59NkF6tKgxWeG9DgjB6D0IY3fR3hHD7.7gWl6Y5eT9i',2),(43,'bondarenko.igor',' $2b$10$IdQSTsP/IYwRJr3F1tpICOTUkEIM/LLiE7hXc0FwOjptwR/Ox6BWq',2),(44,'kovalenko.sergiy',' $2b$10$RIzX2KvxL9qU/NWz.ZQ59.CJ/7CT0GrtZQQOWQlE.cOOA54I4Kw.K',2),(45,'melnik.viktoria',' $2b$10$OS7GbjgavJqLwvyRHGf3Ye1kZbzHHQVjfo8TtnvNlsMB6KHNll0ZK',2),(46,'honcharuk.yulia',' $2b$10$f2JoQjXQI7kexVexW6iy3.BXaFVyW9O7dciE7Wec2vJq6kUoxg3je',2),(47,'timoshenko.artem',' $2b$10$VQICr0fjPN/y8bP6Q7lFOeCXrjKlf1gq6gI//5xg1H4AjLgk9Nx2O',2),(48,'lisenko.valentyna',' $2b$10$9Pp..6ktSfDcmVRXHEO6ieyhlINzBQXHABUc8/Qg75MQ/tAdQLs8O',2),(49,'sydorenko.igor',' $2b$10$Y1JS/B77MV3Fms59.a89MOOgyZEHoTQOTaXuq6WE9N6VZkN8Lzavu',2),(69,'mikhaylyuksergiy','d68c5e9d2245e5842d754e001527c34d80d60fd9c29aa9f1e339e964b7d4a6a8',2),(70,'kravchenkomariya','56e8d316a5d48a9ebea8fcf34e2a937e1760f90c75f51a68d972c6d3a95f7914',2),(71,'shevchenkoviktor','44f674c99f3cc0f81e0bf7fbf509dca0136c0a2b04237d13e083e89ff384c792',2),(72,'honcharolgaleonidivna','35668a7e0e34b7506c3f63a4778dc7450401c282c7f54e5762956868b99dd03b',2),(73,'lytvynenkoyuriystanislavovych','b58d105d8d19f8d5daae4b97d8aa8530449a2995d9f1d7786a63da6ac4508d3c',2),(74,'melnikannamikhaylivna','712b6dd6cf1e03e88c3ba2c947dd6010d8822e02832d6b8e6292b9e8b111c882',2),(75,'kozakvitaliyolegovych','13df86749866d747fae70c5c03389e69b5c91cc90e28817a8c7dc71b9cf08d63',2),(76,'petrenkomargaritaigorivna','6b2e2ac81e34df0a80c2ba665b3912312a5b5eb7c6d0c22ab2edf65651bb88a1',2),(77,'demchenkooleksandrivanovich','d17c2b4745ec4562fa1d98ac0cf3004dcbfb0a4cf346edec0457417f7e5a51bb',2),(78,'bondarantoniaoleksandrivna','4883f094f7f3fcbe27ecf95c2532f7464db0e59056d4a6d54631ee1077d3d940',2),(79,'lisenkoanatoliyyuriyovych','5683c4a9b93d1813fd145d4db94584e45c21a4e3e0a9a67b8e876b3b9d4d13a5',2),(80,'pavlenkoyuliaviktorivna','17b4f4dd32c2022ac5d4d2149a7bdcdb6d884dd9855f94a002b70d6d3e7480f8',2),(81,'kovalenkoartemvalentinovych','a2f4cd89b17280aef4ed68a6d1ba47c7e1018a3b1f077b05f69e3e16e4393c1d',2),(82,'timoshenkooksanaigorivna','90eaa55f4f33a6ed6293a1395cb84f7df19fb1538a582d57e540df02d5b55852',2),(83,'myronenkoandriyoleksandrovych','11a84d263bb1725f0f0f4b53f394c4f4f6ecdd6cc3b2cc4b28c1f8a37911abed',2),(84,'sidorenkotetianaleonidivna','2c6e0bcf351b0d32df147c03150990e8edf624d7f74ad1f91c43987e7d5e97f7',2),(85,'hrytsenkostanislavivanovych','9df6de8eb5a4a573c879db0620dcf4f8b485e5165d7a362612a61d5e7c0b5291',2),(86,'kovalenkoviktoriyanatoliyivna','63b49145df94db90d501777a6de21c7027aa9ee64a0e0d747445eb3d0b2f3059',2),(87,'hryhorenkovladimirigorovych','6bb956d414b94d4de0a6d8e2df22d04f23b0f2f30ecde127db09f53a44c0cda7',2),(88,'ivanovvitaliyolegovych','d6095cfc96e6775c3312d769b672f76237e7327f9df6c52e4c7f38e037cebf4e',2),(89,'lytvynvladyslavsergiyovych','4b93da9c1b79f8820b30b0f5246d760e688b9020f26e612438bc5ac70c454ccd',2),(90,'maksymenkoirinayuriyivna','2df5eaac4cf8a08d58db3f515fc4c8be254f9bbcd31cc273cd8c435b288d2cb1',2),(91,'melnikinnavitaliivna','69c59dd8a363e647740b7ba16065f8e7d94b95b0175f859f17ac632b80bbd1da',2),(92,'danilenkovalentinanatoliyovych','ab3ee9be2725d8f43c812647686d96a15ebf3692dab84e05667282d7a8b6309d',2),(93,'honcharukirinamikolayivna','9e8671fc4c23f32f3c89b6d5d8332a9c5b6db7f1a7596e4e8c658b97fd2c7b59',2),(94,'bondarchukoleksandrigorovich','8d891d2160c0fd74d18731fcfd1e437a5810b4768bb3c92c85ab4f2c67a7ec17',2),(95,'kravchenkoviktorvasilyovich','ec8e7a90f9a94ec0f0c3ff13611a4e8ae10234e6b6e27ec9e14d4487c5834f71',2),(96,'timoshenkoomarinaoleksiivna','8b169256e94717c3706e9c9cb07085e2bcf2c62f3f01c006e3a477c36c4c19d6',2),(97,'myronenkooleksandrivanovich','00c073f39c8a8d382c34e6e5acdd5e64bb0183d1786bc97e1aafeb916a5e72c9',2),(98,'sidorenkoantoninastanislavivna','9ea23ebf3cf5b95a2875687f7a4b2e855bbaf42f9a32b25e5278fbdf7b8396cc',2),(99,'kovalenkoviktormikolayovych','d7b3d44c0fc5a60586fe07c8ff1993a732585f25f0c08f787439cc3cb76879d0',2),(100,'kovalchukyuliaolegivna','fa7d53d9c8f879f3e37a7f47726a1f863282d4c303f8fb9c7f1b2026f8ba71f7',2),(101,'hrytsenkopalvoserhiyovych','ed079e101c17f9cb2fcce56b042c9461db9b5b160af6e2d7c173ecfca0d1f67e',2),(102,'kozlovaoksanaoleksiyivna','81349d07376c9e4d2cc4ac45a7c5aa4ba510cf4572a93e295202a9c4c8c90f21',2),(103,'petrenkostepanvitaliyovich','fc79d195a1baea8bc1016dfb899f89a95bea42b78db4a53a37c265d6b6ceef7d',2),(104,'demchenkoolgapetrivna','b82f2ac019d0a7ea5e6c07824841e23a442b5cf2a6f80bea76c7f63d2ce82b69',2),(105,'serhienkoirinaandriyivna','5f92662071e12e3d3cf06d123c5e90d239b1aa4e222beedfd993d0b3f2fb17d2',2),(106,'kuznetsovvladimirmikolayovych','6bbefdf405c868e9c10079f1a10cebb25fcd9c6905d08d8b4b74931b059086e0',2),(107,'martynenk onatali iig orivna','2cb13c3b6843228c8bb67bc8b3331c771ed7d4bc33bb7c25e92dcba88ed07ee8',2),(108,'tkachenkovitaliyolegovych','dc84a3b9e253d2e846b1ab1397d0b25ad7ff49e7553b5eaf374f9d164d82a271',2),(109,'bondarenkoliudmilasergh iivna','16f6b92377e21b545da91c9d0c8b8cdacac29f28670f21ea99259fc79fd24f82',2),(110,'kovalenkoihorvolodimirovych','4c2a4988835c70f507b61569248a91ec41bf8a32c1f4e3d573ed9b085f24d680',2),(111,'marchenkoma riyaoleksandrivna',' 29c2d978c8d78d7f28ee11e0431b58ae472d5c2790a4fd9fcb5cf00e6f303ca5',2),(112,'danilenkoartemvictorovych','b7c68227a63c3f28f05a2eeb3e6f14d070ef21f1e70bb1321d872d905251a5ee',2),(113,'savchenkotetianamikolayivna',' 849982e0213e10a71a4ce28c828774f084ee57ff0d1c9c0871809610321fc36b',2),(114,'lisenkosergiyvalentinovych','9c5fcb6b1096b913da6db5f75104b249e82b84852bb446ab2021685d28e2158c',2),(115,'pavlenkolarisaigorivna','f88619d8bf01230fb2ec99e181fdab52a0f0dc146c835d6e2a4f3ba442214f7f',2),(116,'kovalchukarturoleksandrovich','742d320dbedc378ee9ce36d93382e6d48ec916d85f68bc31b09b2671f4e08b2b',2),(117,'hrytsenkogalinaolegivna','73f77dcf63c30b6f2c01ef5d06d1e1b2d3f1db67b40d87d367c8288a45450886',2),(118,'kovalenkovadimandriyovych','705b9e3c124a40022b595ba2b3815f89cfb2c226ab1127da5068db6674c8f0b5',2),(135,'tetiana_','ae74e53a6f447e10150dd2e83ad3f0289606aec5354ae31fe87f3500b802dfd2',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-12 21:30:03
