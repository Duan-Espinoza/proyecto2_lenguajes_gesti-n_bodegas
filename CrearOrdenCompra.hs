module CrearOrdenCompra where

import System.IO
import Data.Time.Clock
import Data.Time.Format

-- Definición de tipos de datos
type CedulaCliente = String
type NombreCliente = String
type CodigoArticulo = String
type Cantidad = Int
type IdOrdenCompra = Int

data OrdenCompra = OrdenCompra {
    idOrden :: IdOrdenCompra,
    cedulaCliente :: CedulaCliente,
    nombreCliente :: NombreCliente,
    fechaHora :: String,
    lineasOrden :: [LineaOrden]
}

data LineaOrden = LineaOrden {
    codigoArticulo :: CodigoArticulo,
    cantidad :: Cantidad
}

-- Funciones para crear una orden de compra

-- Función principal para crear una orden de compra
crearOrdenCompra :: IO ()
crearOrdenCompra = do
    putStrLn "Creación de Orden de Compra"
    putStrLn "Ingrese la cédula del cliente:"
    cedula <- getLine
    putStrLn "Ingrese el nombre del cliente:"
    nombre <- getLine
    fechaHoraActual <- obtenerFechaHoraActual
    let nuevaOrden = OrdenCompra {
        idOrden = 0,  -- Aquí puedes utilizar alguna función para generar un nuevo ID de orden de compra
        cedulaCliente = cedula,
        nombreCliente = nombre,
        fechaHora = fechaHoraActual,
        lineasOrden = []
    }
    putStrLn "Ingrese los artículos que desea incluir en la orden de compra (presione Enter para finalizar):"
    ordenConArticulos <- agregarArticulos nuevaOrden
    putStrLn $ "Orden de Compra creada con éxito. ID de Orden: " ++ show (idOrden ordenConArticulos)

-- Función para agregar artículos a la orden de compra
agregarArticulos :: OrdenCompra -> IO OrdenCompra
agregarArticulos orden = do
    putStrLn "Ingrese el código del artículo (o presione Enter para finalizar):"
    codigo <- getLine
    if null codigo
        then return orden  -- Si el usuario presiona Enter sin ingresar un código, termina la agregación de artículos
        else do
            putStrLn "Ingrese la cantidad:"
            cantidadStr <- getLine
            let cantidad = read cantidadStr :: Int
            let nuevaLinea = LineaOrden {
                codigoArticulo = codigo,
                cantidad = cantidad
            }
            let ordenActualizada = orden { lineasOrden = nuevaLinea : lineasOrden orden }
            agregarArticulos ordenActualizada

-- Obtener la fecha y hora actual como una cadena
obtenerFechaHoraActual :: IO String
obtenerFechaHoraActual = do
    now <- getCurrentTime
    return $ formatTime defaultTimeLocale "%Y-%m-%d %H:%M:%S" now
