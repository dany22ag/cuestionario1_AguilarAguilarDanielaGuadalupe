Library(dplyr)
# Generar un dataframe de ejemplo
Set.seed(123)
Data <- data.frame(
  ID = 1:10,
  Satisfaccion = sample(c(“baja”, “media”, “alta”), 10, replace = TRUE),
  Servicio = sample(c(“A”, “B”, “C”), 10, replace = TRUE)
)
# Convertir variables categóricas en factores
Data$Satisfaccion <- as.factor(data$Satisfaccion)
Data$Servicio <- as.factor(data$Servicio)
# Aplicar codificación one-hot
One_hot_encoded <- model.matrix(~ Satisfaccion + Servicio – 1, data =
                                  data)
# Mostrar el dataframe original y el transformado
Print(“Data original:”)
Print(data)
Print(“Data codificada:”)
Print(one_hot_encoded)
# Evaluar el impacto en modelos de regresión
# Generamos una varia
ble de respuesta ficticia
Data$Score <- rnorm(10, mean = 50, sd = 10)
# Ajustar un modelo de regresión lineal
Modelo <- lm(Score ~ ., data = as.data.frame(one_hot_encoded))
Summary(modelo)