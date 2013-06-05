class Dashing.Activity extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"

  Batman.mixin Batman.Filters,
  displayDate: (ad) ->
    return undefined if typeof ad is 'undefined'
    activityDate = new Date(ad)
    return activityDate.toDateString()