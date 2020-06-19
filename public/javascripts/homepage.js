
$(function(){

    var movieInterval = null;

    startMovieImages();
    
    //start movie images
    function startMovieImages(){
        var movie_nodes = $(".movie-img-list").children();
        var movie_pic_len = movie_nodes.length;
        var cur_movie_pic = 0;
        clearInterval(movieInterval);
        movieInterval = setInterval(function(){
            //console.log("开始执行切换")
            movie_nodes.eq(cur_movie_pic).fadeOut(1000, function(){
                //console.log("开始执行退出回调")
                cur_movie_pic = (cur_movie_pic + 1)%movie_pic_len
                movie_nodes.eq(cur_movie_pic).fadeIn(1000, function(){
                //console.log("开始执行进入回调");
                });
            });
        }, 4000);
    }

})
