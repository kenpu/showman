<html>
    <head>{{template "header.html" .}}</head>
    <body style="margin-top: 50px">
        {{template "fragments/navbar.html" .}}
        <div class="container">
            <h1 style="font-size: 16pt; font-weight: bold; border-bottom: thin solid black">Articles</h1>

            <filelist resource="/index/"></filelist>
        </div>
        <script>
        var app = angular.module("app", ["commonDirectives"]);
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
        });
        angular.bootstrap($("html"), ["app"])
        </script>
    </body>
</html>