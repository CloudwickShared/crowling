library(base64enc)
library(base64)


#list of files in the folder
list.files()

file = list.files(pattern = "\\.htm$") 
length(file)
# paste the link here
for (p in 1 : length(file))
{
  
  
}

#decoding starts here
  
thepage = readLines('1. Big data intro.htm')
#startline = grep('class="slide-0',thepage)
#endline = grep('</ul>',thepage)
#array of lines which has the image keyfiles
lineswithpng=grep('data:image/png;base64',thepage)
base64_code = c()
for(i in 1 : length(lineswithpng))
{
  x = lineswithpng[i]
  linefirst=regexpr("data:image/png;base64,",thepage[x])
  linelast=regexpr('data-src=\"holder.js',thepage[x])
  base64_code[i] = substr(thepage[x],linefirst+22,linelast-3)
  write(base64_code[i],'temp.base64')
  decode('temp.base64',output=sprintf("output/%03i_%03i.png",p,i))
}
length(base64_code)
base64_code[1]
#code needed for decoding the file



#image merger to pdf


