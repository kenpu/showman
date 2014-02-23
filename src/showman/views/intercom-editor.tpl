<!DOCTYPE html>

<html>
    <head>
    {{template "header.html" .}}
    <style>
        textarea {
            position: fixed;
            width: 100%;
            height: 400px;
            bottom: 0;
            left: 0;
        }
    </style>
    </head>
    <body style="margin-top: 50px" ng-controller="Ctrl">
        {{template "fragments/navbar.html" .}}
        <ul navbar>
            <li><a href="#">{{.Filename}} ({{.SpanId}})</a></li>
        </ul>
        <textarea autofit></textarea>

        <script>
        var app = angular.module("app", ["commonDirectives"]);
        app.controller('Ctrl', function($scope, $window) {
            $scope.height = $window.innerHeight;
            $window.onresize = function() {
                $scope.$apply(function() {
                    $scope.height = $window.innerHeight;
                });
            }
        });
        app.directive("autofit", function($window) {
            return function(scope, element, attr) {
                scope.$watch('height', function(h) {
                    console.debug("h = ", h)
                    element.css('height', h-50);
                });
                element.focus();
            }
        });
        angular.bootstrap($("html"), ["app"]);
        </script>
    </body>
</html>
