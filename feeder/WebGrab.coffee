htmlparser2 = require("htmlparser2");
httpRequest = require('request');
fs = require('fs');

module.exports =

    class WebGrab

        webToTextFile: (url, textfile,completeHandler)->
            bigText = "";
            ##TODO: grab only text, remove script tags & inline styles.
            parser = new htmlparser2.Parser({
                ontext: (text)->
                    #console.log("text par "+text);
                    bigText += text;

                onend: ()->
                    console.log("webgrab fin");
                    fs.writeFile(textfile,bigText,(err)=>
                        completeHandler('');
                    );


            },{"decodeEntities:true"});
            httpRequest(url,(err,response,body)=>
                if(err)
                    console.log("ERROR"+err);
                    return;
                parser.write(body);
                parser.end();
                #console.log("bigtext\n"+bigText);

            );
##
