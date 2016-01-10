# EDA - plot1.R

# Download and extract zip file and read all data in the innter .txt file, with ; as separator and ? designating missing values 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
all <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, stringsAsFactors = FALSE, sep=";", na.strings = "?", nrows = 2075059)
unlink(temp)

# Inspect all data 
names(all)
head(all)
str(all)

# Subset only relevant data and reinspect - 2007-02-01 and 2007-02-02
dates <- as.Date(c("2007-02-01", "2007-02-02"))
all$Date <- as.Date(all$Date, format = "%d/%m/%Y")
data <- all[all$Date %in% dates,]

# Reinspect data
str(data)
dim(data)
head(data)
tail(data)
summary(data$Global_active_power)

# Plot 1 - Histogram of Global_active_power
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
