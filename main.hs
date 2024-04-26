-- Duan Espinoza
-- Proyecto 2 
--  Lenguajes programación
-- 2019079490
import System.IO

data Empresa = Empresa { nombreEmpresa :: String, sitioWeb :: String, contacto :: String }
data Bodega = Bodega { identificadorBodega :: Int, capacidad :: Float, ubicacion :: String }
data Usuario = Usuario { idUsuario :: Int, nombreCompleto :: String, puesto :: String }
data Articulo = Articulo { codigo :: String, nombreArticulo :: String, costo :: Float, tipo :: String, tipoIVA :: String }


-- funcionalidad
cargarEmpresa :: FilePath -> IO Empresa
cargarEmpresa archivo = do
    contenido <- readFile archivo
    let lineas = lines contenido
        [nombre, sitioWeb, contacto] = lineas
    return (Empresa nombre sitioWeb contacto)


mostrarEmpresa :: Empresa -> IO ()
mostrarEmpresa empresa = do
    putStrLn "Información de la empresa:"
    putStrLn $ "Nombre: " ++ nombreEmpresa empresa
    putStrLn $ "Sitio Web: " ++ sitioWeb empresa
    putStrLn $ "Contacto: " ++ contacto empresa


cargarBodegas :: FilePath -> IO [Bodega]
cargarBodegas archivo = undefined -- Implementar la carga de información de las bodegas desde el archivo

mostrarBodegas :: [Bodega] -> IO ()
mostrarBodegas bodegas = undefined -- Implementar la función para mostrar la información de las bodegas

cargarUsuarios :: FilePath -> IO [Usuario]
cargarUsuarios archivo = undefined -- Implementar la carga de información de los usuarios desde el archivo

mostrarUsuarios :: [Usuario] -> IO ()
mostrarUsuarios usuarios = undefined -- Implementar la función para mostrar la información de los usuarios

cargarArticulos :: FilePath -> IO [Articulo]
cargarArticulos archivo = undefined -- Implementar la carga de información de los artículos desde el archivo

mostrarArticulos :: [Articulo] -> IO ()
mostrarArticulos articulos = undefined -- Implementar la función para mostrar la información de los artículos




-- Funciones similares para cargar y mostrar información de bodegas, usuarios y artículos

menuOperativo :: IO ()
menuOperativo = do
    putStrLn "Bienvenido al menú de opciones operativas"
    -- Lógica para obtener el ID de usuario
    putStrLn "Seleccione una opción:"
    putStrLn "1. Cargar y Mostrar artículos"
    putStrLn "2. Cargar y Mostrar ingresos de inventario"
    putStrLn "3. Crear orden de compra"
    putStrLn "4. Facturar"
    putStrLn "5. Ver stock de bodegas"
    putStrLn "6. Volver"
    opcion <- getLine
    case opcion of
        "1" -> do
            articulos <- cargarArticulos "articulos.txt"
            mostrarArticulos articulos
            menuOperativo -- Llamada recursiva al menú operativo
        "2" -> do
            -- Lógica para cargar y mostrar ingresos de inventario
            menuOperativo -- Llamada recursiva al menú operativo
        "3" -> do
            -- Lógica para crear orden de compra
            menuOperativo -- Llamada recursiva al menú operativo
        "4" -> do
            -- Lógica para facturar
            menuOperativo -- Llamada recursiva al menú operativo
        "5" -> do
            bodegas <- cargarBodegas "bodegas.txt"
            mostrarBodegas bodegas
            menuOperativo -- Llamada recursiva al menú operativo
        "6" -> putStrLn "Saliendo del menú operativo"
        _   -> do
            putStrLn "Opción inválida. Por favor, seleccione una opción válida."
            menuOperativo -- Llamada recursiva al menú operativo
