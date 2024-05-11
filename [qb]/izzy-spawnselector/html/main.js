let data = {
    left: 0,
    top: 0
}

$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data
        if(item.type == "addSpawn") {
            $('body').show()
            $('.location').remove()

            let div = `<div onclick="addSpawn()" class="location anim">
            <img class="location-icon" src="images/location.svg">
            </div>`


            $('body').append(div)
            $('.location').css('transition', "0s")

            $(document).mousemove(function(e) {
                $(".location").css({
                    left: e.pageX,
                    top: e.pageY
                });
                data = {
                    left: e.pageX,
                    top: e.pageY
                }
            });
        }
        if(item.type == "addLocation") {
            let div = `<div onclick="spawn(`+item.id+`)" class="location anim location_`+item.id+`">
            <img class="location-icon" src="images/location.svg">
            <div class="location-spawn">
                <p class="location-spawn-name">`+item.data.name+`</p>
            </div>
    
            <div class="location-desc">
                <p class="location-desc-title">LOCATION</p>
                <p class="location-desc-text">Lorem ipsum dolor sit amet, consectetur.</p>
            </div>
            </div>`

            $('body').append(div)

            $('.location_'+item.id).css('left', item.data.left+"%")
            $('.location_'+item.id).css('top', item.data.top+"%")
        }
        if(item.type == "open") {
            $('body').show()
        }
        if(item.type == "update") {
            $('.picture').attr('src', item.image)
            $('.profile-cash').text(formatBalance(item.cash))
            $('.profile-name').html('Hello, <span class="profile-name-2">'+item.name+'</span>')
        }
    })
})

function spawn(id) {
    $.post(`https://${GetParentResourceName()}/spawn`, JSON.stringify({
        id: id,
    }));
    $('body').hide()
}

function addSpawn() {
    $("body").hide()
    $.post(`https://${GetParentResourceName()}/addSpawn`, JSON.stringify({
        left: data.left/screen.width*100,
        top: data.top/screen.height*100
    })); 
}

function updateSpeedText(speed) {
    speed = speed.toString()

    if (speed.length >= 3) {
        $('.car-speed-text-1').addClass('active')
        $('.car-speed-text-1').html(speed[0]+"<span class='car-speed-text-2'>"+speed[1]+speed[2]+"</span>")
    }
    else if(speed.length >= 2) {
        $('.car-speed-text-1').removeClass('active')
        $('.car-speed-text-1').html("0<span class='car-speed-text-2'>"+speed[0]+speed[1]+"</span>")
    }
    else {
        $('.car-speed-text-1').removeClass('active')
        $('.car-speed-text-1').html("00<span class='car-speed-text-2'>"+speed[0]+"</span>")
    }
}

function setIcon(element, status) {
    if(status) {
        $('.'+element).css('opacity', "1")
    }
    else {
        $('.'+element).css('opacity', "0.5")
    }
}

function setProgress(element, value, max) {
    $('.'+element).css('width', value/max*100+"%")
}

function updateWeapon(name, label, clip, ammo) {
    if(name) {
        $('.weapon').show()
        $('.weapon-name').text(label)
        $('.weapon-image').attr('src', 'images/weapon/'+name+".png")
    
        $('.weapon-ammo-1').text(clip)
        $('.weapon-ammo-2').text(ammo)
    }
    else {
        $('.weapon').hide()
    }
}

function formatBalance(balance) {
    var formatter = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
      });
   return formatter.format(balance)   
}

var notifyId = 1

function notify(status, title, text, time) {
    let id = notifyId
    let div = `<div class="notify notify-`+id+`">
    <img class="notify-background" src="images/notify.svg">
    
    `+getNotifyImage(status)+`

    <p class="notify-title `+status+`-info">`+title+`</p>
    <p class="notify-text">`+text+`</p>
        
    </div>`
    $('body').append(div)
    setTimeout(function(){
        $('.notify-'+id).css('left', '2.4vw')
      }, 1);

      setTimeout(function(){
        $('.notify-'+id).css('left', '-19.3vw')
      }, time);

      setTimeout(function(){
        $('.notify-'+id).remove()
      }, time+500);
      notifyId+=1
}

function getNotifyImage(status) {
    let notify = undefined
    if(status == "announcement") {
        notify = `<svg class="notify-icon announcement-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="20" viewBox="0 0 24 20" fill="none">
        <path d="M1.89507 6.13179L21.3702 0.158502C21.6338 0.081621 21.9117 0.0671236 22.1818 0.116157C22.452 0.16519 22.707 0.276408 22.9268 0.441017C23.1466 0.605625 23.325 0.819107 23.448 1.06458C23.5711 1.31005 23.6353 1.58078 23.6356 1.85536V17.7841C23.6356 18.2535 23.4492 18.7037 23.1172 19.0356C22.7853 19.3675 22.3352 19.554 21.8658 19.554C21.6965 19.5541 21.5281 19.5298 21.3658 19.4821L12.1315 16.6481V17.7841C12.1315 18.2535 11.945 18.7037 11.6131 19.0356C11.2812 19.3675 10.831 19.554 10.3616 19.554H6.82192C6.35252 19.554 5.90235 19.3675 5.57044 19.0356C5.23853 18.7037 5.05206 18.2535 5.05206 17.7841V14.4767L1.89507 13.5088C1.52969 13.399 1.20925 13.1747 0.981014 12.869C0.752775 12.5633 0.628811 12.1924 0.627401 11.8108V7.82865C0.629047 7.44732 0.75312 7.07661 0.981342 6.77112C1.20956 6.46563 1.52987 6.24152 1.89507 6.13179ZM6.82192 17.7841H10.3616V16.105L6.82192 15.0187V17.7841ZM2.39726 11.8108H2.40943L10.3616 14.2533V5.38513L2.40943 7.82865H2.39726V11.8108Z" fill="#EC811F"/>
        </svg>`
    }
    else if(status == "info") {
        notify = `<svg class="notify-icon notify-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
        <path d="M12.0164 0.409912C9.74114 0.409912 7.51694 1.08462 5.6251 2.3487C3.73326 3.61279 2.25875 5.40949 1.38803 7.51159C0.517314 9.61369 0.289494 11.9268 0.733382 14.1584C1.17727 16.3899 2.27293 18.4398 3.88181 20.0487C5.49069 21.6575 7.54052 22.7532 9.7721 23.1971C12.0037 23.641 14.3168 23.4131 16.4189 22.5424C18.521 21.6717 20.3177 20.1972 21.5818 18.3054C22.8458 16.4135 23.5205 14.1893 23.5205 11.914C23.5173 8.86393 22.3043 5.93969 20.1475 3.78294C17.9908 1.6262 15.0665 0.413133 12.0164 0.409912ZM11.574 5.7195C11.8365 5.7195 12.0931 5.79735 12.3114 5.94321C12.5297 6.08906 12.6999 6.29637 12.8003 6.53892C12.9008 6.78147 12.9271 7.04837 12.8759 7.30586C12.8246 7.56335 12.6982 7.79987 12.5126 7.98551C12.3269 8.17115 12.0904 8.29757 11.8329 8.34879C11.5754 8.40001 11.3086 8.37372 11.066 8.27325C10.8235 8.17278 10.6161 8.00265 10.4703 7.78436C10.3244 7.56607 10.2466 7.30943 10.2466 7.0469C10.2466 6.69485 10.3864 6.35722 10.6354 6.10829C10.8843 5.85935 11.2219 5.7195 11.574 5.7195ZM12.9014 18.1085C12.432 18.1085 11.9818 17.9221 11.6499 17.5902C11.318 17.2582 11.1315 16.8081 11.1315 16.3387V11.914C10.8968 11.914 10.6717 11.8208 10.5058 11.6548C10.3398 11.4889 10.2466 11.2638 10.2466 11.0291C10.2466 10.7944 10.3398 10.5693 10.5058 10.4033C10.6717 10.2374 10.8968 10.1442 11.1315 10.1442C11.6009 10.1442 12.0511 10.3306 12.383 10.6625C12.7149 10.9945 12.9014 11.4446 12.9014 11.914V16.3387C13.1361 16.3387 13.3612 16.4319 13.5271 16.5979C13.6931 16.7638 13.7863 16.9889 13.7863 17.2236C13.7863 17.4583 13.6931 17.6834 13.5271 17.8493C13.3612 18.0153 13.1361 18.1085 12.9014 18.1085Z" fill="#1FE0EC"/>
        </svg>`
    }
    else if(status == "success") {
        notify = `<svg class="notify-icon success-icon" xmlns="http://www.w3.org/2000/svg" width="29" height="26" viewBox="0 0 29 26" fill="none">
        <path d="M27.5547 8.58115C27.2788 8.26853 26.9396 8.01818 26.5595 7.84673C26.1795 7.67528 25.7673 7.58666 25.3503 7.58674H18.4923V5.62732C18.4923 4.32814 17.9763 3.08217 17.0576 2.16351C16.1389 1.24486 14.893 0.72876 13.5938 0.72876C13.4118 0.72863 13.2333 0.779204 13.0785 0.874812C12.9236 0.97042 12.7984 1.10728 12.7169 1.27005L8.09026 10.5259H2.81697C2.2973 10.5259 1.79891 10.7323 1.43145 11.0998C1.06398 11.4672 0.857544 11.9656 0.857544 12.4853V23.2621C0.857544 23.7818 1.06398 24.2802 1.43145 24.6476C1.79891 25.0151 2.2973 25.2215 2.81697 25.2215H23.8808C24.5968 25.2218 25.2883 24.9606 25.8254 24.4871C26.3626 24.0136 26.7083 23.3602 26.7979 22.6498L28.2674 10.8933C28.3195 10.4794 28.2829 10.0591 28.16 9.66046C28.0371 9.26181 27.8308 8.89388 27.5547 8.58115ZM2.81697 12.4853H7.71552V23.2621H2.81697V12.4853Z" fill="#29BD73"/>
        </svg>`
    }
    else if(status == "error") {
        notify = `<svg class="notify-icon error-icon" xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none">
        <path d="M15.709 0.605347C7.16227 0.605347 0.197693 7.56992 0.197693 16.1166C0.197693 24.6634 7.16227 31.6279 15.709 31.6279C24.2557 31.6279 31.2203 24.6634 31.2203 16.1166C31.2203 7.56992 24.2557 0.605347 15.709 0.605347ZM14.5456 9.91213C14.5456 9.27616 15.073 8.74878 15.709 8.74878C16.345 8.74878 16.8723 9.27616 16.8723 9.91213V17.6678C16.8723 18.3037 16.345 18.8311 15.709 18.8311C15.073 18.8311 14.5456 18.3037 14.5456 17.6678V9.91213ZM17.136 22.9106C17.0585 23.1122 16.9499 23.2674 16.8103 23.4225C16.6552 23.5621 16.4846 23.6706 16.2984 23.7482C16.1123 23.8258 15.9106 23.8723 15.709 23.8723C15.5073 23.8723 15.3057 23.8258 15.1196 23.7482C14.9334 23.6706 14.7628 23.5621 14.6077 23.4225C14.4681 23.2674 14.3595 23.1122 14.282 22.9106C14.2023 22.7242 14.1601 22.5239 14.1579 22.3212C14.1579 22.1195 14.2044 21.9179 14.282 21.7317C14.3595 21.5456 14.4681 21.375 14.6077 21.2199C14.7628 21.0803 14.9334 20.9717 15.1196 20.8941C15.4972 20.739 15.9208 20.739 16.2984 20.8941C16.4846 20.9717 16.6552 21.0803 16.8103 21.2199C16.9499 21.375 17.0585 21.5456 17.136 21.7317C17.2136 21.9179 17.2601 22.1195 17.2601 22.3212C17.2601 22.5228 17.2136 22.7245 17.136 22.9106Z" fill="#BD2929"/>
        </svg>`
    }

    return notify
}

function formatBalance(balance) {
    var formatter = new Intl.NumberFormat('en-EN', {
        style: 'currency',
        currency: 'USD',
      });
   return formatter.format(balance)   
}