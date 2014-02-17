<!DOCTYPE html>

<html>
    <head>{{template "header.html" .}}</head>
    <body style="margin-top: 50px;" ng-controller="Ctrl">
        {{template "fragments/navbar.html" .}}
        <ul navbar style="display:none">
            <li class="active"><a href="#">({{.Filename}})</a></li>
        </ul>

        <lego></lego>

        <script>
        requirejs(["jquery", "angular", "js/ng/directives", "js/ng/controllers"], function($, angular) {
            var ESCAPE = 27;

            var app = angular.module("app", ["commonDirectives", "commonControllers"]);
            app.controller('Ctrl', function($scope, $http) {
                $scope.content = {};
                // fetch the file
                $http.get('/api/file/{{.Filename}}')
                .success(function(data) {
                    if(! data.error) {
                        $scope.content = data;
                    } else {
                        alert(data.error);
                    }
                });
            });

            app.directive("lego", function() {
                return {
                    restrict: 'E',
                    templateUrl: "/partials/lego.html",
                    replace: true,
                    link: function(scope, element, attrs) {
                        scope.Edit = function(span) {
                            span._editing = true;
                        };
                        scope.SpanInsertBefore = function(span) {
                            findRow(span, function(row, idx) {
                                row.spans.splice(idx, 0, newSpan());
                            });
                        };
                        scope.SpanInsertAfter = function(span) {
                            findRow(span, function(row, idx) {
                                console.debug("SpanInsertAfter at idx=",idx);
                                row.spans.splice(idx+1, 0, newSpan());
                            })
                        };
                        scope.SpanDelete = function(span) {
                            findRow(span, function(row, idx) {
                                if(row.spans.length == 1) {
                                    alert("Cannot delete the only span.");
                                } else {
                                    row.spans.splice(idx, 1);
                                }
                            })
                        };
                        scope.SpanMoveBefore = function(span) {
                            findRow(span, function(row, idx) {
                                var neighbor = row.spans[idx-1];
                                if(idx > 0) row.spans.splice(idx-1, 2, span, neighbor);
                            });
                        }
                        scope.SpanMoveAfter = function(span) {
                            findRow(span, function(row, idx) {
                                if(idx < row.spans.length-1) {
                                    var neighbor = row.spans[idx+1];
                                    row.spans.splice(idx, 2, neighbor, span);
                                }
                            });
                        }
                        scope.RowInsertBefore = function(row) {
                            forRow(row, function(i) {
                                scope.content.rows.splice(i, 0, newRow());
                            });
                        }
                        scope.RowInsertAfter = function(row) {
                            forRow(row, function(i) {
                                scope.content.rows.splice(i+1, 0, newRow());
                            })
                        }

                        function findRow(span, f) {
                            if(scope.content && scope.content.rows)
                                for(var i=0; i < scope.content.rows.length; i++) {
                                    var row = scope.content.rows[i];
                                    var idx = row.spans.indexOf(span);
                                    if(idx >= 0) {
                                        f(row, idx);
                                        break;
                                    } else {
                                        console.debug("Oops, span not found.", span);
                                    }
                                }
                        }
                        function forRow(row, f) {
                            if(scope.content && scope.content.rows) {
                                var idx = scope.content.rows.indexOf(row);
                                if(idx >= 0) {
                                    f(idx);
                                } else {
                                    console.debug("Oops, row not found", row);
                                }
                            }
                        }
                        function newSpan() {
                            var id = scope.content.lastId + 1;
                            scope.content.lastId += 1;
                            return {
                                id: id,
                                span: 4,
                                markdown: "Your _markdown_ goes **here**.",
                            }
                        }
                        function newRow() {
                            return {
                                spans: [ newSpan() ]
                            }
                        }

                        scope.KeyPress = function(e, span) {
                            if(e.which == ESCAPE) {
                                span._editing = false;
                            }
                        }
                    }
                }
            })

            angular.bootstrap($("html"), ["app"])
        });
        </script>
    </body>
</html>
