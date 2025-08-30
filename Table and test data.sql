-- ==============================
-- CLEANUP OLD OBJECTS
-- ==============================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE event_logs'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE rail_units'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE gates'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- ==============================
-- TRAINS (renamed to rail_units)
-- ==============================
CREATE TABLE rail_units (
    unit_id      NUMBER PRIMARY KEY,
    unit_name    VARCHAR2(50),
    status       VARCHAR2(20),     -- APPROACHING / PASSED / IDLE
    gate_id      NUMBER            -- foreign key: nearest gate
);

-- ==============================
-- GATES
-- ==============================
CREATE TABLE gates (
    gate_id      NUMBER PRIMARY KEY,
    location     VARCHAR2(50),
    gate_status  VARCHAR2(20)      -- OPEN / CLOSED
);

-- ==============================
-- EVENT LOGS
-- ==============================
CREATE TABLE event_logs (
    log_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_id      NUMBER,
    gate_id      NUMBER,
    action       VARCHAR2(20),     -- OPEN / CLOSED
    event_time   TIMESTAMP DEFAULT SYSTIMESTAMP
);

-- ==============================
-- SAMPLE DATA
-- ==============================
INSERT INTO gates VALUES (1, 'Crossing_A', 'OPEN');
INSERT INTO gates VALUES (2, 'Crossing_B', 'OPEN');

INSERT INTO rail_units VALUES (101, '12120', 'IDLE', 1);
INSERT INTO rail_units VALUES (202, '12106',   'IDLE', 2);

COMMIT;

SELECT * FROM gates;
SELECT * FROM rail_units;
