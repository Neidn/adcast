CREATE TABLE IF NOT EXISTS keyword_info (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  campaignKey TEXT NOT NULL,
  groupKey TEXT NOT NULL,
  totalData INTEGER NOT NULL,
  totalPage INTEGER NOT NULL,
  pageSize INTEGER NOT NULL,
  currentPage INTEGER NOT NULL,
)