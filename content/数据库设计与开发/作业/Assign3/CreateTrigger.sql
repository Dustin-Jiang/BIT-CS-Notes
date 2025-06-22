CREATE OR REPLACE FUNCTION schedule_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.start_time >= NEW.end_time THEN
    RAISE EXCEPTION 'start_time must be less than end_time';
  END IF;

  IF NEW.capacity <= 0 THEN
    RAISE EXCEPTION 'capacity must be greater than 0';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS schedule_before_insert ON schedule;
DROP TRIGGER IF EXISTS schedule_before_update ON schedule;

CREATE TRIGGER schedule_before_insert BEFORE INSERT ON schedule
  FOR EACH ROW EXECUTE PROCEDURE schedule_trigger_func();

CREATE TRIGGER schedule_before_update BEFORE INSERT ON schedule
  FOR EACH ROW EXECUTE PROCEDURE schedule_trigger_func();