library(gamair)
library(mgcv)

data(co2s)
co2 = co2s$co2
time = co2s$c.month
month = co2s$month

#Regular Linear regression model
m1 = lm(co2 ~ time + month)
summary(m1)
plot(m1)

#GAMs model
m2 = gam(co2 ~ s(time) + s(month), data = co2s)
summary(m2)
plot(m2)

data(chicago)
deaths = chicago$death
pm10 = chicago$pm10median
pm25 = chicago$pm25median
o3 = chicago$o3median
so2 = chicago$so2median
time = chicago$time
temp = chicago$tmpd

#Regular Linear regression model
m1 = lm(deaths ~ pm10 + pm25 + o3 + so2 + time + temp)
summary(m1)
plot(m1)

#GAMs model
m2 = gam(deaths ~ s(pm10) + s(pm25) + s(o3) + s(so2) + s(time) + s(temp), data = chicago)
summary(m2)
plot(m2)


