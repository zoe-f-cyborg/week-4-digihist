### Excel
- I chose to use google spreadsheets
- I uploaded the .csv file to google drive, then clicked open in spreadsheet
- It was relatively easy to create the graph, and I played around with modifying the display ranges until it looked readable (the auto-generated graph was so zoomed out that the bars barely looked like they were different lengths at all)
[image]

### Rstudio
- Generating the graph for this project was also pretty easy— I think I have a sense how to actually design and display it (aka changing the y-axis and x-axis labels with `ylab` and `xlab`, changing the title with `main`), however I would have to pretty carefully retrace the steps here to import the data (or different data) correctly again. 
- I recognized some obvious things that needed correcting in the graph formula as it was given on the website— changing the `main` to `xlab` and the `xlab` to `ylab`. However, I was stumped as to what command to use to change “Edinbugh” to “Edinburgh.”
- I tried to create my own plot 
- I was quite onfused why when you `head(documents$Newspaper.Title)` it displays something different from the x-axis newspaper names when you `title <- table(documents$Newspaper.Title)` and `barplot(title)` 
[image to demonstrate]
- Opening up the additional pages which were linked at the end of this section on the website, I played around number of articles per year graph, turning it into a line graph instead of a bar one. I feel like this makes a lot more sense for this type of data visually. My mucking about also altered the distances between some of the year labels displayed on the x-axis, for reasons I don’t know
- I also made use of the `col` function, which I could see coming in very handy if I were to display multiple lines on a graph simultaneously. 
[2 images, the bar and the truqoise line graph]
- RETURN TO PLAY WITH THIS MORE ONCE YOU’VE FINISHED THE OTHER COMPONENTS

### Voyant
- This was slow going as my computer seemed to be a bit overloaded. I tried to familiarize myself with the “cdn” excel spreadsheet so that I could have a better understanding of what I was doing, but my computer couldn’t seem to handle the file as numbers kept stalling. 
- Although I would have liked to examine the original to make sure I was uploading the data properly (it wasn't working when I copy-pasted the url, so I had to upload from file, and wasn't entriely sure if the pre-reveal alterations using "options" were actually working. My file did generate something slightly different from the example one, but that may have just been randomizations of colour and placing by voyant. 
[image]
[my corpus](https://voyant-tools.org/?corpus=922e40b90dee8a99e30d7bd80fe3d05e)
In mucking around with the data, I created [this graph](https://voyant-tools.org/tool/Trends/?query=men*&query=man*&query=woman*&query=women*&mode=document&corpus=922e40b90dee8a99e30d7bd80fe3d05e) comparing frequency of men/man and women/woman: 

