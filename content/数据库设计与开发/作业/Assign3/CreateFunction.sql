-- 查找所有符合条件的预约记录
-- SELECT * FROM search_appointments(NULL, '良乡图书馆', '2025-04-01', '2025-12-31', NULL);
CREATE OR REPLACE FUNCTION search_appointments(
    p_status INTEGER DEFAULT NULL,
    p_campus_name VARCHAR DEFAULT NULL,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_user_school_id VARCHAR DEFAULT NULL
) 
RETURNS TABLE(
    id INTEGER,
    description VARCHAR,
    worker_caption VARCHAR,
    reject_reason VARCHAR,
    arrive_time TIMESTAMP,
    computer_model VARCHAR,
    status INTEGER,
    appointment_date DATE,
    campus VARCHAR,
    user_name VARCHAR,
    user_school_id VARCHAR,
    user_phone_number VARCHAR,
    worker_name VARCHAR,
    user_id INTEGER,
    worker_id INTEGER,
    schedule_id INTEGER
) AS $$
DECLARE
    v_sql TEXT;
    v_where_clause TEXT := ' WHERE 1=1';
    v_params_count INTEGER := 0;
BEGIN
    -- 构建基础查询
    v_sql := 'SELECT id, description, worker_caption, reject_reason, arrive_time, computer_model, 
              status, date AS appointment_date, campus, user_name, user_school_id, user_phone_number, 
              worker_name, user_id, worker_id, schedule_id 
              FROM appointment_view';
    
    IF p_status IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND status = ' || p_status;
        v_params_count := v_params_count + 1;
    END IF;
    
    IF p_campus_name IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND campus = ' || quote_literal(p_campus_name);
        v_params_count := v_params_count + 1;
    END IF;
      IF p_start_date IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND appointment_date >= ' || quote_literal(p_start_date);
        v_params_count := v_params_count + 1;
    END IF;
    
    IF p_end_date IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND appointment_date <= ' || quote_literal(p_end_date);
        v_params_count := v_params_count + 1;
    END IF;
    
    IF p_user_school_id IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND user_school_id = ' || quote_literal(p_user_school_id);
        v_params_count := v_params_count + 1;
    END IF;
    
    -- 如果有参数，添加WHERE子句
    IF v_params_count > 0 THEN
        v_sql := v_sql || v_where_clause;
    END IF;

    v_sql := v_sql || ' ORDER BY appointment_date DESC, status ASC';
    
    RETURN QUERY EXECUTE v_sql;
END;
$$ LANGUAGE plpgsql;
