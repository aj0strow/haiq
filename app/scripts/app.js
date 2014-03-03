(function () {
  var haiq = angular.module('haiq', [ 'ngRoute', 'syllablesCount' ]);

  haiq.config([ '$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/recent', { controller: 'recentController', templateUrl: '/recent' })
      .when('/me', { controller: 'meController', templateUrl: '/me' })
      .otherwise({ redirectTo: '/recent' });
  } ]);

  function recent($scope, $http) {
    $scope.haikus = [];

    $http.get('/haikus/paginate').success(function (data) {
      console.log(data);
      $scope.haikus.concat(data);
    });
  }

  haiq.controller('recentController', [ '$scope', '$http', recent ]);

  function me($scope, $http) {
    $scope.first = '';
    $scope.second = '';
    $scope.third = '';
    $scope.haikus = [];
  }

  haiq.controller('meController', [ '$scope', '$http', me ]);
})();
