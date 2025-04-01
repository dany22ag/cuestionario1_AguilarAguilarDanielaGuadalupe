# Aplicar codificación
# Codificación One-Hot (usando model.matrix)
encuesta$id <- 1:nrow(encuesta)  # Aseguramos tener un identificador único
formula_one_hot <- as.formula(paste("~", paste(colnames(encuesta)[sapply(encuesta, is.factor)], collapse = "+"), "- 1"))
one_hot_encoded <- model.matrix(formula_one_hot, data = encuesta)
one_hot_encoded_df <- as.data.frame(one_hot_encoded)
encuesta_codificada_one_hot <- merge(encuesta, one_hot_encoded_df, by.x = "id", by.y = "row.names")
encuesta_codificada_one_hot$id <- NULL

# Comparar cómo los modelos de machine learning reaccionan a diferentes codificaciones.

# Crear un modelo con datos codificados Label Encoding
if (!is.null(encuesta_codificada_label$variable_numerica)){
  formula_label <- as.formula(paste("variable_numerica ~ ", paste(colnames(encuesta_codificada_label)[sapply(encuesta_codificada_label, is.numeric) & !names(encuesta_codificada_label) %in% c("variable_numerica","id")], collapse = " + ")))
  modelo_label <- lm(formula_label, data = encuesta_codificada_label)
  print("Resumen del modelo con Label Encoding:")
  print(summary(modelo_label))
}
