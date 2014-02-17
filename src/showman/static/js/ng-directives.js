(function($, marked, angular) {
    var app = angular.module("commonDirectives", ["ngResource", "ngSanitize"]);
    app.directive('navbar', function() {
        return {
            restrict: "A",
            link: function(scope, element, attrs) {
                var insert = $("#my_navbar_insert");
                if(insert.size() > 0) {
                    element.addClass("nav navbar-nav");
                    element.remove();
                    insert.after(element);
                    element.show();
                }
            }
        }
    })
    .directive('md', function() {
        return {
            restrict: 'E',
            template: "<div></div>",
            replace: true,
            link: function(scope, element, attrs) {
                attrs.$observe('markdown', function(markdown) {
                    var html = marked(markdown);
                    element.html(html);
                });
            }
        }
    })
    ;
})($, marked, angular);