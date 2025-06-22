-- 删除过期的公告
CREATE OR REPLACE PROCEDURE delete_expired_announcements() AS
BEGIN
  DELETE FROM announcements
    WHERE expire_time IS NOT NULL
    AND expire_time < CURRENT_TIMESTAMP;
END;