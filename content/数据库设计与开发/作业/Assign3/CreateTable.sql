-- DROP ALL
DROP TABLE IF EXISTS "appointment" CASCADE;
DROP TABLE IF EXISTS "schedule" CASCADE;
DROP TABLE IF EXISTS "announcement" CASCADE;
DROP TABLE IF EXISTS "clinic_user" CASCADE;
DROP TABLE IF EXISTS "worker" CASCADE;
DROP TABLE IF EXISTS "admin" CASCADE;
DROP TABLE IF EXISTS "campus" CASCADE;

CREATE TABLE "campus" (
	"id" SERIAL NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL UNIQUE,
	"address" VARCHAR(255) NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "clinic_user" (
	"id" SERIAL NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"school_id" VARCHAR(32) UNIQUE NOT NULL,
	"phone_number" VARCHAR(32),
	"password_hash" CHAR(32) NOT NULL,
	PRIMARY KEY("id")
);
CREATE INDEX "clinic_user_index_0" ON "clinic_user" ("school_id");

CREATE TABLE "worker" (
	"id" SERIAL NOT NULL UNIQUE,
	"campus" INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY("id") REFERENCES "clinic_user"("id") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("campus") REFERENCES "campus"("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "worker_index_0" ON "worker" ("campus");

CREATE TABLE "admin" (
	"id" SERIAL NOT NULL UNIQUE,
	PRIMARY KEY("id"),
	FOREIGN KEY("id") REFERENCES "worker"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE "announcement" (
	"id" SERIAL NOT NULL UNIQUE,
	"title" VARCHAR(255) NOT NULL,
	"content" TEXT NOT NULL,
	"publish_time" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"expire_time" TIMESTAMP WITHOUT TIME ZONE,
	"priority" INTEGER NOT NULL DEFAULT 0,
	"last_editor" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("last_editor") REFERENCES "worker"("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE "schedule" (
	"id" SERIAL NOT NULL UNIQUE,
	"campus_id" INTEGER NOT NULL,
	"date" DATE NOT NULL,
	"start_time" TIME NOT NULL,
	"end_time" TIME NOT NULL,
	"capacity" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("campus_id") REFERENCES "campus"("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- 0 上单问题未解决
-- 1 预约待确认
-- 2 预约已确认
-- 3 预约已驳回
-- 4 登记待受理
-- 5 正在处理
-- 6 已解决问题
-- 7 建议返厂
-- 8 交给明天解决
-- 9 未到诊所

CREATE TABLE "appointment" (
	"id" SERIAL NOT NULL UNIQUE,
	"user_id" INTEGER NOT NULL,
	"worker_id" INTEGER,
	"description" VARCHAR(4096) NOT NULL,
	"worker_caption" VARCHAR(1024),
	"reject_reason" VARCHAR(1024),
	"computer_model" VARCHAR(255),
	"arrive_time" TIMESTAMP WITHOUT TIME ZONE,
	"schedule_id" INTEGER NOT NULL,
	"status" INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("id"),
	FOREIGN KEY("user_id") REFERENCES "clinic_user"("id") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("worker_id") REFERENCES "worker"("id") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("schedule_id") REFERENCES "schedule"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "appointment_index_0" ON "appointment" ("schedule_id");
CREATE INDEX "appointment_index_1" ON "appointment" ("status");