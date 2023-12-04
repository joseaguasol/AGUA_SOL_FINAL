select * from relaciones.roles;

select * from personal.usuario;
select * from personal.administrador;

select * from personal.conductor;
select * from personal.empleado;
select * from personal.superadmin;

select * from ventas.zona_trabajo;
select * from ventas.pedido;
select * from relaciones.compra;
select * from ventas.ruta;
select * from ventas.vehiculo;
select * from ventas.cliente;
select * from ventas.producto;
select * from ventas.venta;


select * from personal.usuario inner join personal.administrador
on personal.usuario.id = personal.administrador.usuario_id;




SELECT * FROM personal.usuario WHERE id = 1;


