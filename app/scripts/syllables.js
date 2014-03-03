(function () {
  var syllablesCount = angular.module('syllablesCount', []);

  function present(s) {
    return s.length > 0;
  }

  function add(memo, val) {
    return Math.max(memo, memo + val);
  }

  function sanitize(line) {
    return line.replace(/[-_/]/g, ' ').replace(/[^\w\s]/g, '');
  }

  syllablesCount.directive('syllables', [ '$q', '$http', function ($q, $http) {
    function fetchWord(word) {
      var deferred = $q.defer();
      var params = { w: word };
      var req = $http.get('/word', { params: params });
      req.then(function (response) {
        deferred.resolve(response.data.syllables);
      }, function (response) {
        deferred.reject(response.data.error);
        console.log(response.data.error);
      });
      return deferred.promise;
    }

    function fetchLine(line) {
      var words = sanitize(line).split(/\s+/).filter(present);
      return $q.all(words.map(fetchWord)).then(function (counts) {
        return counts.reduce(add, 0);
      });
    }

    function link(scope, element, attrs, ngModel) {
      if (!ngModel) return; 

      function counted(syllables) {
        ngModel.$setValidity('syllables', syllables == attrs.syllables);
      }

      function unknown(error) {
        console.log('Word unkown: ' + error);
        ngModel.$setValidity('syllables', false);
      }

      element.on('keyup', function () {
        fetchLine(element.val()).then(counted, unknown);
      });

      counted(0);
    }

    return { 
      require: 'ngModel',
      link: link 
    };
  } ]);
})();