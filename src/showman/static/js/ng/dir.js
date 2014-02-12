define(["jquery", "angular", "angular-resource"], function($, angular) {
    var app = angular.module("dirApp", ["ngResource"]);

    app.directive('filelist', function($http) {
        return {
            restrict: "E",
            templateUrl: "/partials/filelist.html",
            replace: true,
            link: function($scope, element, attrs) {
                $http.post('/dir').success(function(data) {
                    $scope.paths = data.paths;
                });
            }
        }
    })
});