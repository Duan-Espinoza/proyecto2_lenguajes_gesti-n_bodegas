module CargaMuestraIngreso where

import System.IO
import Data.Time.Clock
import Data.Time.Format
import Control.Monad
import Data.List (find)


-- Definición de tipos de datos
type CodigoArticulo = String
type IdentificadorBodega = Int
type Cantidad = Int
type IdIngreso = Int

data Ingreso = Ingreso {
    idIngreso :: IdIngreso,
    idUsuario :: Int,
    fechaHora :: String, -- Se podría utilizar un tipo de datos específico para fecha y hora si es necesario
    lineasInventario :: [LineaInventario]
}

data LineaInventario = LineaInventario {
    codigoArticulo :: CodigoArticulo,
    identificadorBodega :: IdentificadorBodega,
    cantidad :: Cantidad
}

-- Funciones para cargar y mostrar ingresos de inventario

-- Cargar ingresos de inventario desde un archivo
cargarIngresos :: FilePath -> IO [Ingreso]
cargarIngresos archivo = do
    contenido <- readFile archivo
    let lineas = map words $ lines contenido
    return $ map (\l -> parsearIngreso l) lineas

-- Parsear una línea de ingreso de inventario
parsearIngreso :: [String] -> Ingreso
parsearIngreso (id:usuario:fecha:resto) = Ingreso (read id) (read usuario) fecha (map parsearLineaInventario resto)

-- Parsear una línea de inventario
parsearLineaInventario :: String -> LineaInventario
parsearLineaInventario linea = 
    let [codigo, identificador, cantidad] = words linea
    in LineaInventario codigo (read identificador) (read cantidad)

-- Mostrar un ingreso de inventario en la consola
mostrarIngreso :: Ingreso -> IO ()
mostrarIngreso ingreso = do
    putStrLn $ "ID de Ingreso: " ++ show (idIngreso ingreso)
    putStrLn $ "ID de Usuario: " ++ show (idUsuario ingreso)
    putStrLn $ "Fecha y Hora: " ++ fechaHora ingreso
    putStrLn "Detalles de Inventario:"
    mapM_ mostrarLineaInventario (lineasInventario ingreso)

-- Mostrar una línea de inventario en la consola
mostrarLineaInventario :: LineaInventario -> IO ()
mostrarLineaInventario linea = do
    putStrLn $ "Código de Artículo: " ++ codigoArticulo linea
    putStrLn $ "Identificador de Bodega: " ++ show (identificadorBodega linea)
    putStrLn $ "Cantidad: " ++ show (cantidad linea)

-- Buscar un ingreso de inventario por su código
buscarIngresoPorCodigo :: IdIngreso -> [Ingreso] -> Maybe Ingreso
buscarIngresoPorCodigo codigo ingresos = find (\ingreso -> idIngreso ingreso == codigo) ingresos

-- Funciones adicionales para gestionar ingresos de inventario

-- Generar un nuevo ID de ingreso
generarNuevoIdIngreso :: [Ingreso] -> IdIngreso
generarNuevoIdIngreso ingresos = maximum (map idIngreso ingresos) + 1

-- Obtener la fecha y hora actual como una cadena
obtenerFechaHoraActual :: IO String
obtenerFechaHoraActual = do
    now <- getCurrentTime
    return $ formatTime defaultTimeLocale "%Y-%m-%d %H:%M:%S" now
