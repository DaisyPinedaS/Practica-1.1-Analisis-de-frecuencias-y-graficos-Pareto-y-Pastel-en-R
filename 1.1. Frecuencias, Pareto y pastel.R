#Práctica 1.1:
# ========================================================================
# Script para calcular frecuencias, frecuencias relativas, 
# diagrama de Pareto y gráfico de pastel a partir de un CSV
# Guardando las gráficas en TIFF a 600 dpi con fondo blanco
# ========================================================================

# 1. Seleccionar e importar el archivo CSV
# file.choose() abre un cuadro de diálogo para seleccionar el archivo frecuencias.csv
datos <- read.csv(file.choose(), header = FALSE, stringsAsFactors = FALSE)

# 2. Convertir la tabla en un vector (una sola columna con todos los datos)
# as.vector() extrae los elementos y c() los aplana en un solo vector
marcas <- as.vector(as.matrix(datos))

# 3. Calcular la frecuencia absoluta de cada marca
# table() cuenta cuántas veces aparece cada valor
frecuencia <- table(marcas)

# 4. Calcular la frecuencia relativa
# Se divide la frecuencia entre el total de observaciones
frecuencia_relativa <- prop.table(frecuencia)

# 5. Mostrar las tablas de frecuencias
cat("Frecuencia absoluta:\n")
print(frecuencia)

cat("\nFrecuencia relativa:\n")
print(frecuencia_relativa)

# 6. Instalar y cargar el paquete necesario para Pareto si no está instalado
if (!require(qcc)) install.packages("qcc", dependencies = TRUE)
library(qcc)

# ========================
# 7. Guardar Diagrama de Pareto en TIFF
# ========================
tiff("pareto.tiff", width = 15, height = 10, units = "cm", res = 600, bg = "white")
pareto.chart(frecuencia, ylab = "Frecuencia", main = "Diagrama de Pareto")
dev.off()

# ========================
# 8. Guardar gráfico de pastel en TIFF
# ========================
tiff("pastel.tiff", width = 15, height = 10, units = "cm", res = 600, bg = "white")
pie(frecuencia, 
    labels = paste(names(frecuencia), "\n", round(frecuencia_relativa * 100, 1), "%"), 
    main = "Distribución de Marcas",
    col = rainbow(length(frecuencia)))
dev.off()

# 9. Mensaje de confirmación
cat("\nGráficos guardados como 'pareto.tiff' y 'pastel.tiff' en el directorio de trabajo.\n")

# Para saber el directorio de trabajo actual:
cat("Directorio actual: ", getwd(), "\n")