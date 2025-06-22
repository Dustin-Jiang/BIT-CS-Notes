-- 通用检查函数
CREATE OR REPLACE FUNCTION check_not_null(value anyelement, field_name text)
RETURNS void AS $$
BEGIN
  IF value IS NULL THEN
    RAISE EXCEPTION '%s 不能为空', field_name;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- 检查单字段唯一性
CREATE OR REPLACE FUNCTION check_unique_field(
  table_name text, 
  field_name text, 
  field_value text,
  OUT found boolean
) RETURNS void AS $$
BEGIN
  EXECUTE format('SELECT EXISTS(SELECT 1 FROM %I WHERE %I = $1)', table_name, field_name)
  INTO found
  USING field_value;
  
  IF found THEN
    RAISE EXCEPTION '%s 已存在', field_value;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- 检查外键引用
CREATE OR REPLACE FUNCTION check_foreign_key(
  parent_table text,
  parent_field text,
  field_value anyelement,
  error_message text
) RETURNS void AS $$
DECLARE
  query text;
  exists_check boolean;
BEGIN
  query := format('SELECT EXISTS(SELECT 1 FROM %I WHERE %I = $1)', parent_table, parent_field);
  EXECUTE query INTO exists_check USING field_value;
  
  IF field_value IS NOT NULL AND NOT exists_check THEN
    RAISE EXCEPTION '%s', error_message;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- xyb 表触发器函数
CREATE OR REPLACE FUNCTION xyb_pkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM check_not_null(NEW.ydh, 'ydh');
  PERFORM check_unique_field('xyb', 'ydh', NEW.ydh);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- xs 表触发器函数
CREATE OR REPLACE FUNCTION xs_pkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM check_not_null(NEW.xh, '学号');
  PERFORM check_unique_field('xs', 'xh', NEW.xh);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION xs_fkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM check_foreign_key('xyb', 'ydh', NEW.ydh, '所属学院代号（ydh）在 xyb 表中不存在');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- js 表触发器函数
CREATE OR REPLACE FUNCTION js_pkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM check_not_null(NEW.jsbh, 'jsbh');
  PERFORM check_unique_field('js', 'jsbh', NEW.jsbh);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- kc 表触发器函数
CREATE OR REPLACE FUNCTION kc_pkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM check_not_null(NEW.kcbh, 'kcbh');
  PERFORM check_unique_field('kc', 'kcbh', NEW.kcbh);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- sk 表触发器函数
CREATE OR REPLACE FUNCTION sk_pkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.kcbh IS NULL OR NEW.bh IS NULL THEN
    RAISE EXCEPTION 'kcbh 和 bh 不能为空';
  END IF;
  
  IF EXISTS(SELECT 1 FROM sk WHERE kcbh = NEW.kcbh AND bh = NEW.bh) THEN
    RAISE EXCEPTION 'kcbh 和 bh 的组合已存在';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sk_fkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM check_foreign_key('kc', 'kcbh', NEW.kcbh, '课程编号(kcbh)在 kc 表中不存在');
  PERFORM check_foreign_key('js', 'jsbh', NEW.bh, '教师编号(bh)在 js 表中不存在');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- xk 表触发器函数
CREATE OR REPLACE FUNCTION xk_pkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.xh IS NULL OR NEW.kcbh IS NULL OR NEW.jsbh IS NULL THEN
    RAISE EXCEPTION '学号、课程编号、教师编号均不能为 NULL';
  END IF;
  
  IF EXISTS(
    SELECT 1 FROM xk 
    WHERE xh = NEW.xh AND kcbh = NEW.kcbh AND jsbh = NEW.jsbh
  ) THEN
    RAISE EXCEPTION '选课记录已存在';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION xk_fkey_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS(
    SELECT 1 FROM sk 
    WHERE sk.kcbh = NEW.kcbh AND sk.bh = NEW.jsbh
  ) THEN
    RAISE EXCEPTION '(kcbh, jsbh) 组合在 sk 表中不存在';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 删除原有触发器
DROP TRIGGER IF EXISTS xyb_before_insert_pkey ON xyb;
DROP TRIGGER IF EXISTS xyb_before_update_pkey ON xyb;

DROP TRIGGER IF EXISTS xs_before_insert_pkey ON xs;
DROP TRIGGER IF EXISTS xs_before_update_pkey ON xs;
DROP TRIGGER IF EXISTS xs_before_insert_fkey ON xs;
DROP TRIGGER IF EXISTS xs_before_update_fkey ON xs;

DROP TRIGGER IF EXISTS js_before_insert_pkey ON js;
DROP TRIGGER IF EXISTS js_before_update_pkey ON js;
DROP TRIGGER IF EXISTS js_before_insert_fkey ON js;
DROP TRIGGER IF EXISTS js_before_update_fkey ON js;

DROP TRIGGER IF EXISTS kc_before_insert_pkey ON kc;
DROP TRIGGER IF EXISTS kc_before_update_pkey ON kc;

DROP TRIGGER IF EXISTS sk_before_insert_pkey ON sk;
DROP TRIGGER IF EXISTS sk_before_update_pkey ON sk;
DROP TRIGGER IF EXISTS sk_before_insert_fkey ON sk;
DROP TRIGGER IF EXISTS sk_before_update_fkey ON sk;

DROP TRIGGER IF EXISTS xk_before_insert_pkey ON xk;
DROP TRIGGER IF EXISTS xk_before_update_pkey ON xk;
DROP TRIGGER IF EXISTS xk_before_insert_fkey ON xk;
DROP TRIGGER IF EXISTS xk_before_update_fkey ON xk;

-- 创建触发器
CREATE TRIGGER xyb_before_insert_pkey BEFORE INSERT ON xyb
  FOR EACH ROW EXECUTE PROCEDURE xyb_pkey_trigger_func();
CREATE TRIGGER xyb_before_update_pkey BEFORE UPDATE ON xyb
  FOR EACH ROW EXECUTE PROCEDURE xyb_pkey_trigger_func();

CREATE TRIGGER xs_before_insert_pkey BEFORE INSERT ON xs
  FOR EACH ROW EXECUTE PROCEDURE xs_pkey_trigger_func();
CREATE TRIGGER xs_before_update_pkey BEFORE UPDATE ON xs
  FOR EACH ROW EXECUTE PROCEDURE xs_pkey_trigger_func();
CREATE TRIGGER xs_before_insert_fkey BEFORE INSERT ON xs
  FOR EACH ROW EXECUTE PROCEDURE xs_fkey_trigger_func();
CREATE TRIGGER xs_before_update_fkey BEFORE UPDATE ON xs
  FOR EACH ROW EXECUTE PROCEDURE xs_fkey_trigger_func();

CREATE TRIGGER js_before_insert_pkey BEFORE INSERT ON js
  FOR EACH ROW EXECUTE PROCEDURE js_pkey_trigger_func();
CREATE TRIGGER js_before_update_pkey BEFORE UPDATE ON js
  FOR EACH ROW EXECUTE PROCEDURE js_pkey_trigger_func();
CREATE TRIGGER js_before_insert_fkey BEFORE INSERT ON js
  FOR EACH ROW EXECUTE PROCEDURE xs_fkey_trigger_func();
CREATE TRIGGER js_before_update_fkey BEFORE UPDATE ON js
  FOR EACH ROW EXECUTE PROCEDURE xs_fkey_trigger_func();

CREATE TRIGGER kc_before_insert_pkey BEFORE INSERT ON kc
  FOR EACH ROW EXECUTE PROCEDURE kc_pkey_trigger_func();
CREATE TRIGGER kc_before_update_pkey BEFORE UPDATE ON kc
  FOR EACH ROW EXECUTE PROCEDURE kc_pkey_trigger_func();

CREATE TRIGGER sk_before_insert_pkey BEFORE INSERT ON sk
  FOR EACH ROW EXECUTE PROCEDURE sk_pkey_trigger_func();
CREATE TRIGGER sk_before_update_pkey BEFORE UPDATE ON sk
  FOR EACH ROW EXECUTE PROCEDURE sk_pkey_trigger_func();
CREATE TRIGGER sk_before_insert_fkey BEFORE INSERT ON sk
  FOR EACH ROW EXECUTE PROCEDURE sk_fkey_trigger_func();
CREATE TRIGGER sk_before_update_fkey BEFORE UPDATE ON sk
  FOR EACH ROW EXECUTE PROCEDURE sk_fkey_trigger_func();

CREATE TRIGGER xk_before_insert_pkey BEFORE INSERT ON xk
  FOR EACH ROW EXECUTE PROCEDURE xk_pkey_trigger_func();
CREATE TRIGGER xk_before_update_pkey BEFORE UPDATE ON xk
  FOR EACH ROW EXECUTE PROCEDURE xk_pkey_trigger_func();
CREATE TRIGGER xk_before_insert_fkey BEFORE INSERT ON xk
  FOR EACH ROW EXECUTE PROCEDURE xk_fkey_trigger_func();
CREATE TRIGGER xk_before_update_fkey BEFORE UPDATE ON xk
  FOR EACH ROW EXECUTE PROCEDURE xk_fkey_trigger_func();
