library(ggplot2)

# Generar datos de transacciones con valores atípicos
set.seed(123)  # Para reproducibilidad
transacciones <- data.frame(
  Monto = c(rnorm(50, mean = 1000, sd = 200),  # 50 valores normales
            5000, 5500, 6000,  # Valores atípicos altos
            200, 150)  # Valores atípicos bajos
)

# Crear diagrama de caja
ggplot(transacciones, aes(y = Monto)) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(title = "Diagrama de Caja de Transacciones",
       y = "Monto de Transacción") +
  theme_minimal()

# Calcular cuartiles
Q1 <- quantile(transacciones$Monto, 0.25)
Q3 <- quantile(transacciones$Monto, 0.75)
IQR <- Q3 - Q1  # Rango intercuartil

# Definir límites de outliers
limite_inferior <- Q1 - 1.5 * IQR
limite_superior <- Q3 + 1.5 * IQR

# Identificar outliers
outliers <- transacciones$Monto[transacciones$Monto < limite_inferior | transacciones$Monto > limite_superior]
print(outliers)  # Muestra los valores atípicos detectados


transacciones_filtradas <- transacciones[transacciones$Monto >= limite_inferior & transacciones$Monto <= limite_superior, ]

mediana <- median(transacciones$Monto)
transacciones$Monto[transacciones$Monto < limite_inferior | transacciones$Monto > limite_superior] <- mediana

  summary(transacciones$Monto)

  summary(transacciones_filtradas$Monto)  
