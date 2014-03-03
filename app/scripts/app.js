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

    $http.get('/haikus/paginate').then(function (result) {
      $scope.haikus.push.apply($scope.haikus, result.data);
    });
  }

  haiq.controller('recentController', [ '$scope', '$http', recent ]);

  function me($scope, $http) {
    $scope.first = '';
    $scope.second = '';
    $scope.third = '';
    $scope.haikus = [];

    $scope.create = function () {
      var haiku = { first: $scope.first, second: $scope.second, third: $scope.third };
      function oncreate(response) {
        $scope.haikus.push(response.data);
        $scope.first = $scope.second = $scope.third = '';
        $scope.newHaiku.$setPristine();
      }
      function onfail(response) {
        console.log(response);
      }
      $http.post('/haikus', haiku).then(oncreate, onfail);
    }
  }

  haiq.controller('meController', [ '$scope', '$http', me ]);
})();
