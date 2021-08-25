# QQ to Apple Music Playlist


I came to find out that I can no longer listen to QQ music since I moved here to Singapore. That is definitely something I need to take care of since we all need some of the medoly to boost our work. After a quick seach, I have found this perticular approach that can help with that. What's more, new Apple music subscriber would have a long period of 3 months free service. Yay!! After that period, if you are a mainlander university student, you can enjoy the service with only 5 CNY. 



With all that being said, let's get started on the transfer. The steps are not the complicated and it only takes few minutes to finish that compared with the time-consuming and repeatitive copy from QQ music and pasting in Apple.



1. As a first step, click this link [here](https://c.y.qq.com/v8/fcg-bin/fcg_v8_playlist_cp.fcg) to open up a new blank tab.
2. Next, right click on the blank tab and select `Inspect` from the poppped-up window.
3. Then find `Console` on the table and paste following code there, do not hit `Enter` just yet,

```html
(function () {
    var script = document.createElement("SCRIPT");
    script.src = 'https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js';
    script.type = 'text/javascript';
    document.getElementsByTagName("head")[0].appendChild(script);

    var checkReady = function (callback) {
        if (window.jQuery) {
            callback(jQuery);
        } else {
            window.setTimeout(function () { checkReady(callback); }, 100);
        }
    };

    checkReady(function ($) {
        var text="";
        $.ajax({

            url: "https://c.y.qq.com/v8/fcg-bin/fcg_v8_playlist_cp.fcg?id=

[Please place with your playlist ID]

&cv=60102&ct=19&newsong=1&tpl=wk&g_tk=5381&loginUin=0&hostUin=0&format=json&inCharset=GB2312&outCharset=utf-8&notice=0&platform=jqspaframe.json&needNewCode=0",
            async:false,
            dataType:"json",
            success:function(data){
                var songlist = data.data.cdlist[0].songlist;
                for(var i=0;i < songlist.length; i++){
                    var tmp = songlist[i];
                    text += tmp.singer[0].name +" - "+ tmp.name+"<br>";
                }
            }
        });

        $('body').empty();
        $('body').append("<div>"+text+"</div>");
    });

})();
```

4. Navigate your web QQ music to the desired playlist page that you would like to transfer to Apple. Find the play list ID from the url like,

```html
https://y.qq.com/n/yqq/playlist/
[your play list here]
.html#stat=y_new.profile.create_playlist.love.click&dirid=201
```

5. Plug the playlist ID to the console and press `Enter`, then the blank page with be filled with a list full of songs parsed from your playlist.

6. Full copy the text on the page and go to this [tunemymusic](https://www.tunemymusic.com/) website and hit `Let's start` , choose the source as from `text`, paste in text, choose target as Apple Music (you might need to log in). 

And, you are done! Open Apple Music and enjoy!
