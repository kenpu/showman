define(["jquery", "angular", "angular-resource", "angular-sanitize"], function($, angular) {
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
    ;
});