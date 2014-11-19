Dweet.factory 'Video', ['$resource', ($resource) ->

  return $resource '/videos/:id.json', id: '@id',
    update:
      method: 'PUT'
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }

]