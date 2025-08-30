-- Current status of trains
SELECT * FROM rail_units;

-- Current status of gates
SELECT * FROM gates;

-- Event log (history of actions)
SELECT * FROM event_logs ORDER BY event_time;
