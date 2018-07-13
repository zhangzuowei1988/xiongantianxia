window.onload = function(){
    
    
    var imageArray = document.getElementsByTagName("img");
    for(var i=0; i < imageArray.length; i++)
    {
        var image = imageArray[i];
        image.index = i;
        image.onclick = function(){
            
            //        alert(imageArray[this.index].src);
            window.webkit.messageHandlers.openBigPicture.postMessage({methodName:"openBigPicture:",imageSrc:imageArray[this.index].src});
        }
    }
    
    
    var videoArray = document.getElementsByTagName("video");
    for(var i=0; i < videoArray.length; i++)
    {
        var myVideo = videoArray[i];
//        function videoPlay(){
//            window.webkit.messageHandlers.openVideoPlayer.postMessage({methodName:"openVideoPlayer:",videoSrc:myVideo.src});
//            
//        }
        
        myVideo.addEventListener('loadedmetadata',function(){
                                 
                               window.webkit.messageHandlers.openVideoPlayer.postMessage({methodName:"VideoLoadFinished",videoSrc:myVideo.src});   
                                 
                                 });
        
    }
    
    
//    var videoDiv = document.getElementsByClassName("button01")[0];
//    videoDiv.onclick = function(){
//        videoPlay();
//    }
    
    var subscriptDiv=document.getElementsByClassName("subscriptBtn")[0];
    
    subscriptDiv.onclick=function(){
        //alert("你好！");

  window.webkit.messageHandlers.subscriptPressed.postMessage({methodName:"subscriptBtnPressed"});
    }
    alert('感谢你的支持');
    
    
   
    
};

function replaceimage(imageUrl, imagePath) {
    
    var  element = document.getElementById(imageUrl)
    
    if (element.src.match("loading")) {
     
        element.src = imagePath
    }
    
};
function setSubscriptStatus() {
    
    var  element = document.getElementsByClassName("subscriptBtn")[0];
    
    
    if(element.innerHTML=="订阅"){
    element.innerHTML="已订阅";
    }else{
        element.innerHTML="订阅";
    }
    
    
};
// 获取网页高度
function getHtmlHeight() {
    
    return document.getElementById('top').offsetTop+10;
    //return document.body.offsetHeight;
     //return document.body.scrollHeight;
};

function reSetVideo(){
//    var videoContent = document.getElementsByTagName('video');
//    for (var i=0;i<videoContent.length;i++){
//        var video=videoContent[i];
//        video.setAttribute("preload", 'none');
//    }
   
}

// 设置字体大小
function setFontSize(size) {
    var content = document.getElementById('container');
    content.style.fontSize = size + "px";
};
//设置 背景字体颜色颜色
function setFontColor(color) {
    var content = document.getElementById('container');
   // background-color:rgba(0,0,0,0.0);
    content.style.color=color;
};
function hello(){
    alert("你好！");
}

