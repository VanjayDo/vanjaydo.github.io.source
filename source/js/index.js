var inputReady = true;
var input = $('.404-input');
input.focus();
$('.container').on('click', function (e) {
    input.focus();
});

input.on('keyup', function (e) {
    $('.new-output').text(input.val());
    // console.log(inputReady);
});

$('.four-oh-four-form').on('submit', function (e) {
    e.preventDefault();
    var val=$('.404-input').val().toLowerCase();
    var href;
    if (val === 'back') {
        showKittens();
    } 
    else if(val === 'game'){
        window.location.href="game.html";
    }
    else {
        resetForm();
    }
});

function resetForm(withKittens) {
    var message = "Sorry that command is not recognized."
    var input = $('.404-input');

    $('.new-output').removeClass('new-output');
    input.val('');
    $('.terminal').append('<p class="prompt">' + message + '</p><p class="prompt output new-output"></p>');

    $('.new-output').velocity(
        'scroll'
    ), {duration: 100}
}

function showKittens() {
    var parent = document.body;
    var part1 = document.getElementById("part1");
    parent.removeChild(part1);
    document.styleSheets[0].insertRule('body:before{content:""}',21);
    document.styleSheets[0].insertRule('body:after{content:""}',22);
    if(history.length>2)
    {
        history.back();
    }else{
        window.location.href="http://blog.safeandsound.cn";
    }
}

function textEffect(line) {
    var alpha = [';', '.', ',', ':', ';', '~', '`'];
    var animationSpeed = 10;
    var index = 0;
    var string = line.text();
    var splitString = string.split("");
    var copyString = splitString.slice(0);

    var emptyString = copyString.map(function (el) {
        return [alpha[Math.floor(Math.random() * (alpha.length))], index++];
    })

    emptyString = shuffle(emptyString);

    $.each(copyString, function (i, el) {
        var newChar = emptyString[i];
        toUnderscore(copyString, line, newChar);

        setTimeout(function () {
            fromUnderscore(copyString, splitString, newChar, line);
        }, i * animationSpeed);
    })
}

function toUnderscore(copyString, line, newChar) {
    copyString[newChar[1]] = newChar[0];
    line.text(copyString.join(''));
}

function fromUnderscore(copyString, splitString, newChar, line) {
    copyString[newChar[1]] = splitString[newChar[1]];
    line.text(copyString.join(""));
}


function shuffle(o) {
    for (var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};