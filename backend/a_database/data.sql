-- Insertar registros en la tabla roles
INSERT INTO relaciones.roles (nombre) VALUES
  ('administrador'),
  ('empleado'),
  ('superadmin'),
  ('cliente'),
  ('conductor');
  
  
 -- Insertar registros en la tabla usuario
INSERT INTO personal.usuario (rol_id,nickname, contrasena, email) VALUES
  (1,'jorgito', 'contrasena1', 'usuario1@example.com'),
  (2,'pepito', 'contrasena2', 'usuario2@example.com'),
  (3,'ñoño', 'contrasena2', 'usuario2@example.com'),
  (4,'pablito', 'contrasena2', 'usuario2@example.com'),
  (5,'lucas', 'contrasena3', 'usuario3@example.com');
  
  
  -- Insertar registros en la tabla superadmin
INSERT INTO personal.superadmin (usuario_id, nombres, apellidos, dni, fecha_nacimiento) VALUES
  (3, 'monchito', 'Apellido1', '12345678', '1990-01-01');
  

	
  -- Insertar registros en la tabla zona_trabajo
INSERT INTO ventas.zona_trabajo (departamento, superadmin_id) VALUES
  ('arequipa', 1),
  ('moquegua', 1),
  ('tacna', 1);
  

	
	
  -- Insertar registros en la tabla cliente
INSERT INTO ventas.cliente (usuario_id, nombre, apellidos, fecha_nacimiento, sexo, direccion, dni, codigo, saldo_beneficios, direccion_empresa, suscripcion, ubicacion, RUC, nombre_empresa, zona_trabajo_id) VALUES
  (4, 'pablo daniel', 'Apellido1', '1992-05-20', 'Femenino', 'Dirección1', '1234567890', 'COD123', 100, 'Empresa1', 'Suscripcion1', 'Ubicacion1', '12345678901', 'Empresa A', 1);

 

 
   -- Insertar registros en la tabla cliente
INSERT INTO ventas.cliente_noregistrado (nombre, apellidos, direccion,telefono, email,distrito,ubicacion,RUC) VALUES
  ('señora pochita', 'pochita', 'fatima-uchumayo', '99991515', 'pochita@gmail.com', 'sachaca', '-16.78,71.26','105165165165');

 
 
 -- Insertar registros en la tabla administrador
INSERT INTO personal.administrador (usuario_id, nombres, apellidos, dni, fecha_nacimiento) VALUES
  (1, 'Coco chanel', 'Apellido1', '11111111', '1980-05-10');
  



-- Insertar registros en la tabla empleado
INSERT INTO personal.empleado (usuario_id, nombres, apellidos, dni, fecha_nacimiento, codigo_empleado) VALUES
  (2, 'pepe pepin', 'Apellido3', '4567890123', '1988-02-08', 'EMPL003');

-- Insertar registros en la tabla conductor
INSERT INTO personal.conductor (usuario_id, nombres, apellidos, licencia, dni, fecha_nacimiento) VALUES
  (5, 'lucrecia', 'Apellido3', 'DEF456', '7890123456', '1980-12-04');
  
  
  
  

-- Insertar registros en la tabla venta
INSERT INTO ventas.venta (administrador_id, conductor_id, fecha, foto) VALUES
  (1, 1, '2023-01-15 08:30:00', 'foto1.jpg'),
  (1, 1, '2023-02-20 10:45:00', 'foto2.jpg'),
  (1, 1, '2023-03-25 12:15:00', 'foto3.jpg');

-- Insertar registros en la tabla ruta
INSERT INTO ventas.ruta (conductor_id, administrador_id, empleado_id, multipuntos, distancia_km, tiempo_ruta, zona_trabajo_id) VALUES
  (1, 1, 1, '16.78,71.22;-16.88,16.12', 50, 120, 1);
  

  
-- Insertar registros en la tabla pedido
INSERT INTO ventas.pedido (conductor_id, ruta_id, empleado_id, cliente_id, monto_total, fecha, tipo, estado) VALUES
  (1, 1, 1, 1, 200, current_timestamp,'express','pendiente');
  

  
  
  -- Insertar registros en la tabla producto
INSERT INTO ventas.producto (nombre, precio, descripcion, stock,foto) VALUES
  ('botella 700ml',2,'botella de 700ml',100,'foto1.jpg'),
  ('botella 3l',5,'botella de 3l',200,'foto2.jpg'),
  ('bidon 20l',20,'bidon de 20l',200,'foto3.jpg');




-- Insertar registros en la tabla vehiculo
INSERT INTO ventas.vehiculo (conductor_id, placa, capacidad_carga_ton) VALUES
  (1, 'ABC123', 2);
  
-- Insertar registros en la tabla compra
INSERT INTO relaciones.detalle_pedido(pedido_id, producto_id, cantidad) VALUES
  (1, 1, 10);