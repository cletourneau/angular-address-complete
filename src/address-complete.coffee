ac = angular.module('fa-address-complete', [])

ac.directive 'faAddressComplete', ->

  restrict: 'A'

  scope:
    fields: '=faFields'
    options: '=faOptions'
    onPopulate: '&faOnPopulate'

  link: (scope, element)->
    control = new pca.Address(scope.fields, scope.options)

    control.listen("populate", (address)->
      for field in scope.fields
        mode = field.mode
        if mode == pca.fieldMode.POPULATE or mode == pca.fieldMode.DEFAULT
          id = field.element
          $("##{id}").trigger('change')

      scope.onPopulate?({address: address})
    )

