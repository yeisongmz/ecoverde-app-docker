--script para hacer funcionar servidor foreign

--en la base de datos antes de restaurar debe haber un usuario ecoverde con permiso superusuario
create database ecologiadb;
create user ecoverde superuser;
alter user ecoverde with password 'ecoverde.2021';


--si se desea cambiar los datos de acceso a server externo mysql ejemplo password



ALTER SERVER desa04_server OPTIONS (SET host 'localhost', SET port '3306');

ALTER USER MAPPING FOR ecoverde SERVER desa04_server OPTIONS (SET username  'cobranza', SET password 'cobranza');
