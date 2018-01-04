
WebGrab = require('./WebGrab');
FeedGrab = require('./FeedGrab');
FileOrganiser  = require('./FileOrganiser');
module.exports =

    class App
        @organiser;
        @webGrab;
        @feedGrab;
        @fin = 0;
        @totalTasks=1;
        @urls;

        constructor:()->
            @webGrab = new WebGrab();
            @feedGrab = new FeedGrab();
            @organiser = new FileOrganiser();
            @fin=0;
            @urls =new Array();
        ##

        singleTask:(url,next) =>
            @feedGrab.getFirstItem(url,(item)=>
                if(item)
                    console.log("title = "+item.title);
                    console.log("item url= "+item.link);
                    fileName = @organiser.add(item.title,item.link);
                    console.log("new file:>"+fileName);
                    @webGrab.webToTextFile(item.link,fileName, =>
                       next();
                    );
                else
                    console.log("item is null");
                    next();
            );
            console.log("....");
        ##

        synchronizer:()=>
            console.log("finished=="+@fin+ " totaltasks ="+@totalTasks);
            @fin++;
            if(@fin>@totalTasks)
                console.log("------------------_COMPLETE_-----------------_");
                @organiser.finish();
            else
                url = @urls[@fin];
                console.log("start next task for >>"+url+"<<");
                @singleTask(url,@synchronizer)

        main:()->
            @webGrab = new WebGrab();
            @feedGrab = new FeedGrab();
            @organiser = new FileOrganiser();
            @organiser.prepare();
            ##TODO: get urls from config file.
            @urls =new Array();
            @urls.push('https://nodejs.org/en/feed/blog.xml');
            @urls.push('http://blog.fefe.de/rss.xml');

            @fin = 0;
            @totalTasks=@urls.length-1;

            @singleTask(@urls[0],@synchronizer);



app = new App();
app.main();
#

