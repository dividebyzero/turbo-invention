fs = require('fs');

module.exports =

    class FileOrganiser

        @_topics = new Array();
        @_path = "";

        prepare:()->
            ##TODO: get main path from config file.
            @_path="./feeder_"+new Date().getTime();
            @_topics = new Array();
            fs.mkdirSync(@_path);
        ##

        add:(title,url)->
            fileName = @_path+"/"+new Date().getTime()+".txt";
            topic = {
                'title':title,
                'url': url,
                'file': fileName
            };

            @_topics.push(topic);
            return fileName;
        ##
        finish:()->
            indexData = JSON.stringify(@_topics);
            console.log("indexData= "+indexData);
            fs.writeFile(@_path+'/index.json',indexData);
##

