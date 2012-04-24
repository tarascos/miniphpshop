SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(50) NOT NULL ,
  `lastname` VARCHAR(50) NOT NULL ,
  `email` VARCHAR(100) NOT NULL ,
  `password` VARCHAR(50) NOT NULL ,
  `is_admin` TINYINT(2) UNSIGNED NULL DEFAULT 0 ,
  `updated_at` DATETIME NULL ,
  `created_at` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customers`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customers` (
  `user_id` INT UNSIGNED NOT NULL ,
  `country` VARCHAR(2) NULL ,
  `city` VARCHAR(100) NULL ,
  `address` VARCHAR(300) NULL ,
  `phone` VARCHAR(50) NULL ,
  `birthdate` DATETIME NULL DEFAULT NULL ,
  INDEX `user_id_index` (`user_id` ASC) ,
  INDEX `fk_customers_2_users` (`user_id` ASC) ,
  CONSTRAINT `fk_customers_2_users`
    FOREIGN KEY (`user_id` )
    REFERENCES `users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categories`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `parent_id` INT UNSIGNED NULL ,
  `title` VARCHAR(100) NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `products` (
  `id` INT NOT NULL ,
  `title` VARCHAR(45) NULL ,
  `description` TEXT NULL ,
  `image` VARCHAR(45) NULL ,
  `price` FLOAT NULL ,
  `quantity` SMALLINT NULL DEFAULT 0 ,
  `in_stock` TINYINT UNSIGNED NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `products_to_categories`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `products_to_categories` (
  `category_id` INT UNSIGNED NOT NULL ,
  `product_id` INT UNSIGNED NOT NULL ,
  INDEX `category_id_index` (`category_id` ASC) ,
  INDEX `product_id_index` (`product_id` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_cart`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `customer_cart` (
  `id` INT NOT NULL ,
  `customer_id` INT UNSIGNED NULL ,
  `product_id` INT UNSIGNED NULL ,
  `quantity` SMALLINT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `customer_id_index` (`customer_id` ASC) ,
  INDEX `product_id_index` (`product_id` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orders`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `orders` (
  `id` INT NOT NULL ,
  `customer_id` VARCHAR(45) NULL ,
  `status` ENUM('NEW', 'COMPLETE','DECLINE') NULL DEFAULT 'NEW',
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `customer_id_index` (`customer_id` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `order_products`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `order_products` (
  `order_id` INT UNSIGNED NOT NULL ,
  `product_id` INT UNSIGNED NULL ,
  `quantity` SMALLINT UNSIGNED NULL ,
  INDEX `order_id_index` (`order_id` ASC) ,
  INDEX `product_id_index` (`product_id` ASC)
) ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
