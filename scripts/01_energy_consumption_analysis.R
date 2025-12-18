library(ggplot2)
head(global_climate_energy_2020_2024)
str(global_climate_energy_2020_2024)
#str çıktısında datadaki datein karakter mi yoksa tarih mi olduğunu kontrol etmeliyiz
summary(global_climate_energy_2020_2024)
#gerekli olabilecek istatistikleri bize sağlar

library(dplyr)
turkey_data <- global_climate_energy_2020_2024 %>%
  filter(country == "Turkey")
#dplyr kütüphanesi datamız içerisinden filtreleme yapmamızı sağlar
#bu filtreleme işlemi sonucu datasetindeki ülkeler arasından sadece Türkiyenin verilerinin olduğu yeni bir data seti oluşturmamızı sağladı

ggplot(turkey_data,
       aes(x = date, y = energy_consumption)) + 
  geom_line()+
  labs(title= "Turkey - Energy Consumption Over Time")

ggplot(turkey_data,
       aes(x = avg_temperature, y = energy_consumption))+
  geom_point(alpha = 0.4)+
  labs(
    title = "Tempature vs Energy Consumption (Turkey)",
    x= "Avarage Tempature",
    y= "Energy Consumption"
  )
#Bu kod sayesinde ortalama sıcaklık değerlerine göre total enerji tüketiminin artış azalışını görebiliyoruz


ggplot(turkey_data, aes(x = date)) +
  geom_line(aes(y = energy_consumption), color = "blue") +
  geom_line(aes(y = avg_temperature * 100), color = "red") +
  labs(
    title = "Energy Consumption and Temperature Over Time (Turkey)",
    y = "Energy (blue) / Temperature (scaled red)"
  )
#Bu kod ile elimizdeki zamana göre enerji tüketimi grafiğine aynı sırada o zamanlardaki ortalama sıcaklık verisini de eklemiş olduk
#ve böylelikle elimizdeki verileri kolay anlaşılabilecek şekilde görselleştirmiş olduk



ggplot(turkey_data,
       aes(x = date, y = renewable_share))+
  geom_line()+
  labs(title = "Renewable Energy Share Over Time in Turkey")
#Bu kod ile Türkiyedeki yenilenebilir enerji üretiminin artışını görselleştirdik



ggplot(turkey_data, aes(x = date)) +
  geom_line(aes(y=renewable_share), color="red")+
  geom_line(aes(y=energy_price), color="blue")+
  labs(
    title = "Renewable Energy Share and Energy Price Over Time (Turkey)",
    y = "Share(blue) / Price(red)"
  )

#Bu kod ile yenilenebilir enerjinin artışının enerji fiyatlarına olan etkisini görmeyi amaçladım
#Ancak yenilenebilir enerjinin fiyatlara olan etkisi daha iyi görebilmemiz için
#günlük değil saatlik fiyat verilerine sahip olmamız gerekiyor



ggplot(turkey_data,
       aes(x = renewable_share, y = co2_emission))+
  geom_point(alpha = 0.4)+
  labs(
    title = "Renewable share vs CO2 emission (Turkey)",
    x= "Renewable share",
    y= "CO2 emission"
  )
#Bu kod sayesinde yenilenebilir enerji oranı arttıkça CO2 emisyonunun düştüğünü gözlemledik




library(lubridate)
#Bu kütüphaneyi elimizdeki verileri aylara göre sınıflayabilmek için kullandım

monthly_energy <- turkey_data %>%
  mutate(month = floor_date(date, "month")) %>%
  group_by(month) %>%
  summarise(
    monthly_avg_energy = mean(energy_consumption, na.rm = TRUE)
  )
#Bu kod sayesinde monthly_energy adında yeni bir veri seti oluşturdum ve aylık enerji tüketimlerinin ortalamasını bulmayı sağladım

ggplot(monthly_energy,
       aes(x = month, y = monthly_avg_energy)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Turkey – Monthly Average Energy Consumption (2020–2024)",
    x = "Month",
    y = "Average Energy Consumption"
  )
#Bu kod ile aylık enerji tüketimlerinin ortalamalarını grafikleştirdim





