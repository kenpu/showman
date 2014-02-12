define(["jquery", "marked", "angular", "angular-resource", "angular-sanitize"], function($, marked, angular) {
    var app = angular.module("commonDirectives", ["ngResource", "ngSanitize"]);
    app.directive('filelist', function($http) {
        return {
            restrict: "E",
            templateUrl: "/partials/filelist.html",
            replace: true,
            link: function($scope, element, attrs) {
                $http.post(attrs.resource).success(function(data) {
                    $scope.files = data.files;
                });
            }
        }
    })
    .directive('editor', function($http) {
        return {
            restrict: "E",
            templateUrl: "/partials/editor.html",
            replace: true,
            link: function(scope, element, attrs) {
                var getUrl = "/api/file/" + attrs.filename;
                $http.get(getUrl).success(function(data) {
                    scope.data = data;
                });
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
});