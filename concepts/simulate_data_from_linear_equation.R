#Iwelche Daten simulieren
X <- rnorm(100, mean = 5, sd = 2)

#b0, b1 festlegen, z.B. b0=1, b1=2 --> Erwartungswerte in Abhängikeit von X generieren
expected_y <- 1 + 2 * X

#Einen "beobachteten" Wert pro erwartetem Wert ziehen: Aus Verteilung mit erwartetem Wert als MW und einer SD 
#--> erwarteter Wert mit Noise
y <- rnorm(100, mean = expected_y, sd = 4)