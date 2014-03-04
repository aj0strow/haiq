(function () {
  var haiq = angular.module('haiq', [ 'ngRoute', 'syllablesCount', 'infinite-scroll' ]);

  haiq.config([ '$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/recent', { controller: 'recentController', templateUrl: '/recent' })
      .when('/me', { controller: 'meController', templateUrl: '/me' })
      .otherwise({ redirectTo: '/recent' });
  } ]);

  function recent($scope, $http) {
    $scope.haikus = [];
  
    $scope.url = function (haiku) {
      var url = '/haikus/paginate';
      if (haiku && haiku.id) url += '/' + haiku.id;
      return url;
    };

    $scope.fetch = function () {
      var haikus = $scope.haikus;
      var url = $scope.url(haikus[haikus.length - 1]);
      $http.get(url).then(function (result) {
        haikus.push.apply(haikus, result.data);
      });
    };

    $scope.fetch();
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

    $http.get('')
  }

  haiq.controller('meController', [ '$scope', '$http', me ]);
})();
