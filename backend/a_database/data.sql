ple-- Insertar registros en la tabla roles
INSERT INTO relaciones.roles (nombre) VALUES
  ('administrador'),
  ('empleado'),
  ('gerente'),
  ('cliente'),
  ('conductor');
  
  
 -- Insertar registros en la tabla usuario
INSERT INTO personal.usuario (rol_id,nickname, contrasena, email) VALUES
  (1,'jorgito', 'contrasena1', 'usuario1@example.com'),
  (2,'pepito', 'contrasena2', 'usuario2@example.com'),
  (3,'ñoño', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (5,'lucas', 'contrasena3', 'usuario3@example.com'),
  (5,'lucas', 'contrasena3', 'usuario3@example.com'),
  (5,'lucas', 'contrasena3', 'usuario3@example.com');
  
  
  -- Insertar registros en la tabla superadmin
INSERT INTO personal.gerente (usuario_id, nombres, apellidos, dni, fecha_nacimiento) VALUES
  (3, 'monchito', 'Apellido1', '12345678', '1990-01-01');
  
 
 -- Insertar registros en la tabla administrador
INSERT INTO personal.administrador (usuario_id, nombres, apellidos, dni, fecha_nacimiento) VALUES
  (1, 'Coco chanel', 'Apellido1', '11111111', '1980-05-10');
  


	
  -- Insertar registros en la tabla zona_trabajo
INSERT INTO ventas.zona_trabajo (nombre, administrador_id) VALUES
  ('default', 1),
  ('la joya', 1),
  ('omate', 1);
  

	
	
  -- Insertar registros en la tabla cliente
INSERT INTO ventas.cliente (usuario_id, nombre, apellidos, fecha_nacimiento, sexo, direccion,telefono, dni, codigo, saldo_beneficios, direccion_empresa, suscripcion, RUC, nombre_empresa, zona_trabajo_id) VALUES
  (4, 'pablo daniel', 'Apellido1', '1992-05-20', 'Femenino', 'Dirección1','67890', '1234567890', 'COD123', 100, 'Empresa1', 'Suscripcion1', '12345678901', 'Empresa A', 1),
  (5, 'juana mariana', 'perez', '1992-05-20', 'Femenino', 'Dirección1', '67890', '1234567890', 'COD123', 130, 'Empresa1', 'Suscripcion1',  '12345678901', 'Empresa A', 1),
  (6, 'eliana', 'rojas', '1992-05-20', 'Femenino', 'Dirección1', '67890', '1234567890', 'COD123', 120, 'Empresa1', 'Suscripcion1',  '12345678901', 'Empresa A', 1),
  (7, 'luis', 'sanchez', '1992-05-20', 'Femenino', 'Dirección1','67890',  '1234567890', 'COD123', 50, 'Empresa1', 'Suscripcion1',  '12345678901', 'Empresa A', 1),
  (8, 'sara', 'lima', '1992-05-20', 'Femenino', 'Dirección1','67890',  '1234567890', 'COD123', 90, 'Empresa1', 'Suscripcion1',  '12345678901', 'Empresa A', 1),
  (9, 'pedro', 'suarez', '1992-05-20', 'Masculino', 'Dirección1', '67890', '1234567890', 'COD123', 38, 'Empresa1', 'Suscripcion1',  '12345678901', 'Empresa A',1),
  (10, 'javier', 'masias', '1992-05-20', 'Femenino', 'Dirección1', '67890', '1234567890', 'COD123', 200, 'Empresa1', 'Suscripcion1', '12345678901', 'Empresa A', 1),
  (11, 'mayra', 'goñi', '1992-05-20', 'Femenino', 'Dirección1', '67890', '1234567890', 'COD123', 45, 'Empresa1', 'Suscripcion1',  '12345678901', 'Empresa A', 1),
  (12, 'jenifer', 'lopez', '1992-05-20', 'Femenino', 'Dirección1', '67890', '1234567890', 'COD123', 70, 'Empresa1', 'Suscripcion1',  '12345678901', 'Empresa A', 1);

 

 
   -- Insertar registros en la tabla cliente
INSERT INTO ventas.cliente_noregistrado (empleado_id, nombre, apellidos, direccion,telefono, email,distrito,RUC) VALUES
  (1, 'señora pochita', 'pochita', 'fatima-uchumayo', '99991515', 'pochita@gmail.com', 'sachaca','105165165165');

 


-- Insertar registros en la tabla empleado
INSERT INTO personal.empleado (usuario_id, nombres, apellidos, dni, fecha_nacimiento, codigo_empleado) VALUES
  (1, 'pepe pepin', 'Apellido3', '4567890123', '1988-02-08', 'EMPL003');

-- Insertar registros en la tabla conductor
INSERT INTO personal.conductor (usuario_id, nombres, apellidos, licencia, dni, fecha_nacimiento) VALUES
  (13, 'lucrecia', 'Apellido3', 'DEF456', '7890123456', '1980-12-04'),
  (14, 'mariana', 'Apellido3', 'DEM456', '23453234', '1990-12-04'),
  (15, 'jose', 'sanchez', 'DEM456', '23453234', '1990-12-04');


-- Insertar registros en la tabla ruta
INSERT INTO ventas.ruta (conductor_id, empleado_id, distancia_km, tiempo_ruta, zona_trabajo_id) VALUES
  (1, 1, 50, 120, 1),
  (2, 1, 80, 480, 1),
  (3, 1, 83, 480, 1),
  (3, 1, 94, 560, 1);
  

  
-- Insertar registros en la tabla pedido
INSERT INTO ventas.pedido (ruta_id, cliente_id, subtotal,descuento,total, fecha, tipo, estado) VALUES
  ( 1, 1, 100,0.0,100, current_timestamp,'normal','pendiente'),
  ( 1, 2, 50.5,0.0,50.5, current_timestamp,'normal','pendiente'),
  ( 4, 1, 200,0.0,200, current_timestamp,'normal','pendiente');
  
INSERT INTO ventas.pedido (ruta_id, cliente_nr_id, subtotal,descuento,total, fecha, tipo, estado) VALUES
  ( 1, 1, 100,0.0,100, current_timestamp,'normal','pendiente');
  
  -- Insertar registros en la tabla producto
INSERT INTO ventas.producto (nombre, precio, descripcion, stock,foto) VALUES
  ('botella 700ml',10.00,'paquete x 15 und.',1000,'BIDON0.png'),
  ('botella 3l',9.00,'paquete x 9 und.',1000,'BIDON03.png'),
  ('botella 7l',5.50,'und.',1000,'BIDON7.png'),
  ('bidon 20l',20.00,'und.',1000,'BIDON20.png'),
  ('recarga',10.00,'und.',0,'RECARGA.png');

INSERT INTO ventas.promocion (nombre, precio, descripcion, fecha_inicio,fecha_limite,foto) VALUES
  ('Promocion Veraniega',48.00,'Lleva 2 bidones NUEVOS x S/. 48.00',current_timestamp,current_timestamp,'BIDON0.png'),
  ('Promociòn de Locura',27.00,'Compra 5 bidones de 7L y lleva 1 GRATIS',current_timestamp,current_timestamp,'BIDON03.png'),
  ('Paquete Playero',39.50,'Por S/.39.50 lleva 1 bidón nuevo y 3 botellas de 3L',current_timestamp,current_timestamp,'RECARGA.png');

INSERT INTO relaciones.producto_promocion (promocion_id, producto_id, cantidad) VALUES
  (1,4,2),
  (2,3,6),
  (3,2,3),
  (3,4,1);


-- Insertar registros en la tabla vehiculo
INSERT INTO ventas.vehiculo (conductor_id, nombre_modelo,placa ) VALUES
  (1, 'Yueyin', 'XE-2L2');
  
-- Insertar registros en la tabla compra
INSERT INTO relaciones.detalle_pedido(pedido_id, producto_id, cantidad) VALUES
  (1, 1, 10),
  (2, 3, 1),
  (2, 1, 15),
  (3, 3, 5),
  (3, 4, 3),
  (3, 1, 8);

-- Insertar registros en ubicacion
INSERT INTO relaciones.ubicacion (latitud,longitud,direccion,cliente_id,distrito) VALUES
(0.0,0.0,'Av Default',1,'Default');

-- Insertar registros en ubicacion
INSERT INTO relaciones.ubicacion (latitud,longitud,direccion,cliente_nr_id,distrito) VALUES
(-3.50,0.0,'Av Default',1,'Default');
