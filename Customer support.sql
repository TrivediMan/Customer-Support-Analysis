
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS teams;

CREATE TABLE teams (
    team_id    INT    NOT NULL,
    team       TEXT    NOT NULL,
    department TEXT    NOT NULL,
);
Create table tickets(
    ticket_id        INT     NOT NULL,
    month            TEXT        NOT NULL,   
    team_id          INT        NOT NULL,
    channel          TEXT        NOT NULL,
    resolution_hours INT        NOT NULL,
    satisfaction     INT        NOT NULL,
);

INSERT INTO teams (team_id, team, department) VALUES
    ('T1', 'AccountCare', 'Service'),
    ('T2', 'BillingHelp', 'Service'),
    ('T3', 'AppSupport',  'Technical'),
    ('T4', 'DeviceHelp',  'Technical');

INSERT INTO tickets (ticket_id, month, team_id, channel, resolution_hours, satisfaction) VALUES
    (1,  'Jan', 'T1', 'Email', 12, 4),
    (2,  'Jan', 'T2', 'Chat',  28, 3),
    (3,  'Jan', 'T3', 'Phone', 36, 2),
    (4,  'Jan', 'T4', 'Email', 20, 4),
    (5,  'Feb', 'T1', 'Chat',   8, 5),
    (6,  'Feb', 'T2', 'Phone', 30, 3),
    (7,  'Feb', 'T3', 'Email', 18, 4),
    (8,  'Feb', 'T4', 'Chat',  40, 2),
    (9,  'Mar', 'T1', 'Phone', 16, 4),
    (10, 'Mar', 'T2', 'Email', 22, 4),
    (11, 'Mar', 'T3', 'Chat',  32, 3),
    (12, 'Mar', 'T4', 'Phone', 24, 5);

SELECT * From teams

SELECT * From tickets

SELECT
    tm.department,
    ROUND(AVG(tk.resolution_hours), 2) AS avg_resolution_hours
FROM tickets tk
JOIN teams tm ON tk.team_id = tm.team_id
GROUP BY tm.department
ORDER BY avg_resolution_hours DESC;

SELECT
    tk.team_id,
    tm.team,
    tm.department,
    ROUND(AVG(tk.resolution_hours), 2) AS avg_resolution_hours
FROM tickets tk
JOIN teams tm ON tk.team_id = tm.team_id
GROUP BY tk.team_id, tm.team, tm.department
HAVING AVG(tk.resolution_hours) > 24
ORDER BY avg_resolution_hours DESC;

SELECT
    channel,
    COUNT(*) AS breach_count
FROM tickets
WHERE resolution_hours > 24
GROUP BY channel
ORDER BY breach_count DESC, channel ASC
LIMIT 2;


