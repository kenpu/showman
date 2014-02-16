<!DOCTYPE html>

<html>
    <head>{{template "header.html" .}}</head>
    <body style="margin-top: 50px;" ng-controller="Ctrl">
        <textarea ng-model="markdown"></textarea>
        <button>Save</button>
        <style>
        textarea {
            width: 100%;
            height: 600px;
            background: #444;

        }
        button {
            float; right;
        }
        </style>
        <script>
        requirejs(["jquery", "angular", "intercom", "js/ng/directives", "js/ng/controllers"], function($, angular, Intercom) {
            console.debug("Intercom is here", Intercom.getInstance());
            var app = angular.module("app", ["commonDirectives", "commonControllers"]);
            app.controller('Ctrl', function($scope) {
                $scope.markdown = "";
                var intercom = Intercom.getInstance();
                intercom.on('ping-editor', function() {
                    intercom.emit('editor-alive');
                });
                intercom.on('request', function(data) {
                    $scope.$apply(function() {
                        $scope.markdown = data;
                    })
                });
            });
            angular.bootstrap($("html"), ["app"])
        });
        </script>
    </body>
</html>
