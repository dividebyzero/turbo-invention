
httpRequest = require('request');
FeedMe = require('feedme');

module.exports =

    class FeedGrab

        getFirstItem: (url, itemHandler)->
            @getItems(url,(items)=>
                if(items && items.length>0 && itemHandler)
                    itemHandler(items[0]);
                else
                    itemHandler(null);
            );

        getItems: (url, itemHandler)->
            bigText = "";
            items= new Array();
            parser = new FeedMe();
            parser.on('item',(item) =>
                    console.log("item="+item.title);
                    items.push(item);
            );
            parser.on('end',()=>
                console.log("feed end");
                console.log("items total #"+items.length);
                if(itemHandler)
                    itemHandler(items);
            );
            parser.on('error',(err)=>
                console.log("feed>>"+url+"<< ERROR: "+err);
            );
            console.log("consuming feed>>"+url+"<<");
            if(!url)
                console.log("ERROR NO URL");
                itemHandler(null);
                return;

            httpRequest(url,(err,response,body)=>
                if(err)
                    console.log("ERROR"+err);
                    itemHandler(null);
                    return;
                parser.write(body);
                parser.end();
            );
##
