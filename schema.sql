-- Hàm api.mjs tự chạy đoạn này khi khởi động; file này để bạn tham khảo / chạy tay nếu muốn.
CREATE TABLE IF NOT EXISTS bookings (
  id         BIGSERIAL PRIMARY KEY,          -- số thứ tự (STT)
  code       TEXT UNIQUE NOT NULL,           -- mã đơn, vd HCB123456
  lang       TEXT NOT NULL DEFAULT 'vi',     -- vi | zh
  currency   TEXT NOT NULL,                  -- VND | CNY
  room       TEXT NOT NULL,
  check_in   TEXT, check_out TEXT,
  nights     INT, guests TEXT,
  policy     TEXT, method TEXT,
  services   TEXT, coupon TEXT, discount NUMERIC(14,2) DEFAULT 0,
  total      NUMERIC(14,2), due NUMERIC(14,2),
  pii        TEXT NOT NULL,                  -- tên, SĐT, hóa đơn: MÃ HÓA AES-256-GCM
  status     TEXT NOT NULL DEFAULT 'Pending'
             CHECK (status IN ('Pending','Confirmed','CheckedIn','Completed','Cancelled')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS bookings_status_idx ON bookings(status, id DESC);
CREATE TABLE IF NOT EXISTS rate_log (k TEXT NOT NULL, t TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE INDEX IF NOT EXISTS rate_log_idx ON rate_log(k, t);
