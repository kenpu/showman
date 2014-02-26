<!DOCTYPE html>

<html>
    <head>{{template "header.html" .}}</head>
    <body style="margin-top: 50px;" ng-controller="Ctrl">
        {{template "fragments/navbar.html" .}}
        <ul navbar style="display:none">
            <li class="active"><a href="#">{{.Filename}}</a></li>
        </ul>

        <lego style="padding-top: 50px;"></lego>

        <script>
        var ESCAPE = 27;

        var app = angular.module("app", ["commonDirectives"]);
        app.controller('Ctrl', function($scope, $http) {
            $scope.content = {};
            $scope.filename = "{{.Filename}}"
            // build the edit URL
            $scope.editUrl = function(span) {
                var url = sprintf("/editor/%s/%d", $scope.filename, span.id);
                return url;
            };

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

                    // start the editing window for this particular element
                    scope.Edit = function(span) {
                        var w = window.open(scope.editUrl(span), "__editor__");
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
                    scope.SpanGrow = function(span, delta) {
                        if(delta) {
                            span.span += delta;
                        }
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
                    scope.RowMoveBefore = function(row) {
                        forRow(row, function(i) {
                            if(i > 0) {
                                var neighbor = scope.content.rows[i-1];
                                scope.content.rows.splice(i-1, 2, row, neighbor);
                            }
                        })
                    }
                    scope.RowMoveAfter = function(row) {
                        forRow(row, function(i) {
                            if(i < scope.content.rows.length-1) {
                                var neighbor = scope.content.rows[i+1];
                                scope.content.rows.splice(i, 2, neighbor, row);
                            }
                        })
                    }
                    scope.RowAppend = function(row) {
                        row.spans.push(newSpan(row));
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
                    function newSpan(row) {
                        var id = scope.content.lastId + 1;
                        scope.content.lastId += 1;
                        var w = 4; // default width for the new span.
                        if(row) {
                            w = 12 - row.spans.reduce(function(x, span) { return x + span.span; }, 0);
                            if(w < 1) w = 1;
                        }
                        return {
                            id: id,
                            span: w,
                            markdown: "Your _markdown_ goes **here**.",
                        }
                    }
                    function newRow() {
                        var row = { spans: [] };
                        var span = newSpan(row);
                        row.spans.push(span);
                        return row;
                    }
                }
            }
        });

        app.directive('spanControls', function() {
            return {
                restrict: 'E',
                templateUrl: '/partials/lego-spancontrols.html',
                replace: true,
            }
        });
        app.directive('rowControls', function() {
            return {
                restrict: 'E',
                templateUrl: '/partials/lego-rowcontrols.html',
                replace: true,
            }
        });

        angular.bootstrap($("html"), ["app"]);
        </script>
    </body>
</html>
