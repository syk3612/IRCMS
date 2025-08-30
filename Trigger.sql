CREATE OR REPLACE TRIGGER trg_manage_crossing
AFTER UPDATE OF status ON rail_units
FOR EACH ROW
BEGIN
   IF :NEW.status = 'APPROACHING' THEN
      UPDATE gates
      SET gate_status = 'CLOSED'
      WHERE gate_id = :NEW.gate_id;

      INSERT INTO event_logs(unit_id, gate_id, action)
      VALUES (:NEW.unit_id, :NEW.gate_id, 'CLOSED');

      DBMS_OUTPUT.PUT_LINE('🚂 Train ' || :NEW.unit_id || ' APPROACHING → Gate ' || :NEW.gate_id || ' CLOSED ❌');

   ELSIF :NEW.status = 'PASSED' THEN
      UPDATE gates
      SET gate_status = 'OPEN'
      WHERE gate_id = :NEW.gate_id;

      INSERT INTO event_logs(unit_id, gate_id, action)
      VALUES (:NEW.unit_id, :NEW.gate_id, 'OPEN');

      DBMS_OUTPUT.PUT_LINE('✅ Train ' || :NEW.unit_id || ' PASSED → Gate ' || :NEW.gate_id || ' OPEN ✔️');
   END IF;
END;
/
