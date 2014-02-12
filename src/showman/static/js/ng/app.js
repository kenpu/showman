define(["jquery", "angular", "marked", "mathjax"], function($, angular, marked) {
    var app = angular.module("g4iApp", []);    
    app.directive("icon", function() {
        return {
            restrict: "E",
            template: '<i class="fa fa-download"></i>'
        }
    });

    app.directive("md", function() {
        return {
            restrict: "E",
            link: function(scope, element, attributes) {
                var md = attributes.content;
                var html = marked(md);
                element.html(html);
                MathJax.Hub.Queue(["Typeset", MathJax.Hub, element[0]]);
            }
        }
    });

    $(function() {
        angular.bootstrap($("html"), ["g4iApp"]);
    });
});
