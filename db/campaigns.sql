CREATE TABLE IF NOT EXISTS campaigns (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  campaignKey TEXT NOT NULL,
  name TEXT NOT NULL,
  message TEXT,
  userLock TEXT NOT NULL,
  status TEXT NOT NULL,
  statusReason TEXT,
)