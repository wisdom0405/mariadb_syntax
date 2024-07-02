
CREATE TABLE `pro_pr_post` (
	`pr_post_id`	auto_increment	NOT NULL,
	`pr_pro_id`	VARCHAR(255)	NOT NULL,
	`pr_title`	VARCHAR(255)	NULL,
	`pr_contents`	VARCHAR(255)	NULL,
	`pr_github`	Not null	NULL
);

CREATE TABLE pro (
	`pro_id`	auto_increment	NOT NULL,
	`pro_name`	not null	NULL,
	`pro_nickname`	unique	NULL,
	`pro_email`	unique, not null	NULL,
	`pro_tel`	unique	NULL,
	`pro_career_exp`	VARCHAR(255)	NULL,
	`pro_region_id`	auto_increment	NULL,
	`pro_reside_YN`	VARCHAR(255)	NULL,
	`pro_pr_id`	VARCHAR(255)	NULL,
	`pro_cash`	default 0	NULL,
	`pro_score`	default 0	NULL,
	`region_id`	VARCHAR(255)	NOT NULL
);

CREATE TABLE `client` (
	`client_ID`	Auto_increment	NOT NULL,
	`client_name`	Not null	NULL,
	`client_Nick`	Unique	NULL,
	`client_email`	Unique	NULL,
	`client_pw`	Not null	NULL,
	`client_phone`	Unique	NULL,
	`client_score`	Default 0	NULL,
	`client_cash`	Default 0	NULL,
	`client_region_id`	VARCHAR(255)	NOT NULL
);

CREATE TABLE `Region` (
	`region_id`	auto_increment	NOT NULL,
	`region_name`	Not null	NULL
);

CREATE TABLE `pay_standby` (
	`stanby_id`	Auto_increment	NOT NULL,
	`stanby_order_id`	Not null	NOT NULL,
	`stand_by_client_id`	Not null	NOT NULL,
	`pay_standby_pro_id`	Not null	NOT NULL,
	`sending_price`	Not null	NULL,
	`holding_price`	Not null	NULL
);

CREATE TABLE `order` (
	`order_id`	Auto_increment	NOT NULL,
	`order_client_ID`	VARCHAR(255)	NOT NULL,
	`order_pro_id`	VARCHAR(255)	NOT NULL,
	`order_name`	Not null	NULL,
	`order_start_date`	VARCHAR(255)	NULL,
	`order_end_date`	VARCHAR(255)	NULL,
	`order_reside`	Y, N	NULL,
	`order_state`	Standby, Accept, Reject, Done Default Standby	NULL,
	`order_price`	Not null	NULL
);

CREATE TABLE `Stack_Category` (
	`category_id`	auto_increment	NOT NULL,
	`category_name`	not null	NULL	COMMENT '카테고리 5가지
개발언어 (language)
프레임워크 (framework)
라이브러리 (library)
데이터베이스 (DB)
운영체제 (OS)'
);

CREATE TABLE `stack` (
	`stack_id`	auto_increment	NOT NULL,
	`stack_ category_id`	Not null	NOT NULL,
	`stack_name`	unique, Not null	NULL,
	`stack_pro_id`	VARCHAR(255)	NOT NULL
);

CREATE TABLE `pro_service` (
	`sv_id`	Auto_increment	NOT NULL,
	`sv_pro_id`	Not null	NOT NULL,
	`sv_name`	unique	NULL,
	`sv_eep`	Not null	NULL,
	`sv_pro_score`	Not null	NULL,
	`sv_price`	Not null	NULL,
	`sv_contents`	Not null	NULL,
	`sv_reside_YN`	Y, N	NULL
);

CREATE TABLE `chat` (
	`id`	auto_increment	NOT NULL,
	`client_id`	VARCHAR(255)	NOT NULL,
	`pro_id`	VARCHAR(255)	NOT NULL,
	`send_time`	default current_timestamp	NULL,
	`contents`	Not null	NULL,
	`order_id`	VARCHAR(255)	NOT NULL
);

CREATE TABLE `review` (
	`review_id`	auto_increment	NOT NULL,
	`review_order_id`	VARCHAR(255)	NOT NULL,
	`review_client_id`	VARCHAR(255)	NOT NULL,
	`review_pro_id`	VARCHAR(255)	NOT NULL,
	`review_order_state`	VARCHAR(255)	NULL,
	`review_like_score`	VARCHAR(255)	NULL,
	`review_contents`	VARCHAR(255)	NULL,
	`review_created_time`	default current_timestamp	NULL
);

ALTER TABLE `pro_pr_post` ADD CONSTRAINT `PK_PRO_PR_POST` PRIMARY KEY (
	`pr_post_id`,
	`pr_pro_id`
);

ALTER TABLE `pro` ADD CONSTRAINT `PK_PRO` PRIMARY KEY (
	`pro_id`
);

ALTER TABLE `client` ADD CONSTRAINT `PK_CLIENT` PRIMARY KEY (
	`client_ID`
);

ALTER TABLE `Region` ADD CONSTRAINT `PK_REGION` PRIMARY KEY (
	`region_id`
);

ALTER TABLE `pay_standby` ADD CONSTRAINT `PK_PAY_STANDBY` PRIMARY KEY (
	`stanby_id`,
	`stanby_order_id`,
	`stand_by_client_id`,
	`pay_standby_pro_id`
);

ALTER TABLE `order` ADD CONSTRAINT `PK_ORDER` PRIMARY KEY (
	`order_id`,
	`order_client_ID`,
	`order_pro_id`
);

ALTER TABLE `Stack_Category` ADD CONSTRAINT `PK_STACK_CATEGORY` PRIMARY KEY (
	`category_id`
);

ALTER TABLE `stack` ADD CONSTRAINT `PK_STACK` PRIMARY KEY (
	`stack_id`,
	`stack_ category_id`
);

ALTER TABLE `pro_service` ADD CONSTRAINT `PK_PRO_SERVICE` PRIMARY KEY (
	`sv_id`,
	`sv_pro_id`
);

ALTER TABLE `chat` ADD CONSTRAINT `PK_CHAT` PRIMARY KEY (
	`id`,
	`client_id`,
	`pro_id`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`review_id`,
	`review_order_id`,
	`review_client_id`,
	`review_pro_id`
);

ALTER TABLE `pro_pr_post` ADD CONSTRAINT `FK_pro_TO_pro_pr_post_1` FOREIGN KEY (
	`pr_pro_id`
)
REFERENCES `pro` (
	`pro_id`
);

ALTER TABLE `pay_standby` ADD CONSTRAINT `FK_order_TO_pay_standby_1` FOREIGN KEY (
	`stanby_order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `pay_standby` ADD CONSTRAINT `FK_order_TO_pay_standby_2` FOREIGN KEY (
	`stand_by_client_id`
)
REFERENCES `order` (
	`order_client_ID`
);

ALTER TABLE `pay_standby` ADD CONSTRAINT `FK_order_TO_pay_standby_3` FOREIGN KEY (
	`pay_standby_pro_id`
)
REFERENCES `order` (
	`order_pro_id`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_client_TO_order_1` FOREIGN KEY (
	`order_client_ID`
)
REFERENCES `client` (
	`client_ID`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_pro_TO_order_1` FOREIGN KEY (
	`order_pro_id`
)
REFERENCES `pro` (
	`pro_id`
);

ALTER TABLE `stack` ADD CONSTRAINT `FK_Stack_Category_TO_stack_1` FOREIGN KEY (
	`stack_ category_id`
)
REFERENCES `Stack_Category` (
	`category_id`
);

ALTER TABLE `pro_service` ADD CONSTRAINT `FK_pro_TO_pro_service_1` FOREIGN KEY (
	`sv_pro_id`
)
REFERENCES `pro` (
	`pro_id`
);

ALTER TABLE `chat` ADD CONSTRAINT `FK_client_TO_chat_1` FOREIGN KEY (
	`client_id`
)
REFERENCES `client` (
	`client_ID`
);

ALTER TABLE `chat` ADD CONSTRAINT `FK_pro_TO_chat_1` FOREIGN KEY (
	`pro_id`
)
REFERENCES `pro` (
	`pro_id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_order_TO_review_1` FOREIGN KEY (
	`review_order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_order_TO_review_2` FOREIGN KEY (
	`review_client_id`
)
REFERENCES `order` (
	`order_client_ID`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_order_TO_review_3` FOREIGN KEY (
	`review_pro_id`
)
REFERENCES `order` (
	`order_pro_id`
);

