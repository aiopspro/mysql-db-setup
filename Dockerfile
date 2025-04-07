FROM mysql:8.0.15

# Set MySQL root password (ensure it initializes correctly)
ENV MYSQL_ROOT_PASSWORD=testing

# ✅ Copy custom MySQL configuration
COPY --chown=mysql:mysql /docker/config/etc/mysql/next/conf.d/default.cnf /etc/mysql/conf.d/custom.cnf

# ✅ Copy MySQL Log rotation configuration
COPY --chown=mysql:mysql /docker/config/etc/mysql/next/conf.d/logrotate-mysql /etc/logrotate.d/mysql

# ✅ Copy database initialization scripts (to create db or create users, Anything related to MySQL)
COPY --chown=mysql:mysql /docker/config/etc/mysql/sql/ /docker-entrypoint-initdb.d/

# ✅ Switch to root to fix permissions
USER root

# ✅ Ensure log directory exists & permissions are correct
RUN mkdir -p /var/log/mysql /var/run/mysqld && \
    touch /var/log/mysql/error.log /var/run/mysqld/mysqld.pid && \
    chown -R mysql:mysql /var/log/mysql /var/run/mysqld && \
    chmod -R 770 /var/log/mysql /var/run/mysqld

# ✅ Switch back to MySQL user
USER mysql

# ✅ Expose MySQL Port
EXPOSE 3306

# ✅ Ensure correct entrypoint (use MySQL's built-in one)
CMD ["mysqld", "--defaults-extra-file=/etc/mysql/conf.d/custom.cnf"]
