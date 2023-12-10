-- esquema persona:
create schema personal;

-- esquema ventas:
create schema ventas;

-- esquema relaciones:
create schema relaciones;


-----------------------------------
-- RELACIONES
-----------------------------------

-- Table : roles
create table relaciones.roles(
	id serial primary key,
	nombre varchar(300)
);



------------------------------------
-- PERSONAL
------------------------------------

-- Table: personal.user
create table personal.usuario(
	id serial primary key,
	rol_id int not null,
	nickname varchar(100) not null,
	contrasena varchar(100) not null,
	email varchar(200) not null
);

-- Table: personal.superadmin
create table personal.superadmin(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(100) not null,
	apellidos varchar(200) not null,
	dni varchar(200) not null,
	fecha_nacimiento date not null
);

-- Table: personal.administrador
create table personal.administrador(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(200) not null,
	apellidos varchar(200) not null,
	dni varchar(100) not null,
	fecha_nacimiento date not null
);

-- Table: personal.conductor
create table personal.conductor(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(100) not null,
	apellidos varchar(100) not null,
	licencia varchar (100) not null,
	dni varchar(100) not null,
	fecha_nacimiento date not null
);	

-- Table: personal.empleado
create table personal.empleado(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(100) not null,
	apellidos varchar(200) not null,
	dni varchar(200) not null,
	fecha_nacimiento date not null,
	codigo_empleado varchar(200) not null
);

------------------------------------
-- VENTAS
------------------------------------

-- Table: ventas.cliente
create table ventas.cliente(
	id serial primary key,
	usuario_id int unique,
	nombre varchar(100) not null,
	apellidos varchar(100) not null,
	fecha_nacimiento date not null,
	sexo varchar(100) not null,
	direccion varchar(150) not null,
	dni varchar(100) not null,
	codigo varchar(200) not null,
	saldo_beneficios int not null,
	direccion_empresa varchar(200),
	suscripcion varchar(200) not null,
	ubicacion varchar(200) not null,
	RUC varchar(200),
	nombre_empresa varchar(200),
	zona_trabajo_id int not null
);

-- Table: ventas.ruta
create table ventas.ruta(
	id serial primary key,
	conductor_id int not null,
	administrador_id int not null,
	empleado_id int not null,
	origen varchar(100) not null,
	destino varchar(100) not null,
	distancia_km int not null,
	tiempo_ruta int not null,
	zona_trabajo_id int not null
);

-- Table: ventas.pedido
create table ventas.pedido(
	id serial primary key,
	conductor_id int,
	ruta_id int,
	empleado_id int,
	cliente_id int not null,
	monto_total int not null,
	fecha timestamp not null,
	direccion varchar(300) not null
);

--Table: ventas.producto
create table ventas.producto(
	id serial primary key,
	nombre varchar(200) not null,
	precio int not null,
	descripcion varchar(200) not null,
	stock int not null
);

-- Table: ventas.vehiculo
create table ventas.vehiculo(
	id serial primary key,
	conductor_id int not null,
	placa varchar(100) not null,
	capacidad_carga_ton int not null
);

--Table: ventas.venta
create table ventas.venta(
	id serial primary key,
	administrador_id int not null,
	conductor_id int not null,
	fecha timestamp not null,
	foto varchar(200) not null
);

--Table: ventas.zona_trabajo
create table ventas.zona_trabajo(
	id serial primary key,
	nombre varchar(50) not null,
	superadmin_id int not null
);

---------------------------------
-- RELACIONES
---------------------------------

--Table: relaciones.compra
create table relaciones.detalle_pedido(
	id serial primary key,
	pedido_id int,
	producto_id int not null,
	fecha timestamp not null,
	cantidad int not null,
	descripcion_general varchar(200) not null,
	descuento int not null,
	precio_total int not null
);

---------------------------------
-- CONSTRAINTS
---------------------------------
-- ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (id);

--- RUTA
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_empleado FOREIGN KEY (empleado_id) REFERENCES personal.empleado (id);
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_conductor FOREIGN KEY (conductor_id) REFERENCES personal.conductor (id);
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_administrador FOREIGN KEY (administrador_id) REFERENCES personal.administrador (id);
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_zona_trabajo FOREIGN KEY (zona_trabajo_id) REFERENCES ventas.zona_trabajo (id);

-- PEDIDO
ALTER TABLE ventas.pedido ADD CONSTRAINT fk_pedido_ruta FOREIGN KEY (ruta_id) REFERENCES ventas.ruta (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ventas.pedido ADD CONSTRAINT fk_pedido_empleado FOREIGN KEY (empleado_id) REFERENCES personal.empleado (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ventas.pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES ventas.cliente (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ventas.pedido ADD CONSTRAINT fk_pedido_conductor FOREIGN KEY (conductor_id) REFERENCES personal.conductor (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ZONA TRABAJO
ALTER TABLE ventas.zona_trabajo ADD CONSTRAINT fk_zona_trabajo_superadmin FOREIGN KEY (superadmin_id) REFERENCES personal.superadmin (id);

-- VEHICULO
ALTER TABLE ventas.vehiculo ADD CONSTRAINT fk_vehiculo_conductor FOREIGN KEY (conductor_id) REFERENCES personal.conductor (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- VENTA
ALTER TABLE ventas.venta ADD CONSTRAINT fk_venta_admin FOREIGN KEY (administrador_id) REFERENCES personal.administrador (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ventas.venta ADD CONSTRAINT fk_venta_conductor FOREIGN KEY (conductor_id) REFERENCES personal.conductor (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- COMPRA
ALTER TABLE relaciones.detalle_pedido ADD CONSTRAINT fk_compra_producto FOREIGN KEY (producto_id) REFERENCES ventas.producto (id);
ALTER TABLE relaciones.detalle_pedido ADD CONSTRAINT fk_compra_pedido FOREIGN KEY (pedido_id) REFERENCES ventas.pedido (id);

-- ROLES
ALTER TABLE personal.usuario ADD CONSTRAINT fk_usuario_rol FOREIGN KEY (rol_id) REFERENCES relaciones.roles(id);

-- CLIENTE
ALTER TABLE ventas.cliente ADD CONSTRAINT fk_cliente_zona FOREIGN KEY (zona_trabajo_id) REFERENCES ventas.zona_trabajo (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- USUARIOS
ALTER TABLE ventas.cliente ADD CONSTRAINT fk_cliente_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.superadmin ADD CONSTRAINT fk_superadmin_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.administrador ADD CONSTRAINT fk_administrador_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.conductor ADD CONSTRAINT fk_conductor_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.empleado ADD CONSTRAINT fk_empleado_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;