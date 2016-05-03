library(base64enc)
library(base64)

#download the file directly from the sync
##wget_string="wget -x -O example.html --load-cookies cookies.txt http://sync.cloudwick.com/training/track/5673b98ad9c6e40696000002/topic/56762f9cd9c6e471f6000002/subtopic/56b2467bd9c6e49e69000008/ss"
##system(wget_string,intern=TRUE)

#list of files in the folder
list.files()
#takes the files from the specified folder
file = list.files(pattern = "\\.htm$") 
length(file)
# paste the link here
for (p in 1 : length(file))
{
  #decoding starts here
  dir.create(sprintf("output/imagefiles_%03i",p), showWarnings = TRUE, recursive = FALSE, mode = "0777")
  thepage = readLines(file[p])
  #startline = grep('class="slide-0',thepage)
  #endline = grep('</ul>',thepage)
  #array of lines which has the image keyfiles
  lineswithpng=grep('data:image/png;base64',thepage)
  
  base64_code = c()
  #code needed for decoding the file
  for(i in 1 : length(lineswithpng))
  {
    x = lineswithpng[i]
    linefirst=regexpr("data:image/png;base64,",thepage[x])
    linelast=regexpr('data-src=\"holder.js',thepage[x])
    base64_code[i] = substr(thepage[x],linefirst+22,linelast-3)
    write(base64_code[i],'temp.base64')
   decode('temp.base64',output=sprintf("output/imagefiles_%03i/%03i_%03i.png",p,p,i))
  }
  
 system(sprintf("convert output/imagefiles_%03i/*.png output/imagefiles_%03i.pdf",p,p))
 #remove the directories which are created
 unlink(sprintf("output/imagefiles_%03i",p,p), recursive = TRUE, force = TRUE)
}



