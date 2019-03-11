let languageToggler = document.getElementById('language-Toggler');
if(languageToggler) languageToggler.addEventListener('click', languageTogglerCliked);
let allLabels = document.getElementsByClassName('language-label');
let scheduleimgs = document.getElementById('schedule-img');

function languageTogglerCliked(event)
{
    console.log("Pressed language Toggler");
    
    let language = 'EN';

    if(event.target.getAttribute('alt') == 'EN')
    {
        languageToggler.innerHTML = '<img src="../images/language/Portuguese.svg.png" alt="PT" witdh="45" height="30">';
        if(scheduleimgs) scheduleimgs.innerHTML = '<img class="schedule-img" src="../images/schedule/op1-en.png" alt="schedule">';
    }
    else if (event.target.getAttribute('alt') == 'PT')
    {
        languageToggler.innerHTML = '<img src="../images/language/England.png" alt="EN" witdh="45" height="30">';
        if(scheduleimgs) scheduleimgs.innerHTML = '<img class="schedule-img" src="../images/schedule/op1-pt.png" alt="schedule">';
        language = 'PT';
    }

    let requests = [];
    
    for(let i = 0; i < allLabels.length; i++)
    {
        messageId = allLabels[i].getAttribute('msg');

        requests[i] = new XMLHttpRequest();
        requests[i].open('POST', '../database/apiMessages.php', true);
        requests[i].setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');  
        requests[i].addEventListener('load', function() {
            allLabels[i].innerHTML = this.responseText;
        });
        requests[i].send(encodeForAjax({messageId: messageId, language: language}));
    }   
    event.preventDefault();
}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&'); 
}

////////////////////////////////////////////////////////////////////////////////////////////////

let dateString = "2019-03-16 10:00:00";
let countDownDate = new Date(dateString.replace(' ','T')).getTime();

let counter = setInterval(function() {

    let values = document.getElementsByClassName("counter-value");

    let now = new Date().getTime();
    let distance = countDownDate - now;
  
    let days = Math.floor(distance / (1000 * 60 * 60 * 24));
    let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((distance % (1000 * 60)) / 1000);
  
    if(values[0]) 
    {
        values[0].innerHTML = days;
        values[1].innerHTML = hours;
        values[2].innerHTML = minutes;
        values[3].innerHTML = seconds;
    }
  
    if (distance < 0) {
        clearInterval(counter);
        document.getElementById("counter").innerHTML = '<div class="col-sm-12 counter-Txt">Countdown has ended</div>';
    }
}, 1000);

////////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function() {
    // Transition effect for navbar
    $(window).scroll(function() {
        // checks if window is scrolled more than 500px, adds/removes solid class
        if(window.location.pathname.includes('/pages/initialPage.php'))
        {
            if($(this).scrollTop() > $('#countdown').offset().top - 150)
            {
                $('nav.navbar').addClass('solid');
                $('div.dropdown-menu').addClass('solid');
            }
            else 
            {
                $('nav.navbar').removeClass('solid');
                $('div.dropdown-menu').removeClass('solid');
            }
        }
        else if(window.location.pathname.includes('/pages/ebecInfo.php'))
        {
            if($(this).scrollTop() == 0)
            {
                $('nav.navbar').removeClass('solid');
                $('div.dropdown-menu').removeClass('solid');
            }
            else
            {
                $('nav.navbar').addClass('solid');
                $('div.dropdown-menu').addClass('solid');
            }
            
        }
    });

    if(window.location.pathname.includes('/pages/initialPage.php'))
    {
        var isSafari = navigator.vendor && navigator.vendor.indexOf('Apple') > -1 && navigator.userAgent && navigator.userAgent.indexOf('CriOS') == -1 && navigator.userAgent.indexOf('FxiOS') == -1;
        var isFirefox = (typeof InstallTrigger !== 'undefined');
        if($(this).scrollTop() > $('#countdown').offset().top - 150)
        {
            $('nav.navbar').addClass('solid');
            $('div.dropdown-menu').addClass('solid');
        }
        else 
        {
            $('nav.navbar').removeClass('solid');
            $('div.dropdown-menu').removeClass('solid');
        }

        if(window.innerWidth <= 991)
        {
            $('h2.pc-mob').removeClass('text-right');
            $('p.pc-mob').removeClass('text-right');

            $('h2.pc-mob').addClass('text-left');
            $('p.pc-mob').addClass('text-left');
        }
        if(isSafari===true || isFirefox===true)
        {
            document.getElementById('browser-Mariana').style.display = "none";
            document.getElementById('browser-Ines').style.display = "none";
            document.getElementById('browser-Jorge').style.display = "none";
            document.getElementById('browser-Filipa').style.display = "none";
            document.getElementById('browser-Andre').style.display = "none";
            document.getElementById('browser-Marta').style.display = "none";
            document.getElementById('browser-Patricia').style.display = "none";
        }
        else
        {
            document.getElementById('safari-Mariana').style.display = "none";
            document.getElementById('safari-Ines').style.display = "none";
            document.getElementById('safari-Jorge').style.display = "none";
            document.getElementById('safari-Filipa').style.display = "none";
            document.getElementById('safari-Andre').style.display = "none";
            document.getElementById('safari-Marta').style.display = "none";
            document.getElementById('safari-Patricia').style.display = "none";
        }
    }
    else if(window.location.pathname.includes('/pages/ebecInfo.php'))
    {
        if($(this).scrollTop() == 0)
        {
            $('nav.navbar').removeClass('solid');
            $('div.dropdown-menu').removeClass('solid');
        }

        if(window.innerWidth > 1220)
        {
            document.getElementById('modalities-Mobile').style.display = "none";
        }
        else
        {
            document.getElementById('modalities-PC').style.display = "none";
        }

        if(window.innerWidth > 1020)       
        {
            document.getElementById('EBEC-label-Mobile').style.display = "none";
        }
        else
        {
            document.getElementById('EBEC-label-PC').style.display = "none"; 
        }
    }

    $('#registration').modal('show');
});

let burgerIcon = document.getElementsByClassName("navbar-toggler");
if(burgerIcon) burgerIcon[0].addEventListener('click', burgerIconToggler);

function burgerIconToggler()
{
    if(window.location.pathname.includes('/pages/initialPage.php'))
    {
        if($(window).scrollTop() <= $('#countdown').offset().top - 30)
        {
            if($('nav.navbar')[0].classList[4])
                $('nav.navbar').removeClass('solid');
            else
                $('nav.navbar').addClass('solid');
        }
    }
    else if(window.location.pathname.includes('/pages/ebecInfo.php'))
    {
        if($(window).scrollTop() == 0)
        {
            if($('nav.navbar')[0].classList[4])
                $('nav.navbar').removeClass('solid');
            else
                $('nav.navbar').addClass('solid');
        }
    }
}