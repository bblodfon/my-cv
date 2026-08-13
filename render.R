library(rmarkdown)
library(pagedown)
library(servr)

rmarkdown::render(
  input = "cv.Rmd",
  output_file = "cv.html",
  output_format = pagedown::html_resume(
    self_contained = FALSE,
    css = c("css/resume.css", "academicons-1.9.1/css/academicons.css")
  )
)

# view the resume locally
servr::httd(dir = ".", port = 12345)
utils::browseURL("http://localhost:12345/cv.html")
