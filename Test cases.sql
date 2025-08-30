-- CASE 1: Train 101 Approaches (Gate 1 closes, log entry added)
BEGIN
   UPDATE rail_units SET status = 'APPROACHING' WHERE unit_id = 101;
END;
/

-- CASE 2: Train 101 Passes (Gate 1 opens, log entry added)
BEGIN
   UPDATE rail_units SET status = 'PASSED' WHERE unit_id = 101;
END;
/

-- CASE 3: Train 202 Approaches (Gate 2 closes, log entry added)
BEGIN
   UPDATE rail_units SET status = 'APPROACHING' WHERE unit_id = 202;
END;
/

-- CASE 4: Train 202 Passes (Gate 2 opens, log entry added)
BEGIN
   UPDATE rail_units SET status = 'PASSED' WHERE unit_id = 202;
END;
/
