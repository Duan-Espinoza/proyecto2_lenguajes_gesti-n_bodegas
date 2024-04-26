type CodigoArticulo = String
type NombreArticulo = String
type Costo = Float
type Tipo = String
type TipoIVA = String

data Articulo = Articulo {
    codigoArticulo :: CodigoArticulo,
    nombreArticulo :: NombreArticulo,
    costo :: Costo,
    tipo :: Tipo,
    tipoIVA :: TipoIVA
}

-- Cargar información de los artículos desde un archivo
cargarArticulos :: FilePath -> IO [Articulo]
cargarArticulos archivo = do
    contenido <- readFile archivo
    let lineas = map words $ lines contenido
    return $ map (\[codigo, nombre, costo, tipo, tipoIVA] -> Articulo codigo nombre (read costo) tipo tipoIVA) lineas

-- Mostrar un artículo en la consola
mostrarArticulo :: Articulo -> IO ()
mostrarArticulo articulo = do
    putStrLn $ "Código: " ++ codigoArticulo articulo
    putStrLn $ "Nombre: " ++ nombreArticulo articulo
    putStrLn $ "Costo: " ++ show (costo articulo)
    putStrLn $ "Tipo: " ++ tipo articulo
    putStrLn $ "Tipo IVA: " ++ tipoIVA articulo

-- Mostrar todos los artículos del sistema
mostrarArticulos :: [Articulo] -> IO ()
mostrarArticulos [] = return ()
mostrarArticulos (articulo:resto) = do
    mostrarArticulo articulo
    putStrLn "----------------------"
    mostrarArticulos resto
