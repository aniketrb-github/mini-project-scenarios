-- DROP DATABASE `project_portal_mgt_db`
-- CREATE SCHEMA `project_portal_mgt_db` ;

-- TABLE: PROJECTS
CREATE TABLE tbl_projects (
`id` INT(8) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL,
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`)
);

-- TABLE: EMPLOYEES 
CREATE TABLE tbl_employees(
`id` INT(8) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL,
`designation` VARCHAR(128) NOT NULL,
`platform` VARCHAR(64) NULL,
`image` VARCHAR(128) NULL,
`project_id` INT(8) NOT NULL,-- foreign key
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`),
KEY `tbl_projects_fk1` (`project_id`),
CONSTRAINT `tbl_projects_fk1` FOREIGN KEY (`project_id`) REFERENCES `tbl_projects` (`id`)
);	

-- TABLE: TASKS
CREATE TABLE tbl_tasks(
`id` INT(8) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL,
`start_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`end_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`project_id` INT(8) NOT NULL,-- foreign key
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`),
KEY `tbl_projects_fk1` (`project_id`),
CONSTRAINT `tbl_projects_fk1` FOREIGN KEY (`project_id`) REFERENCES `tbl_projects` (`id`),
KEY `tbl_employees_fk1` (`employee_id`),
CONSTRAINT `tbl_employees_fk1` FOREIGN KEY (`employee_id`) REFERENCES `tbl_employees` (`id`)
);

-- TABLE: BUG STATUSES
CREATE TABLE tbl_bug_status(
`id` INT(2) NOT NULL,
`name` VARCHAR(32) NOT NULL,
`start_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`end_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`)
);

-- TABLE: BUG
CREATE TABLE tbl_bugs(
`id` INT(2) NOT NULL,
`name` VARCHAR(32) NOT NULL,
`description` VARCHAR(128) NOT NULL,
`task_id` INT(8) NOT NULL,		-- foreign key
`bug_status_id` INT(2) NOT NULL, -- foreign key
`employee_id` INT(8) NOT NULL,  -- foreign key
`deleted` TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY(`id`),
KEY `tbl_tasks_fk1` (`task_id`),
CONSTRAINT `tbl_tasks_fk1` FOREIGN KEY (`task_id`) REFERENCES `tbl_tasks` (`id`),
KEY `tbl_bug_status_fk1` (`bug_status_id`),
CONSTRAINT `tbl_bug_status_fk1` FOREIGN KEY (`bug_status_id`) REFERENCES `tbl_bug_status` (`id`)
);


ALTER TABLE tbl_bugs 
DROP FOREIGN KEY tbl_employees_fk1;

ALTER TABLE tbl_tasks
ADD COLUMN `employee_id` INT(8) NOT NULL,
ADD FOREIGN KEY `tbl_employees_fk1`(`employee_id`)
REFERENCES `tbl_employees`(`id`);
