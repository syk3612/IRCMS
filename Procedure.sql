CREATE OR REPLACE PROCEDURE manage_crossing(p_unit_id NUMBER, p_status VARCHAR2) IS
  v_gate_id NUMBER;
BEGIN
  -- Update train status & fetch gate
  UPDATE rail_units
  SET status = p_status
  WHERE unit_id = p_unit_id
  RETURNING gate_id INTO v_gate_id;

  -- Apply gate logic
  IF p_status = 'APPROACHING' THEN
     UPDATE gates SET gate_status = 'CLOSED' WHERE gate_id = v_gate_id;
     INSERT INTO event_logs(unit_id, gate_id, action) VALUES (p_unit_id, v_gate_id, 'CLOSED');
     DBMS_OUTPUT.PUT_LINE('🚂 Train ' || p_unit_id || ' APPROACHING → Gate ' || v_gate_id || ' CLOSED ❌');

  ELSIF p_status = 'PASSED' THEN
     UPDATE gates SET gate_status = 'OPEN' WHERE gate_id = v_gate_id;
     INSERT INTO event_logs(unit_id, gate_id, action) VALUES (p_unit_id, v_gate_id, 'OPEN');
     DBMS_OUTPUT.PUT_LINE('✅ Train ' || p_unit_id || ' PASSED → Gate ' || v_gate_id || ' OPEN ✔️');

  ELSE
     DBMS_OUTPUT.PUT_LINE('ℹ️ Train ' || p_unit_id || ' is IDLE → No action.');
  END IF;

  COMMIT;
END;
/
