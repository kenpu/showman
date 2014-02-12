define(["jquery", "marked", "js/ng/app"], function($, marked) {
    //the jquery.alpha.js and jquery.beta.js plugins have been loaded.
    $(function() {
        $('body').append("jQuery loaded");
        marked.setOptions({
            gfm: true
        });
        $("body").append(marked("I am *great*."));
    });
});