library(RWordPress)
options(WordpressLogin = c(userName = 'PassWord'),
        WordpressURL = 'http://tapirologist.wordpress.com/xmlrpc.php')
library(knitr)
knit2wp('sib_map2.Rmd', title = 'Biodiversity by Colombian institutions',
        shortcode = TRUE,
        encoding = "windows-1252")# not utf-8


#How to upload images? There are a few possibilities. One is to upload images to Imgur, 
#and another is to save images to your Dropbox folder, e.g.

opts_knit$set(base.url = 'https://dl.dropboxusercontent.com/u/18404457/wp/wordpress/',
              base.dir = 'C:\\Users\\Diego\\Dropbox\\Public\\wp\\wordpress')

opts_chunk$set(out.lines = 4)
