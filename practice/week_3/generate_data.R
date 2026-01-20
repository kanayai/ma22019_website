library(dplyr)
library(lubridate)

set.seed(2022)
n <- 3415

## V2: Phosphate Levels pmm
Phospate <- rgamma(n, shape = 60, rate = 0.75)

## V3: Date of planting
Date <- as_date("2024-03-01", format = "%Y-%m-%d")
Date <- Date + round(60 * rbeta(n, 2, 3))
hist(Date, breaks = 20)

## V4: Type of plant
orchids <- c("Cymbidium", "Dendrobium")
Types <- sample(orchids, n, replace = T)

## V5: Temperature
Temp <- rep(0, n)
for (i in 1:n) {
  Temp[i] <- case_when(
    Types[i] == "Cymbidium" ~ 16.4 + 4.7 * rbeta(1, 2, 2),
    Types[i] == "Dendrobium" ~ 17.5 + 5.2 * rbeta(1, 2, 2),
  )
}

## V1: Orchid Height in inches
height <- c(17, 30)
Height <- rep(0, n)

ind <- which(Types == "Cymbidium")
Height[ind] <- height[1] + 0.2 * sqrt(Phospate[ind]) +
  0.3 * log(as.numeric(as_date("2024-10-15") - Date[ind])) +
  0.3 * (Temp[ind] - 17) - 7 + rnorm(length(ind), sd = height[1] / 10)

ind <- which(Types == "Dendrobium")
Height[ind] <- height[2] + 0.3 * sqrt(Phospate[ind]) +
  0.35 * log(as.numeric(as_date("2024-10-15") - Date[ind])) +
  0.4 * (Temp[ind] - 17) - 10 +
  rnorm(length(ind), sd = height[2] / 10)


## V8: Quality
Quality <- rep(0, n)
ind <- which(Types == "Cymbidium")
Quality[ind] <-
  round(7 - 6 / 50 * abs(
    as.numeric(as_date("2024-04-07") - Date[ind]) +
      round(runif(length(ind), -10, 10))
  )) +
  round(runif(length(ind), -3, 0)) +
  0.15 * Height[ind]

ind <- which(Types == "Dendrobium")
Quality[ind] <-
  round(7 - 6 / 50 * abs(
    as.numeric(as_date("2024-04-01") - Date[ind]) +
      round(runif(length(ind), -10, 10))
  )) +
  round(runif(length(ind), -3, 0)) +
  0.05 * Height[ind]

Orchids <- data.frame(
  "Type" = Types,
  "Height" = round(Height, 1),
  "Quality" = round(Quality),
  "Phosphate" = round(Phospate),
  "Temperature" = round(Temp, 1),
  "Planting" = Date
)

setwd("C:/Users/cr777/Desktop/Teaching 2024-2025/MA22019/Problem Sheets/Problem Sheet 2//")
write.csv(Orchids, "data/Orchids.csv", row.names = FALSE)
