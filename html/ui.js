var warenkorb = []

$(document).ready(function() {

    window.addEventListener('message', function(event) {

        if (event.data.zeigehud == true) {

            $('body').show();
            setvalue({ type: 'money', value: event.data.money });
        };

        if (event.data.zeigehud == false) {

            $('body').hide();
            setvalue({ type: 'money', value: 0 });
        };

        if (event.data.money != null) {
            setvalue({ type: 'money', value: event.data.money });
        };

        /*		if (event.data.money > 100000) {
                    var elements = document.getElementsByClassName('text');

                    for (var i = 0; i < elements.length; i++) {
                      var element = elements[i];
                      element.style.fontSize = "1.7vw";
                    }
                };*/

        if (event.data.money > 1000000) {
            var elements = document.getElementsByClassName('text');

            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                element.style.fontSize = "0.8vw";
            }
        };

        if (event.data.money > 9000000) {
            var elements = document.getElementsByClassName('text');

            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                element.style.fontSize = "0.8vw";
            }
        };

        if (event.data.money < 1000001) {
            var elements = document.getElementsByClassName('text');

            for (var i = 0; i < elements.length; i++) {
                var element = elements[i];
                element.style.fontSize = "0.8vw";
            }
        };

        if (event.data.funk != 0000) {
            document.getElementById("icon1").innerHTML = '<img src="funk.png"/>'
        };
        if (event.data.muted == true) {
            document.getElementById("icon2").innerHTML = '<img src="mute.png"/>'
        };
        if (event.data.funk == 0000) {
            document.getElementById("icon1").innerHTML = '<img src="funkaus.png"/>'
        };

        if (event.data.voice == 3.5 && event.data.muted == false) {
            document.getElementById("icon2").innerHTML = '<img src="speaker1.png"/>'
        };
        if (event.data.voice == 8 && event.data.muted == false) {
            document.getElementById("icon2").innerHTML = '<img src="speaker2.png"/>'
        };
        if (event.data.voice == 15 && event.data.muted == false) {
            document.getElementById("icon2").innerHTML = '<img src="speaker3.png"/>'
        };
    });
});


function setvalue(data) {
    switch (data.type) {
        case 'money':
            $('#' + data.type).text(data.value);
            break;
    }
}

Date.prototype.timeNow = function() {
    return ((this.getHours() < 10) ? "0" : "") + this.getHours() + ":" + ((this.getMinutes() < 10) ? "0" : "") + this.getMinutes() + ":" + ((this.getSeconds() < 10) ? "0" : "") + this.getSeconds();
}
Date.prototype.today = function() {
    return ((this.getDate() < 10) ? "0" : "") + this.getDate() + "." + (((this.getMonth() + 1) < 10) ? "0" : "") + (this.getMonth() + 1) + "." + this.getFullYear();
}

$(document).ready(function() {
    $('#Clock').hide();
    setInterval(setTime, 1000)
});

function setTime() {
    var currentdate = new Date();
    $("#time").text(currentdate.today() + " - " + currentdate.timeNow());
    $('#Clock').show();
}