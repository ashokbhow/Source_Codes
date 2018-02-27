SFood <- function() {
      attach(USDF_Check)
      ## Separating Safe Foods 
      Pass1 <- USDF_Check[which(USDF_Check$HighSodium == '0'), ]
      nrow(Pass1)
      
      Pass2 <- Pass1[which(Pass1$HighSugar == '0'), ]
      nrow(Pass2)
      
      SafeFoods <- Pass2[which(Pass2$HighFat == '0'), ]
      nrow(SafeFoods)
      View(SafeFoods)
      detach(USDF_Check)
      stop()
}
##