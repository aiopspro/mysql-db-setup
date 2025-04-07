# 🐬 Custom MySQL 8.0 Docker Image with Init Script, Custom Config & Log Rotation

This repository provides a production-ready **MySQL 8.0.15** Docker image with the following built-in features:

- ✅ Custom MySQL configuration
- ✅ Log rotation setup
- ✅ Database auto-initialization script
- ✅ Proper volume & log permission setup

---

## 📁 Files Included

| File                  | Purpose                                                     |
|-----------------------|-------------------------------------------------------------|
| `Dockerfile`          | Builds the customized MySQL image                           |
| `00_init.sql`         | Initializes database and user privileges                    |
| `default.cnf`         | Custom MySQL server configuration                           |
| `logrotate-mysql`     | Logrotate configuration for MySQL logs                      |
| `README.md`           | You're reading it 😊                                        |

---

## 🧱 Docker Image Overview

**Base Image:** [`mysql:8.0.15`](https://hub.docker.com/_/mysql)  
**Exposed Port:** `3306`  
**MySQL Root Password (for dev/testing):** `testing` *(you should override in production)*

---

## 🔧 What This Image Does

1. **Overrides default MySQL config** with `default.cnf`
2. **Sets up log rotation** for:
   - `/var/log/mysql/error.log`
   - `/var/log/mysql/general.log`
   - `/var/log/mysql/slow.log`
3. **Auto-initializes** a database and user privileges via `00_init.sql`
4. **Fixes permissions** for `/var/run/mysqld` and `/var/log/mysql`

---

## 📝 SQL Init Script Highlights

```sql
CREATE DATABASE IF NOT EXISTS testing;

USE testing;

GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE ON testing.* TO 'testdbuser'@'%';

FLUSH PRIVILEGES;

---

## 🚀 Usage

### 1. Build the Docker Image

```bash
docker build -t custom-mysql:8.0 .

### 2. Run the Container

```bash
docker run -d \
  --name mysql-custom \
  -e MYSQL_ROOT_PASSWORD=your_strong_password \
  -p 3306:3306 \
  custom-mysql:8.0

> ⚠️ Important Customization Note
Please review and modify the following files before production use:

Dockerfile

00_init.sql

default.cnf

You may want to update:

🛠️ Database names, users, and privileges

🔐 Root password (never use defaults in production)

🔁 Cron or logrotate frequency

🔧 MySQL server settings like buffer sizes, connection limits

⚙️ File paths and volume mappings depending on your host system

🔧 MySQL server settings like buffer sizes, connection limits

⚙️ File paths and volume mappings depending on your host system
