Shell = require \shelljs/global
Dir   = require \./constants .dir

module.exports = ->
  if test \-e pjson = "#{Dir.BUILD}/package.json"
    cp \-f pjson, Dir.ROOT
    cp \-f pjson, Dir.build.SITE
  cp \-f "#{Dir.ROOT}/readme.md" Dir.build.SITE
