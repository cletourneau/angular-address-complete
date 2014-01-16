ac = angular.module('ac-address-complete', [])

ac.directive 'acAddressComplete', ->

  restrict: 'A'

  scope:
    models: '=acModels'
    options: '=acOptions'
    onPopulate: '&acOnPopulate'

  link: (scope, element, attrs)->
    elementId = attrs.id

    control = new pca.Address([{ element: elementId, mode: pca.fieldMode.SEARCH }], scope.options)

    control.listen("populate", (address)->
      toApply = ""
      for model in scope.models
        toApply += "#{model.model} = '#{address[model.acField]}';\n"

      scope.$parent.$apply(toApply)

      scope.onPopulate?({address: address})
    )

