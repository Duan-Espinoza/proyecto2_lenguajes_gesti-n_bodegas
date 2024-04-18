-- Duan Espinoza


data Empresa = Empresa { nombre :: String, sitioWeb :: String, contacto :: String }
data Bodega = Bodega { identificador :: Int, capacidad :: Float, ubicacion :: String }
data Usuario = Usuario { idUsuario :: Int, nombreCompleto :: String, puesto :: String }
data Articulo = Articulo { codigo :: String, nombreArticulo :: String, costo :: Float, tipo :: String, tipoIVA :: String }

cargarEmpresa :: FilePath -> IO Empresa
cargarEmpresa archivo = undefined -- Implementar la carga de información de la empresa desde el archivo

mostrarEmpresa :: Empresa -> IO ()
mostrarEmpresa empresa = undefined -- Implementar la función para mostrar la información de la empresa




-- Funciones similares para cargar y mostrar información de bodegas, usuarios y artículos

-- Función principal para el menú de opciones operativas
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
        "1" -> cargarYMostrarArticulos
        "2" -> cargarYMostrarIngresos
        "3" -> crearOrdenDeCompra
        "4" -> facturar
        "5" -> verStockDeBodegas
        "6" -> putStrLn "Saliendo del menú operativo"
        _   -> putStrLn "Opción inválida. Por favor, seleccione una opción válida."
        -- Lógica para volver al menú principal
        -- Llamada recursiva a menuOperativo
