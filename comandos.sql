/* 
Bienvenido al curso de Administración de MySQL: Seguridad y optimización de la base de datos. 

Te invito a preparar el ambiente para iniciar con nuestro entrenamiento. ¡Éxitos!
*/


/* PROYECTO DEL AULA ANTERIOR 1 

Llegó del momento de practicar los comandos que aprenderás durante el desarrollo de esta clase. 

Recuerda que nuestro foro está a disposición en caso de que tengas inquietudes. */


/* PROYECTO DEL AULA ANTERIOR 2 

Conexiones de MySQL y Servicios de Windows.

Recuerda que nuestro foro está a disposición en caso de que tengas inquietudes. */


/* PROYECTO DEL AULA ANTERIOR 3 */

SHOW GLOBAL STATUS LIKE 'Created_tmp_disk_tables';

SHOW GLOBAL STATUS LIKE 'Created_tmp_tables';

SHOW GLOBAL VARIABLES LIKE 'tmp_table_size';

SET GLOBAL tmp_table_size = 136700160;

mysql> SHOW GLOBAL STATUS LIKE 'Created_tmp_disk_tables';
+-------------------------+-------+
| Variable_name           | Value |
+-------------------------+-------+
| Created_tmp_disk_tables | 3     |
+-------------------------+-------+
1 row in set (0.00 sec)

mysql> SHOW GLOBAL STATUS LIKE 'Created_tmp_tables';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| Created_tmp_tables | 1291  |
+--------------------+-------+
1 row in set (0.00 sec)

mysql> SHOW GLOBAL VARIABLES LIKE 'tmp_table_size';
+----------------+----------+
| Variable_name  | Value    |
+----------------+----------+
| tmp_table_size | 16777216 |
+----------------+----------+
1 row in set (0.01 sec)

mysql> 


/* PROYECTO DEL AULA ANTERIOR 4 */

CREATE TABLE df_table (ID INT, NOMBRE VARCHAR(100));

ALTER TABLE df_table ENGINE = MyISAM;

CREATE TABLE df_table1 (ID INT, NOMBRE VARCHAR(100)) ENGINE = MEMORY;

SHOW ENGINES;

CREATE DATABASE base;

SHOW VARIABLES WHERE Variable_Name LIKE '%dir';

CREATE DATABASE base3;

DROP DATABASE base;

Son los tipos de almacenamiento

mysql> SHOW ENGINES;
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| ndbcluster         | NO      | Clustered, fault-tolerant tables                               | NULL         | NULL | NULL       |
| CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
| ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
| BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
| ndbinfo            | NO      | MySQL Cluster system information storage engine                | NULL         | NULL | NULL       |
| MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
| FEDERATED          | NO      | Federated MySQL storage engine                                 | NULL         | NULL | NULL       |
| MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
| PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
| InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
| MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
11 rows in set (0.01 sec)

mysql> 


mysql> CREATE TABLE df_table (id INT, nombre VARCHAR(100));
Query OK, 0 rows affected (0.02 sec)

mysql> SHOW TABLE STATUS LIKE 'df_table';
+----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
| Name     | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time | Check_time | Collation          | Checksum | Create_options | Comment |
+----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
| df_table | InnoDB |      10 | Dynamic    |    0 |              0 |       16384 |               0 |            0 |         0 |           NULL | 2023-10-25 15:04:31 | NULL        | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.01 sec)

Crea la tabla por defecto con almacenamieto InnoDB
Para cambiar este timpo de almacenamiento 

mysql> ALTER TABLE df_table ENGINE = MyISAM;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SHOW TABLE STATUS LIKE 'df_table';
+----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
| Name     | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time | Check_time | Collation          | Checksum | Create_options | Comment |
+----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
| df_table | MyISAM |      10 | Dynamic    |    0 |              0 |       16384 |               0 |            0 |         0 |           NULL | 2023-10-25 15:30:00 | NULL        | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.00 sec)

Tambien puedo especificar al crear la tabla que tipo de almacenamiento quiero que tenga

mysql> CREATE TABLE  df_table2 (id INT, nombre VARCHAR(100))ENGINE = MEMORY;
Query OK, 0 rows affected (0.02 sec)

mysql> SHOW TABLE STATUS LIKE 'df_table2';
+-----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
| Name      | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time | Check_time | Collation          | Checksum | Create_options | Comment |
+-----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
| df_table2 | MEMORY |      10 | Fixed      |    0 |            407 |           0 |        16735840 |            0 |         0 |              1 | 2023-10-25 15:33:30 | NULL        | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+-----------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.00 sec)




mysql> SHOW VARIABLES WHERE variable_name LIKE '%dir';
+-----------------------------+-------------------------------------------------------+
| Variable_name               | Value                                                 |
+-----------------------------+-------------------------------------------------------+
| basedir                     | /usr/local/mysql-8.0.34-macos13-arm64/                |
| character_sets_dir          | /usr/local/mysql-8.0.34-macos13-arm64/share/charsets/ |
| datadir                     | /usr/local/mysql/data/                                |
| innodb_data_home_dir        |                                                       |
| innodb_doublewrite_dir      |                                                       |
| innodb_log_group_home_dir   | ./                                                    |
| innodb_temp_tablespaces_dir | ./#innodb_temp/                                       |
| innodb_tmpdir               |                                                       |
| lc_messages_dir             | /usr/local/mysql-8.0.34-macos13-arm64/share/          |
| plugin_dir                  | /usr/local/mysql/lib/plugin/                          |
| replica_load_tmpdir         | /var/tmp/                                             |
| slave_load_tmpdir           | /var/tmp/                                             |
| tmpdir                      | /var/tmp/                                             |
+-----------------------------+-------------------------------------------------------+
13 rows in set (0.01 sec)

 El datadir      es donde se encuentra almacenado mi base de datos, en caso que yo quiera cambiar este disco puedo indicarle una nueva ruta



/* PROYECTO FINAL */

Backup logico 

mysqldump -u root -p --databases sakila > Documents/alura-cursos/sakila.sql 
Enter password: 
cd Documents/alura-cursos 
ls
sakila.sql

Backup Fisico
LOCK INSTANCE FOR BACKUP;

UNLOCK INSTANCE;


se detiene la instalcia y se copia la carpeta donde se aloja la base de datos y se lleva a la ruta donde se estan almacenando los backups, 
tambien se copia el archivo my.init

Recuperar la base de datos


mysql> DROP DATABASE sakila;
Query OK, 7 rows affected (0.12 sec)

mysql> CREATE DATABASE IF NOT EXISTS sakila;
Query OK, 1 row affected (0.01 sec)


mysql -u root -p < Documents/alura-cursos/alura_admin-mysql/sakila.sql 
Enter password: 
mysql -u root -p                                                      

mysql> use sakila;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+---------------------+
| Tables_in_sakila    |
+---------------------+
| df_table            |
| df_table2           |
| facturas            |
| items_facturas      |
| tabla_de_clientes   |
| tabla_de_productos  |
| tabla_de_vendedores |
+---------------------+
7 rows in set (0.00 sec)

mysql> select * from facturas limit 2;
+-------------+-----------+-------------+--------+----------+
| DNI         | MATRICULA | FECHA_VENTA | NUMERO | IMPUESTO |
+-------------+-----------+-------------+--------+----------+
| 7771579779  | 00235     | 2015-01-01  |    100 |      0.1 |
| 50534475787 | 00237     | 2015-01-01  |    101 |     0.12 |
+-------------+-----------+-------------+--------+----------+
2 rows in set (0.00 sec)



