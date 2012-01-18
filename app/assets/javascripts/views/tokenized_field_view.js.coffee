#= require tagit/tag-it

class Ask.TokenizedFieldView extends Batman.View
  render: ->
    node = @get('node')
    tags = jQuery(node).tagit
      onTagAdded: @tagAdded
      onTagRemoved: @tagRemoved
      singleField: true
      singleFieldNode: node

    keypath = node.getAttribute('data-bind')
    node.removeAttribute('data-bind')

    @binding = new Batman.DOM.Binding(node, keypath, @context, {})
    @binding.nodeChange = ->
      @set 'filteredValue', tags.tagit('assignedTags')

    super

  tagAdded: =>
    @binding._fireNodeChange()
  tagRemoved: =>
    @binding._fireNodeChange()
