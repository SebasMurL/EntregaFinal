CREATE DATABASE db_TiendaSubastas;
GO
USE db_TiendaSubastas;
GO
CREATE TABLE Clientes (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Cedula NVARCHAR(20) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Telefono NVARCHAR(20) NULL
);

CREATE TABLE Categorias (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255) NULL
);

CREATE TABLE Productos (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255) NULL,
    PrecioInicial DECIMAL(18,2) NOT NULL,
    ID_Categoria INT NOT NULL,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID) ON DELETE CASCADE
);

CREATE TABLE Vendedores (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Cedula NVARCHAR(20) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Telefono NVARCHAR(20) NULL
);

CREATE TABLE Estados (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion NVARCHAR(100) NOT NULL
);

CREATE TABLE Subastas (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_Producto INT NOT NULL,
    ID_Vendedor INT NOT NULL,
    ID_Estado INT NOT NULL,
    Fecha_Inicio DATETIME NOT NULL,
    Fecha_Fin DATETIME NOT NULL,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_Vendedor) REFERENCES Vendedores(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID) ON DELETE CASCADE
);

CREATE TABLE Pujas (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    ID_Subasta INT NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    Fecha_Hora DATETIME NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_Subasta) REFERENCES Subastas(ID) ON DELETE CASCADE
);

CREATE TABLE Metodos_Pagos (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Tipo_Pago NVARCHAR(100) NOT NULL
);

CREATE TABLE Pagos (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Referencia NVARCHAR(100) UNIQUE NOT NULL,
    ID_Cliente INT NOT NULL,
    ID_Subasta INT NOT NULL,
    ID_MetodoPago INT NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_Subasta) REFERENCES Subastas(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_MetodoPago) REFERENCES Metodos_Pagos(ID) ON DELETE CASCADE
);

-- Inserción de datos
	INSERT INTO Clientes (Nombre, Cedula, Email, Telefono) VALUES
		('Juan Pérez', '123', 'JuanP@gmail.com', '3101234567'),
		('Ana Torres', '456', 'AnaT@gmail.com', '3152345678'),
		('Carlos Ruiz', '567', 'CarlosR@gmail.com', '3203456789'),
		('Andres Salazar', '945', 'AndresZ@gmail.com', '3185678901'),
		('Rosa Martinez', '347', 'RosaM@gmail.com', '3116789012');

	INSERT INTO Categorias (Nombre, Descripcion) VALUES
		('Electrónica', 'Productos electrónicos'),
		('Hogar', 'Artículos para el hogar'),
		('Moda', 'Ropa y accesorios'),
		('Deportes', 'Equipamiento deportivo'),
		('Juguetes', 'Juegos y juguetes');

	INSERT INTO Productos (Nombre, Descripcion, PrecioInicial, ID_Categoria) VALUES
		('¡Phone', 'Teléfono de última generación', 500.00, 1),
		('Sofá', 'Sofá de cuero 3 puestos', 800.00, 2),
		('Camisa', 'Camisa de algodón para hombre', 30.00, 3),
		('Bicicleta', 'Bicicleta de montaña', 300.00, 4),
		('Muñeca', 'Muñeca de colección', 25.00, 5);

	INSERT INTO Vendedores (Nombre, Cedula, Email, Telefono) VALUES
		('Luis Martínez', '111222333', 'luis@example.com', '3123456789'),
		('Ana Gómez', '444555666', 'ana@example.com', '3224567890'),
		('David Fernández', '777888999', 'david@example.com', '3335678901'),
		('Elena Ruiz', '123789456', 'elena@example.com', '3446789012'),
		('Sergio Castro', '987321654', 'sergio@example.com', '3557890123');

	INSERT INTO Estados (Descripcion) VALUES
		('Activa'),
		('Finalizada'),
		('Cancelada'),
		('Pendiente'),
		('Suspendida');

	INSERT INTO Metodos_Pagos (Tipo_Pago) VALUES
		('Tarjeta'),
		('PayPal'),
		('Transferencia bancaria'),
		('Efectivo'),
		('Criptomonedas');