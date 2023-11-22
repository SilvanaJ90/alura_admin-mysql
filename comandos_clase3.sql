
-- crear la bd
CREATE SCHEMA IF NOT EXISTS ventas_jugos2 DEFAULT CHARSET utf32;


-- borrar la bd
DROP DATABASE ventas_jugos2;

-- usar la bd

USE ventas_jugos;

-- crear tabla 

CREATE TABLE tb_producto(
CODIGO VARCHAR(10) NOT NULL,
DESCRIPCION VARCHAR(100) NULL,
SABOR VARCHAR(50) NULL,
TAMANO VARCHAR(50) NULL,
ENVASE VARCHAR(50) NULL,
PRECIO_LISTA FLOAT NULL,
PRIMARY KEY (CODIGO)
);

CREATE TABLE tb_vendedor(
MATRICULA VARCHAR(5) NOT NULL,
NOMBRE VARCHAR(100) NULL,
BARRIO VARCHAR(50) NULL,
COMISION FLOAT NULL,
FECHA_ADMISION DATE NULL,
DE_VACACIONES BIT(1) NULL,
PRIMARY KEY(MATRICULA)
);

-- crear restricciones  FK

ALTER TABLE tb_venta ADD CONSTRAINT FK_CLIENTE
FOREIGN KEY (DNI) REFERENCES tb_cliente(DNI);

ALTER TABLE tb_venta ADD CONSTRAINT FK_VENDEDOR
FOREIGN KEY (MATRICULA) REFERENCES tb_vendedor(MATRICULA);

Renombrar las tablas

USE ventas_jugos;
ALTER TABLE tb_venta RENAME tb_factura;


-- insertar registros

-- un solo registro 

INSERT INTO tb_producto (CODIGO, DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO_LISTA) VALUES ('1040107', 'Light', 'Sandía', '350 ml', 'Lata', 4.56);

-- mas de un registro
INSERT INTO tb_producto VALUES 
    -> ('1040109', 'Light', 'Asaí', '350 ml', 'Lata', 5.60), 
    -> ('1040110', 'Light', 'Manzana', '350 ml', 'Lata', 6.00),
    -> ('1040111', 'Light', 'Mango', '350 ml', 'Lata', 3.50);


-- insertar varios registros usando una consulta

--consulta 
SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA  FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT
CODIGO FROM tb_producto);

INSERT INTO tb_producto SELECT CODIGO_DEL_PRODUCTO AS CODIGO, NOMBRE_DEL_PRODUCTO AS DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO_DE_LISTA AS PRECIO_LISTA  FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO NOT IN (SELECT CODIGO FROM tb_producto);

-- Alterar tablas

UPDATE tb_producto SET PRECIO_LISTA= 5 WHERE CODIGO = '1000889';

-- por lote

UPDATE tb_producto SET DESCRIPCION= 'Sabor de la Montaña',
TAMANO= '1 Litro', ENVASE = 'Botella PET' WHERE 
CODIGO = '1000889';

-- basado en el mismo campo
SELECT * FROM tb_cliente;
UPDATE tb_cliente SET VOLUMEN_COMPRA = VOLUMEN_COMPRA/10;

-- basado en los campos de otras tablas


UPDATE tb_vendedor A
INNER JOIN
tabla_de_vendedores B
ON A.MATRICULA = SUBSTRING(B.MATRICULA,3,3)
SET A.DE_VACACIONES = B.VACACIONES;

-- eliminar registros
DELETE FROM tb_producto WHERE TAMANO = '1 Litro';

-- eliminar registros utilizando seleccion de datos

DELETE FROM tb_producto
WHERE CODIGO NOT IN (SELECT CODIGO_DEL_PRODUCTO 
FROM tabla_de_productos);



Trigger

DELIMITER //
CREATE TRIGGER TG_FACTURACION_INSERT 
AFTER INSERT ON tb_items_facturas1
FOR EACH ROW BEGIN
  DELETE FROM tb_facturacion;
  INSERT INTO tb_facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM tb_factura1 A
  INNER JOIN
  tb_items_facturas1 B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //



DELIMITER //
CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON tb_items_facturas1
FOR EACH ROW BEGIN
  DELETE FROM tb_facturacion;
  INSERT INTO tb_facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM tb_factura1 A
  INNER JOIN
  tb_items_facturas1 B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON tb_items_facturas1
FOR EACH ROW BEGIN
  DELETE FROM tb_facturacion;
  INSERT INTO tb_facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM tb_factura1 A
  INNER JOIN
  tb_items_facturas1 B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //




