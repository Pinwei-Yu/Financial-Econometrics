#爬下所有標題及該標題之簡短連結
install.packages("rvest")
install.packages("RSelenium")
library(rvest)
library(RSelenium)
read_html("https://fred.stlouisfed.org/categories/33054")
doc <-read_html("https://fred.stlouisfed.org/categories/33054")
doc %>%html_nodes(".pager-series-title-gtm")
doc %>%html_nodes(".pager-series-title-gtm") %>% html_attr("href")
doc %>%html_nodes(".pager-series-title-gtm") %>% html_text()
titles <- doc %>%html_nodes(".pager-series-title-gtm") %>% html_text()
titles <- tolower(titles)
urls <- doc %>%html_nodes(".pager-series-title-gtm") %>% html_attr("href")
Tables <- data.frame(Title=titles,Url=urls)

#篩選出含有personal inconme 之標題並給予完整網址(urls2)
grep("personal income",titles)
target <-grep("personal income",titles)
urls1 <- urls[target]
urls2 <- c()
for(m in urls1){
  sticker <- paste("https://fred.stlouisfed.org",m,sep = "")
  urls2 <- c(urls2,sticker)
}
#模擬chromeserver下載urls2中的csv檔案

remDr <- remoteDriver(browserName = "chrome")
remDr$open()
  for (n in urls2){
    remDr$navigate(n)
    btn1 <- remDr$findElement(using = "xpath",  '//*[@id="download-button"]')
    remDr$mouseMoveToLocation(webElement = btn1)
    remDr$click()
    Sys.sleep(2)
    btn2 <- remDr$findElement(using = 'xpath',"//*[@id='download-data-csv']")
    remDr$mouseMoveToLocation(webElement = btn2)
    remDr$click()
  }
