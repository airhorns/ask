#= require tagit/tag-it

class Ask.TokenizedFieldView extends Batman.View

  class @TagitBinding extends Batman.DOM.Binding
    bindImmediately: false

    constructor: ->
      super
      node = @get('node')
      @tagIt = jQuery(node).tagit
        onTagAdded: @tagAdded
        onTagRemoved: @tagRemoved
        singleField: true
        singleFieldNode: node

      @bind()

    nodeChange: ->
      @set 'filteredValue', @tagIt.tagit('assignedTags')

    dataChange: (newTags) ->
      @tagIt.tagit('removeAll')
      newTags?.forEach (tag) =>
        @tagIt.tagit('createTag', tag)

    tagAdded: =>
      @_fireNodeChange()

    tagRemoved: =>
      @_fireNodeChange()

  render: ->
    node = @get('node')
    keypath = node.getAttribute('data-keypath')
    @binding = new @constructor.TagitBinding(node, keypath, @context, {})
    super

