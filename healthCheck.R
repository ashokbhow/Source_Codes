USDF_Check <- USDF[, c(2, 3, 18, 19, 20)]
View(USDF_Check)
nrow(USDF_Check)
##
attach(USDF_Check)
##
Pass1 <- USDF_Check[which(USDF_Check$HighSodium == '0'), ]
nrow(Pass1)
View(Pass1)
##
Fail1 <- USDF_Check[which(USDF_Check$HighSodium == '1'), ]
nrow(Fail1)
View(Fail1)
##
Pass2 <- Pass1[which(Pass1$HighSugar == '0'), ]
nrow(Pass2)
View(Pass2)
##
Fail2 <- Fail1[which(Fail1$HighSugar == '1'), ]
nrow(Fail2)
View(Fail2)
##
Pass3 <- Pass2[which(Pass2$HighFat == '0'), ]
nrow(Pass3)
View(Pass3)
##
Fail3 <- Fail2[which(Fail2$HighFat == '1'), ]
nrow(Fail3)
View(Fail3)
##

detach(USDF_Check)

Int1 <- USDF_Check[which(USDF_Check$HighSodium == '0' & USDF_Check$HighSugar == '0'), ]
nrow(Int1)
View(Int1)
##
Int2 <- USDF_Check[which(USDF_Check$HighSodium == '0' & USDF_Check$HighFat == '0'), ]
nrow(Int2)
View(Int2)
##
Int3 <- USDF_Check[which(USDF_Check$HighSugar == '0' & USDF_Check$HighFat == '0'), ]
nrow(Int3)
View(Int3)


