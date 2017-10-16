#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .

window.Utility = {}
window.Utility.paperSetup = (id, op) ->
  dom = if typeof id == 'string' then $('#' + id) else id
  # w = dom.parent().height()
  if op and op.width then dom.parent().width(op.width+1)
  if op and op.width then dom.width(op.width+1)
  if op and op.height then dom.parent().height(op.height+1)
  if op and op.height then dom.height(op.height)
  # dom.attr 'height', w
  # dom.attr 'width', '90px'
  paper.install window
  myPaper = new (paper.PaperScope)
  myPaper.setup dom[0]
  # if typeof id == 'string'
  #   console.info 'Paper.js installed on', id, w, 'x', h
  # else
  #   console.info 'Paper.js installed:', w, 'x', h
  myPaper

window.rgb2hex = (rgb) ->
  rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i)
  if rgb and rgb.length == 4 then '#' + ('0' + parseInt(rgb[1], 10).toString(16)).slice(-2) + ('0' + parseInt(rgb[2], 10).toString(16)).slice(-2) + ('0' + parseInt(rgb[3], 10).toString(16)).slice(-2) else ''

