# EDA - plot3.R

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

# Create a datetime TS variable for X axis
data$TS <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Reinspect data
str(data)
dim(data)
head(data)
tail(data)

# Plot 3 - Sub meetering data for the given TS 
# Note: I'm color blind and used the colors as far as I can see them...

colors = c("black", "red", "blue")
png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(data, {
    plot(TS, Sub_metering_1, type = "l", col = colors[1], xlab = "", ylab = "Energy sub meetering")
    lines(TS, Sub_metering_2, type = "l", col = colors[2])
    lines(TS, Sub_metering_3, type = "l", col = colors[3])
})
legend("topright", lwd = 1, c("Sub_metering_1", "Sub_metering_3", "Sub_metering_3"), col = colors)
dev.off()
