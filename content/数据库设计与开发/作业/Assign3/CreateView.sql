DROP VIEW IF EXISTS "appointment_view";
DROP VIEW IF EXISTS "worker_view";
DROP VIEW IF EXISTS "schedule_view";
DROP VIEW IF EXISTS "announcement_view";

CREATE VIEW "worker_view" AS
SELECT "clinic_user"."id" AS "id",
  "clinic_user"."name" AS "name",
  "clinic_user"."school_id" AS "school_id",
  "clinic_user"."phone_number" AS "phone_number",
  "campus"."name" AS "campus"
FROM "clinic_user"
  JOIN "worker" ON "clinic_user"."id" = "worker"."id"
  LEFT JOIN "campus" ON "worker"."campus" = "campus"."id";

CREATE VIEW "appointment_view" AS
SELECT "appointment"."id" AS "id",
  "appointment"."description" AS "description",
  "appointment"."worker_caption" AS "worker_caption",
  "appointment"."reject_reason" AS "reject_reason",
  "appointment"."arrive_time" AS "arrive_time",
  "appointment"."computer_model" AS "computer_model",
  "appointment"."status" AS "status",
  "schedule"."date" AS "date",
  "campus"."name" AS "campus",
  "clinic_user"."name" AS "user_name",
  "clinic_user"."school_id" AS "user_school_id",
  "clinic_user"."phone_number" AS "user_phone_number",
  "worker_view"."name" AS "worker_name",
  "appointment"."user_id" AS "user_id",
  "appointment"."worker_id" AS "worker_id",
  "appointment"."schedule_id" AS "schedule_id"
FROM "appointment"
  LEFT JOIN "clinic_user" ON "appointment"."user_id" = "clinic_user"."id"
  LEFT JOIN "worker_view" ON "appointment"."worker_id" = "worker_view"."id"
  LEFT JOIN "schedule" ON "appointment"."schedule_id" = "schedule"."id"
  LEFT JOIN "campus" ON "schedule"."campus_id" = "campus"."id";

CREATE VIEW "schedule_view" AS
SELECT "schedule"."id" AS "id",
  "schedule"."date" AS "date",
  "schedule"."start_time" AS "start_time",
  "schedule"."end_time" AS "end_time",
  "campus"."name" AS "campus",
  "campus"."address" AS "address",
  "campus"."id" AS "campus_id",
  "schedule"."capacity" AS "capacity",
  (SELECT COUNT(*) FROM "appointment" WHERE "appointment"."schedule_id" = "schedule"."id") AS "appointed"
FROM "schedule"
  LEFT JOIN "campus" ON "schedule"."campus_id" = "campus"."id";

CREATE VIEW "announcement_view" AS
SELECT "announcement"."id" AS "id",
  "announcement"."title" AS "title",
  "announcement"."content" AS "content",
  "announcement"."publish_time" AS "publish_time",
  "announcement"."expire_time" AS "expire_time",
  "announcement"."priority" AS "priority",
  "clinic_user"."name" AS "editor_name"
FROM "announcement"
  LEFT JOIN "clinic_user" ON "announcement"."last_editor" = "clinic_user"."id"
ORDER BY "announcement"."priority";


CREATE OR REPLACE RULE appointment_view_update AS ON UPDATE TO appointment_view DO INSTEAD
  UPDATE appointment SET
    description = NEW.description,
    computer_model = NEW.computer_model,
    schedule_id = NEW.schedule_id, 
    worker_caption = NEW.worker_caption,
    reject_reason = NEW.reject_reason,
    status = NEW.status,
    worker_id = NEW.worker_id,
    arrive_time = CASE 
      WHEN NEW.status >= 5 AND OLD.arrive_time IS NULL THEN LOCALTIMESTAMP
      ELSE OLD.arrive_time
    END
  WHERE id = NEW.id;