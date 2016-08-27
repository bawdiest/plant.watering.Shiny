library("RMySQL");

getRecentWeatherData <- function () {



# Create DB Connection ----------------------------------------------------

con <- dbConnect(MySQL(),
                 user = "read", 
                 host = "mikmak.cc", 
                 password = "809913", 
                 db = "weatherDW");

# Get Recent MessageID ----------------------------------------------------

query <- dbSendQuery(con, statement = paste("SELECT MAX(recID) FROM log WHERE msgv1 = 'WAE' AND sysID = '79cf6c22-dcc6-11e5-8e77-00113217113f'"));
recID <- fetch(query)

queryStatement <- paste("SELECT logID FROM log WHERE recID = '", recID, "'", ssep = "")
query <- dbSendQuery(con, statement = queryStatement);
maxLogID <- fetch(query)

# Download Sensor Data ----------------------------------------------------
queryStatement <- paste("SELECT * FROM log WHERE logID ='", maxLogID, "'", sep = "" )
query <- dbSendQuery(con, statement = queryStatement)
#maxMsgID <- fetch(query, n = -1)
weatherData <- fetch(query)

dbDisconnect(con)

weatherData <- cbind(weatherData[,4], weatherData[,5])
weatherData <- (weatherData)
rownames(weatherData) <- weatherData[,1]
weatherData <- weatherData[,2]
#weatherData <- t(weatherData)

# 1. Temperature
# 2. Pressure
# 3. Wind
# 4. Rain
# 5. Humidity
weatherData <- rbind(weatherData[1], weatherData[2], weatherData[4], weatherData[5], weatherData[3])
rownames(weatherData) <- c("Temperature", "Pressure", "Wind", "Rain", "Humidity")
weatherData <- t(weatherData)
return(weatherData)

}