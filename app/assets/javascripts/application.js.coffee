# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http://example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.

#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require rickshaw/rickshaw.min

# Batman.js and its adapters
# w= require batman/batman
# w= require batman/batman.jquery
# w= require batman/batman.rails

#= require batman_dev/batman
#= require batman_dev/batman.jquery
#= require batman_dev/extras/batman.rails

#= require helpers/pluralize_helper
#= require ask

#= require ./models/model
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./helpers

#= require_tree .

#Batman.mixin Batman.config,
  #usePushState: yes

# Run the Batman app
$(document).ready ->
  Ask.run()
